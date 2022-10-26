import 'package:coinz_app/network/end_points.dart';
import 'package:dio/dio.dart';
import '../Application.dart';

Dio DioHelper(){
  Dio dio = Dio();
  dio.options.receiveTimeout =4000 ;
  dio.options.connectTimeout = 5000 ;
  dio.options.baseUrl =BASE_URL ;
  dio.options.headers={
    'X-Client-Device-UDID' :Application.uid
  };
  return dio ;
}