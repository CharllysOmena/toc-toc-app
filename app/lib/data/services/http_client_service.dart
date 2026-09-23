import 'package:dio/dio.dart';

abstract class HttpClientService {
  Dio get client;
}

class HttpClientServiceImpl implements HttpClientService {
  HttpClientServiceImpl({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  @override
  Dio get client => _dio;
}
