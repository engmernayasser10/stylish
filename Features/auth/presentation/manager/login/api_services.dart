import 'package:dio/dio.dart';

class ApiServices {
  final Dio _dio = Dio();
  Future<List<String>> fetchProducts({required int offset, required int limit}) async {
    try {
      final response = await _dio.get('https://api.escuelajs.co/api/v1/products', 
      queryParameters: {'offset': offset, 'limit': limit});
    
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data
        .map((product) => product['title'].toString())
        .toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}