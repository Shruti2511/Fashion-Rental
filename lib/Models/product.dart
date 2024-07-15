import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final String img;
  final String brand;
  final double price;
  final int noOfRents;
  final double avgRating;

  Product({
    required this.id,
    required this.name,
    required this.img,
    required this.brand,
    required this.price,
    required this.noOfRents,
    required this.avgRating,
  });

  factory Product.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Product(
      id: doc.id,
      name: data['name'] ?? '',
      img: data['img'] ?? '',
      brand: data['brand'] ?? '',
      price: data['price']?.toDouble() ?? 0.0,
      noOfRents: data['No of rents'] ?? 0,
      avgRating: data['avg_rating']?.toDouble() ?? 0.0,
    );
  }
}
