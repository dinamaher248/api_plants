import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio();

  Future<List<dynamic>> fetchData() async {
    const String apiUrl =
        'https://trefle.io/api/v1/plants?token=8fRiQCbYgtb7iurDFU0F-FJ1paBMWJfbAsDc5d_Vif8&q=rose';

    try {
      final response = await dio.get(apiUrl);
      if (response.statusCode == 200) {
        print('Response: ${response.data}');
      }
      return response.data['data'];
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to fetch plants: $e');
    }
  }
}
