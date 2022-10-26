import 'dart:async';

import 'package:coinz_app/modules/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<Color> beginColors = [Color(0xffFFA500) , Color(0xff9B81EC) , Color(0xff478EDA) , Color(0xff02DFB6)] ;

  List<Color> endColors = [Color(0xffFFDB00) , Color(0xffFB79B4) , Color(0xff58C4D8) , Color(0xff47E546)] ;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge , overlays:[SystemUiOverlay.bottom , ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor : Colors.transparent));
    //SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values) ;
    Timer(const Duration(seconds: 3 ),
            ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GridView.builder(
            padding: EdgeInsets.zero,
               physics: NeverScrollableScrollPhysics(),
            itemCount: 4,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2 ,
                childAspectRatio: MediaQuery.of(context).size.width/MediaQuery.of(context).size.height
              ),
            itemBuilder: (context ,index) => Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: AlignmentDirectional.topEnd ,
                  end: AlignmentDirectional.bottomStart ,
                  colors:[ beginColors[index] , endColors[index] ]
                )
              ),
            )),
          Center(
            child: Text('بلوك\nتشين' , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 24),),
          ) ,
          Positioned(
              top:MediaQuery.of(context).size.height/1.5,
              right: MediaQuery.of(context).size.width/3.3,
              child: Container(
                child: SvgPicture.asset(
                    'assets/images/splash-icon.svg' ,),
              ))
        ],
      ),
    );
  }
}
