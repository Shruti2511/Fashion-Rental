import 'package:flutter/material.dart';
import 'package:hackathon/Buyer/home.dart';
import 'package:hackathon/Seller/sellerPage.dart';

class StartingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Choose Role'),
      ), 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Text('Buyer'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SellerPage()),
                );
              },
              child: Text('Seller'),
            ),
          ],
        ),
      ),
    );
  }
}
