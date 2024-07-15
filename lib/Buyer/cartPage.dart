import 'package:flutter/material.dart';

class AddToCartPage extends StatefulWidget {
  final String imageUrl;

  AddToCartPage({required this.imageUrl});

  @override
  _AddToCartPageState createState() => _AddToCartPageState();
}

class _AddToCartPageState extends State<AddToCartPage> {
  double itemPrice = 50.0; // Example price
  double tax = 0.1; // Example tax rate (10%)
  double cashpoints = 10.0; // Example cashpoints available

  DateTime currentDate = DateTime.now();
  DateTime deliveryDate = DateTime.now().add(Duration(days: 5));

  DateTime minReturnDate = DateTime.now().add(Duration(days: 7)); // Two days after delivery
  DateTime maxReturnDate = DateTime.now().add(Duration(days: 19)); // 14 days after two days after delivery
  DateTime? selectedReturnDate; // Nullable DateTime for selected return date

  bool showCashpoints = false;

  @override
  Widget build(BuildContext context) {
    double totalPrice =
        itemPrice + (itemPrice * tax) - (showCashpoints ? cashpoints : 0);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add to Cart',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: SizedBox(
                  height: 200,
                  child: Image.asset(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Item Name',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Price:',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '\$${itemPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tax:',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '\$${(itemPrice * tax).toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Visibility(
                visible: showCashpoints,
                child: SizedBox(height: 8.0),
              ),
              Visibility(
                visible: showCashpoints,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Cashpoints:',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '\$${cashpoints.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    showCashpoints = !showCashpoints;
                  });
                },
                child: Text(showCashpoints ? 'Remove Cashpoints' : 'Apply Cashpoints'),
              ),
              SizedBox(height: 16.0),
              Text(
                'Expected Delivery: ${deliveryDate.day}/${deliveryDate.month}/${deliveryDate.year}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Text(
                    'Return by:',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 10),
                  DropdownButton<DateTime>(
                    value: selectedReturnDate,
                    onChanged: (DateTime? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedReturnDate = newValue;
                        });
                      }
                    },
                    items: List.generate(
                      maxReturnDate.difference(minReturnDate).inDays + 1,
                      (index) {
                        DateTime date =
                            minReturnDate.add(Duration(days: index));
                        return DropdownMenuItem<DateTime>(
                          value: date,
                          child:
                              Text('${date.day}/${date.month}/${date.year}'),
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Payment functionality
                },
                child: Text('Proceed to Payment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
