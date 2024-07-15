import 'package:flutter/material.dart';

class LikedScreen extends StatelessWidget {
  final List<String> likedImages; // List of image URLs
  final int points;

  LikedScreen({
    required this.likedImages,
//     required this.dislikedImages,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    double cashPoints = points * 0.01;
    
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Liked Images',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(212, 238, 108, 193),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Swipe Points: $points',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 36),
                        Text(
                          'Cash Points: $cashPoints',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 8.0,
                            crossAxisSpacing: 8.0,
                          ),
                          itemCount: likedImages.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                _showImageDetails(context, likedImages[index]);
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    likedImages[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          }))
                ])));
  }
}

void _showImageDetails(
    BuildContext context, String imageUrl) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Color.fromARGB(255, 220, 210, 250),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(168, 255, 255, 255),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
                    child: Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 14),
                        SizedBox(width: 2),
                        Text('4.5',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                        SizedBox(width: 4),
                        Text('(4.3k)', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.0),
            Text(
              'Price: \$3699.24', // Replace with actual price fetched from data
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Add to cart functionality
                  },
                  icon: Icon(Icons.shopping_bag),
                  label: Text('Add to Shopping Bag'),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
