import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:coinz_app/models/TStatus.dart';
import 'package:coinz_app/models/TTrigger.dart';
import 'package:coinz_app/modules/coinz_alert_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../Controllers/TriggerController.dart';

class TriggerRepo {
  static var instance = TriggerRepo();

  Future<List<Condition>> getTriggerRequest() async {
    Response response = await TriggerController.getTriggersList();
    List<Condition> triggersList =[] ;

    if(response.statusCode == 200){
      triggersList =  List<Condition>.from(response.data['condition'].map((element)=>Condition.fromJson(element)));
    }
    return  triggersList;
  }
   TStatus? tStatus ;
  Future<TStatus> addTrigger({required context ,required String name, required int type, required String value}) async {
    Response response ;
    try {
       response= await TriggerController.addTrigger(
         context: context,
          name: name, type: type, value: value);
       if(response.statusCode == 200 || response.statusCode == 422) {
         tStatus = TStatus.fromJson(response.data);
         print(response.data);
       }
    }catch(error){
      tStatus = TStatus.fromJson({
          "status": {
          "success": false,
          "code": 0,
          "message": "التنبيه مضاف مسبقا"
      }});

    }

    ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.success,
          title: '${tStatus!.status!.message }',
        ));

    return tStatus!;
  }


}