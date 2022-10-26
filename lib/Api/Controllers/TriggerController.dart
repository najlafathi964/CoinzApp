import 'package:coinz_app/Application.dart';
import 'package:coinz_app/network/end_points.dart';
import 'package:dio/dio.dart';
import 'package:coinz_app/Api/DioHelper.dart';
import 'package:uuid/uuid.dart';

class TriggerController{

  static Future<Response> getTriggersList(){
    return DioHelper().get(TRIGGER_LIST) ;
  }

  static Future<Response> addTrigger({required context ,required String name, required int type, required String value}){

    return DioHelper().post(TRIGGER_POST , data: {
      's_code': name,
      'i_type': type,
      'd_value': value,
      's_udid': Application.uid,
      //'s_pns_token': '7gfhg'
    });


  }
}