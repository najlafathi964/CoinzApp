import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class Application {
   static String? uid ;
   static  getId() async {
     var deviceInfo =DeviceInfoPlugin();
     if(Platform.isIOS){
       var iosDeviceInfo = await deviceInfo.iosInfo;
       uid = iosDeviceInfo.identifierForVendor;

     }else if (Platform.isAndroid){
       var androidDeviceInfo = await deviceInfo.androidInfo;
       uid = androidDeviceInfo.id ;
     }
   }

   static init(){
     getId();
   }
}