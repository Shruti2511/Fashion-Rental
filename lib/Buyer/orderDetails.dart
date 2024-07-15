import 'package:flutter/material.dart';

class OrderBottomSheet extends StatelessWidget {
  final Map<String, dynamic> order;

  OrderBottomSheet({required this.order});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 1.0,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Track Item',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  Text(
                    'Tracking no: ${order['trackingNumber']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                ),
                              ),
                              Container(
                                width: 4,
                                height: 50,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Return of product',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Return on 3 Apr',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      ...order['trackingSteps'].map<Widget>((step) {
                        final isCompleted = step['isCompleted'];
                        return Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isCompleted
                                        ? Colors.green
                                        : Colors.grey,
                                  ),
                                ),
                                Container(
                                  width: 4,
                                  height: 50,
                                  color:
                                      isCompleted ? Colors.green : Colors.grey,
                                ),
                              ],
                            ),
                            SizedBox(width: 8.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    step['status'],
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    step['date'],
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
