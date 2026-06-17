import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioClient {
  static final Dio instance = Dio(
    BaseOptions(
      baseUrl: 'https://api.rawg.io/api',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      queryParameters: {
        'key': dotenv.env['RAWG_API_KEY'] ?? '',
      },
    ),
  );
}