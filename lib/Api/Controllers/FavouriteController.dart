import 'package:dio/dio.dart';
import 'package:coinz_app/Api/DioHelper.dart';

class FavouritesController{

  static Future<Response> getFavList(){
    return DioHelper().get('/favourites/list') ;
  }
}