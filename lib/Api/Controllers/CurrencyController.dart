import 'package:coinz_app/network/end_points.dart';
import 'package:dio/dio.dart';
import 'package:coinz_app/Api/DioHelper.dart';

class CurrencyController{

   static Future<Response> getCurrencyList({Map<String, dynamic>? map}){
     return DioHelper().get(CURRENCIES_LIST ,queryParameters: map) ;
   }
}
