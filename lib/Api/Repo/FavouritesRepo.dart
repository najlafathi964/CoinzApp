import 'package:coinz_app/models/TFav.dart';
import 'package:dio/dio.dart';

import '../Controllers/FavouriteController.dart';

class FavouritesRepo {
  static var instance = FavouritesRepo();

  Future<List<Favourites>> getFavouriteRequest() async {
    Response response = await FavouritesController.getFavList();
    List<Favourites> favList =[] ;

    if(response.statusCode == 200){
      favList =  List<Favourites>.from(response.data['favourites'].map((element)=>Favourites.fromJson(element)));
    }
    return  favList;
  }

}