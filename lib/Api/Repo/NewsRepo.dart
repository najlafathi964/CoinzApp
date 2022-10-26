import 'package:coinz_app/Api/Controllers/NewsController.dart';
import 'package:coinz_app/models/TNews.dart';
import 'package:dio/dio.dart';

class NewsRepo {
  static var instance = NewsRepo();

  Future<List<News>> getNewsRequest() async {
    Response response = await NewsController.getNewsList();
    List<News> newsList =[] ;

    if(response.statusCode == 200){
      newsList =  List<News>.from(response.data['news'].map((element)=>News.fromJson(element)));
    }
    return  newsList;
  }

}