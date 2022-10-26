import 'package:coinz_app/network/end_points.dart';
import 'package:dio/dio.dart';
import 'package:coinz_app/Api/DioHelper.dart';

class NewsController{

  static Future<Response> getNewsList(){
    return DioHelper().get(NEWS_LIST) ;
  }
}