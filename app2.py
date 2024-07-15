from flask import Flask, jsonify, request
from flask_cors import CORS
import pandas as pd

app = Flask(__name__)
CORS(app)

# Load CSV data
df = pd.read_csv('DummyMyntraDataset2.csv')

@app.route('/recommendations', methods=['GET'])
def get_recommendations():
    product_id = request.args.get('product_id', type=int)
    if product_id is not None:
        # Filter the dataset for the specified product_id (assuming p_id is the column name)
        product_data = df[df['p_id'] == product_id]
        # Convert the filtered data to a list of dictionaries
        recommendations = product_data.to_dict(orient='records')
    else:
        # If no product_id is specified, return a sample of the data
        recommendations = df.sample(10).to_dict(orient='records')
    
    return jsonify(recommendations)

if __name__ == '_main_':
    app.run(debug=True)