import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_statemanagement/models/product2_model.dart';

final product2RepositoryProvider = Provider((ref) => ProductRepository());

class ProductRepository {
  final dio = Dio();

  Future<List<Product2Model>> getProducts() async {
    try {
      final response = await dio.get('https://api.escuelajs.co/api/v1/products');
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>; // Cast to Map
        final products = data['products'] as List; // Access 'products' key

        return products.map((json) => Product2Model.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch products');
      }
    } catch (e) {
      throw Exception('API error: $e');
    }
  }
}
