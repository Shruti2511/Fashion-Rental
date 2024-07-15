import 'package:flutter/material.dart';
import 'package:hackathon/Seller/sellerProducts.dart';

class SellerPage extends StatefulWidget {
  @override
  _SellerPageState createState() => _SellerPageState();
}

class _SellerPageState extends State<SellerPage> {
  final List<Map<String, dynamic>> products = [
    {"name": "Product 1", "image": "assets/N1.jpg", "total": 12, "rented": 4},
    {"name": "Product 2", "image": "assets/O2.jpg", "total": 51, "rented": 11},
    {"name": "Product 3", "image": "assets/O9.jpg", "total": 27, "rented": 6},
    {"name": "Product 4", "image": "assets/S9.jpg", "total": 10, "rented": 3},
    // Add more products here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Fashion Rental',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.list_alt_outlined, color: Color.fromARGB(213, 255, 68, 190)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SellerProducts(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_bag_outlined, color: Color.fromARGB(213, 255, 68, 190)),
            onPressed: () {
              // Add your functionality here
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'My Products',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3 / 4,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.asset(
                              products[index]["image"],
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            products[index]["name"],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "${products[index]["total"]} in stock",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "${products[index]["rented"]} rented",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Stock Status:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            for (var product in products)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text(
                  "${product["name"]}: ${product["total"]} in stock, ${product["rented"]} rented",
                  style: TextStyle(fontSize: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}


