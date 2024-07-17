import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class BaseRepository {
  BaseRepository() {
    api = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        validateStatus: (_) => true,
      ),
    );

    api.interceptors.addAll([
      PrettyDioLogger(
        requestBody: true,
        responseHeader: true,
      ),
      InterceptorsWrapper(
        onRequest: (
          RequestOptions request,
          RequestInterceptorHandler handler,
        ) async {
          return handler.next(request);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          return handler.next(response);
        },
        onError: (DioException error, ErrorInterceptorHandler handler) {
          return handler.next(error);
        },
      ),
    ]);

    api.transformer = BackgroundTransformer();
  }

  static const String baseUrl = 'https://hp-api.onrender.com/api';

  late final Dio api;
}
