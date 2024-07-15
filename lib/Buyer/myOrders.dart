import 'package:flutter/material.dart';
import 'package:hackathon/Buyer/orderDetails.dart';

class OrdersPage extends StatelessWidget {
  final List<Map<String, dynamic>> orders = [
    {
      'image': 'assets/O1.jpg',
      'name': 'Summer Outfit',
      'trackingNumber': 'ML0518186323',
      'trackingSteps': [
        {'status': 'Arriving', 'date': 'by Sat, 27 Mar', 'isCompleted': false},
        {'status': 'Item has left Gurgaon transport hub', 'date': 'Fri, 26 Mar, 01:31 p.m', 'isCompleted': false},
        {'status': 'Item has reached Delhi transport hub', 'date': 'Tue, 23 Mar, 09:55 a.m', 'isCompleted': false},
        {'status': 'Shipped', 'date': 'Sun, 21 Mar', 'isCompleted': true},
        {'status': 'Item shipped from Bangalore to delivery centre', 'date': 'Sat, 20 Mar, 03:21 a.m', 'isCompleted': true},
        {'status': 'Item Packed in Bengaluru Warehouse', 'date': 'Sat, 20 Mar, 01:29 p.m', 'isCompleted': true},
      ],
    },
    {
      'image': 'assets/O2.jpg',
      'name': 'Casual Wear',
      'trackingNumber': 'ML0518186324',
      'trackingSteps': [
        {'status': 'Arriving', 'date': 'by Sun, 28 Mar', 'isCompleted': false},
        {'status': 'Item has left Delhi transport hub', 'date': 'Fri, 26 Mar, 02:31 p.m', 'isCompleted': false},
        {'status': 'Item has reached Mumbai transport hub', 'date': 'Tue, 23 Mar, 10:55 a.m', 'isCompleted': false},
        {'status': 'Shipped', 'date': 'Sun, 21 Mar', 'isCompleted': true},
        {'status': 'Item shipped from Delhi to delivery centre', 'date': 'Sat, 20 Mar, 04:21 a.m', 'isCompleted': true},
        {'status': 'Item Packed in Delhi Warehouse', 'date': 'Sat, 20 Mar, 02:29 p.m', 'isCompleted': true},
      ],
    },
    // Add more orders here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              showModalBottomSheet(
                backgroundColor: Color.fromARGB(19, 61, 60, 60),
                context: context,
                isScrollControlled: true,
                builder: (context) => OrderBottomSheet(order: orders[index]),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Colors.white, width: 2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        orders[index]['image'],
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            orders[index]['name'],
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Status: ${orders[index]['trackingSteps'].firstWhere((step) => step['isCompleted'] == false)['status']}',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
