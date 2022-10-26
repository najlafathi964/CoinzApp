import 'package:coinz_app/Api/Controllers/CurrencyController.dart';
import 'package:coinz_app/models/TCoinz.dart';
import 'package:dio/dio.dart';

class CurrencyRepo{
  static var instance = CurrencyRepo();

   Future<List<Currencies>> getCurrencyRequest({Map<String , dynamic>? map} ) async {
    Response response = await CurrencyController.getCurrencyList(map: map);
    List<Currencies> coinzList =[] ;

    if(response.statusCode == 200){
      coinzList =  List<Currencies>.from(response.data['currencies'].map((element)=>Currencies.fromJson(element)));
    }
    return  coinzList;
  }

}