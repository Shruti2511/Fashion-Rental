from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.preprocessing import MinMaxScaler
from sklearn.metrics.pairwise import cosine_similarity
import firebase_admin
from firebase_admin import credentials, firestore

# Initialize Flask application
app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///swipes.db'
db = SQLAlchemy(app)

# Initialize Firebase Admin SDK with service account credentials
cred = credentials.Certificate(r'C:\Users\admin\Downloads\fashion-rental-ee377-firebase-adminsdk-22yee-bf124bb20a.json')
firebase_admin.initialize_app(cred)

# Access Firestore database
firestore_db = firestore.client()

# Define the Swipe model
class Swipe(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, nullable=False)
    product_id = db.Column(db.Integer, nullable=False)
    swipe_direction = db.Column(db.String(10), nullable=False)
    timestamp = db.Column(db.DateTime, default=datetime.utcnow)

# Load dataset and prepare the recommendation system
df = pd.read_csv('DummyMyntraDataset2.csv')  # Replace with your dataset file path
columns_to_combine = ['name', 'colour', 'brand', 'Body Shape ID', 'Body or Garment Size', 'Bottom Closure',
                      'Bottom Fabric', 'Bottom Pattern', 'Bottom Type', 'Dupatta', 'Dupatta Border',
                      'Dupatta Fabric', 'Dupatta Pattern', 'Main Trend', 'Neck', 'Number of Pockets',
                      'Occasion', 'Pattern Coverage', 'Print or Pattern Type', 'Sleeve Length',
                      'Sleeve Styling', 'Slit Detail', 'Stitch', 'Sustainable', 'Top Design Styling',
                      'Top Fabric', 'Top Hemline', 'Top Length', 'Top Pattern', 'Top Shape', 'Top Type',
                      'Waistband', 'Wash Care', 'Weave Pattern', 'Weave Type', 'Ornamentation']
df[columns_to_combine] = df[columns_to_combine].fillna('')
df['description'] = df[columns_to_combine].apply(lambda row: ' '.join(row.values.astype(str)), axis=1)

original_numeric_columns = ['No of Right Swipes', 'No of rents', 'ratingCount', 'avg_rating']
df[original_numeric_columns] = df[original_numeric_columns].fillna(0)
numeric_columns = ['No of Right Swipes', 'No of rents', 'ratingCount', 'avg_rating']
scaler = MinMaxScaler()
df[numeric_columns] = scaler.fit_transform(df[numeric_columns])

tfidf = TfidfVectorizer(stop_words='english')
tfidf_matrix = tfidf.fit_transform(df['description'])
tfidf_df = pd.DataFrame(tfidf_matrix.toarray())
combined_features = pd.concat([tfidf_df, df[numeric_columns].reset_index(drop=True)], axis=1)
cosine_sim = cosine_similarity(combined_features)

def get_recommendations(product_index):
    sim_scores = list(enumerate(cosine_sim[product_index]))
    sim_scores = sorted(sim_scores, key=lambda x: x[1], reverse=True)
    sim_scores = sim_scores[1:11]
    product_indices = [i[0] for i in sim_scores]
    return df.iloc[product_indices]

@app.route('/recommendations', methods=['GET'])
def recommendations():
    product_id = int(request.args.get('product_id'))
    recommendations = get_recommendations(product_id)
    results = recommendations.to_dict(orient='records')
    return jsonify(results)

@app.route('/swipe', methods=['POST'])
def swipe():
    data = request.get_json()
    user_id = data['user_id']
    product_id = data['product_id']
    swipe_direction = data['swipe_direction']

    # Save swipe data to Firestore
    swipe_ref = firestore_db.collection('swipes').add({
        'user_id': user_id,
        'product_id': product_id,
        'swipe_direction': swipe_direction,
        'timestamp': datetime.utcnow()
    })

    return jsonify({"message": "Swipe data received"}), 200

if __name__ == '__main__':
    with app.app_context():
        db.create_all()
    app.run()
