import 'package:flutter/material.dart';

class SellerProducts extends StatefulWidget {
  @override
  _SellerProductsState createState() => _SellerProductsState();
}

class _SellerProductsState extends State<SellerProducts> {
  bool isAvailableSelected = true;

  final List<Map<String, dynamic>> availableProducts = [
    {"name": "Product 1", "image": "assets/S8.jpg", "size": "M", "rented": 4},
    {"name": "Product 2", "image": "assets/O12.jpg", "size": "L", "rented": 11},
    {"name": "Product 3", "image": "assets/S4.jpeg", "size": "M", "rented": 15},
    {"name": "Product 4", "image": "assets/N7.jpg", "size": "L", "rented": 9},
    // Add more available products here
  ];

  final List<Map<String, dynamic>> rentedProducts = [
    {"name": "Product 1", "image": "assets/O14.jpg", "size": "M", "userId": "User123"},
    {"name": "Product 2", "image": "assets/S6.jpg", "size": "L", "userId": "User456"},
    {"name": "Product 3", "image": "assets/O15.png", "size": "M", "userId": "User823"},
    {"name": "Product 4", "image": "assets/S1.jpg", "size": "L", "userId": "User376"},
    // Add more rented products here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Seller Products',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.white,
        //iconTheme: IconThemeData(color: Colors.black), toolbarTextStyle: Theme.of(context).textTheme.apply(bodyColor: Colors.black).bodyText2, titleTextStyle: Theme.of(context).textTheme.apply(bodyColor: Colors.black).headline6,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    isAvailableSelected = true;
                  });
                },
                child: Text(
                  'Available',
                  style: TextStyle(
                    color: isAvailableSelected ? Colors.blue : Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    isAvailableSelected = false;
                  });
                },
                child: Text(
                  'Rented',
                  style: TextStyle(
                    color: !isAvailableSelected ? Colors.blue : Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: isAvailableSelected ? buildAvailableList() : buildRentedGrid(),
          ),
        ],
      ),
    );
  }

  Widget buildAvailableList() {
    return ListView.builder(
      itemCount: availableProducts.length + 1,
      itemBuilder: (context, index) {
        if (index == availableProducts.length) {
          return Card(
            elevation: 4,
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text('Add Products'),
              trailing: Icon(Icons.add),
              onTap: () {
                // Add your add product functionality here
              },
            ),
          );
        }
        return Card(
          elevation: 4,
          margin: EdgeInsets.all(10),
          child: ListTile(
            leading: Image.asset(
              availableProducts[index]["image"],
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(availableProducts[index]["name"]),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Size: ${availableProducts[index]["size"]}"),
                Text("Rented: ${availableProducts[index]["rented"]} times"),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildRentedGrid() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 3 / 4,
      ),
      itemCount: rentedProducts.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.asset(
                  rentedProducts[index]["image"],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  rentedProducts[index]["name"],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Size: ${rentedProducts[index]["size"]}",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Rented by: ${rentedProducts[index]["userId"]}",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
