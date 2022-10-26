import 'package:flutter/material.dart';

Widget bigText({
  required BuildContext context ,
  Color? color ,
  required String text ,
  double size =0 ,
  TextOverflow textOverflow = TextOverflow.ellipsis
}) => Text( '$text' ,
  style:Theme.of(context).textTheme.bodyText1!.copyWith(
      color: color ,
      fontSize: size==0?20 :size,
      fontWeight: FontWeight.bold
  )

);

Widget smallText({
  required BuildContext context ,
  Color? color  ,
  required String text ,
  double hight =1.2 ,
  double size =12 ,
}) => Text( '$text' ,
  style:Theme.of(context).textTheme.bodyText1!.copyWith(
      color: color ,
      fontSize:size,
      height: hight
  )


);


