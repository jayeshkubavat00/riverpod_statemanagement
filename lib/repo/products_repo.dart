import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_statemanagement/models/products_model.dart';

final productRepositoryProvider = Provider((ref) => ProductRepository());

class ProductRepository {
  final dio = Dio();

  Future<List<ProductsData>> getProducts() async {
    try {
      final response = await dio.get('https://dummyjson.com/products');
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>; // Cast to Map
        final products = data['products'] as List; // Access 'products' key

        return products.map((json) => ProductsData.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch products');
      }
    } catch (e) {
      throw Exception('API error: $e');
    }
  }
}
