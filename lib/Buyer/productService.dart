// lib/services/product_service.dart
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/product.dart';

class ProductService {
  Future<List<Product>> fetchProducts() async {
    final response = await rootBundle.loadString('assets/products.json');
    final data = jsonDecode(response) as List;

    return data.map((json) => Product(
      id: json['id'],
      name: json['name'],
      img: json['img'],
      price: json['price'],
      noOfRents: json['num_of_rents'],
      brand: json['brand'],
      avgRating: json['avg_rating'], 
    )).toList();
  }
}
