import 'apiModel.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<ApiModel> fetchData() async {
    try {
      final response = await _dio.get('https://api.publicapis.org/entries');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        return ApiModel.fromJson(data);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
