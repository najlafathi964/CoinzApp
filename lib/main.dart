import 'package:coinz_app/cubit/app_cubit.dart';
import 'package:coinz_app/cubit/app_state.dart';
import 'package:coinz_app/modules/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coinz_app/network/local/cach_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CachHelper.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final bool? isDark = CachHelper.getData(key: 'isDark');

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CoinzCubit()
        ..changeAppMode(dark: isDark)
        ..getCoinsData()
        ..getNews()
        ..getTriggers()
         ..getFav()
        ..loadMore()
      ,
      child: BlocConsumer<CoinzCubit, CoinzState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
          home: SplashScreen(),
          debugShowCheckedModeBanner: false,
          theme: lightTheme(),
          darkTheme: darkTheme(),
          themeMode:
              CoinzCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
        );}
      ),
    );
  }

  ThemeData lightTheme() {
    return ThemeData(
        appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            elevation: 0,
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark)),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            elevation: 0),
        textTheme: const TextTheme(
            bodyText1: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
        )),
        scaffoldBackgroundColor: Colors.white);
  }

  ThemeData darkTheme() {
    return ThemeData(
      //    primarySwatch: Colors.deepOrange,
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          //HexColor('333739'),
          elevation: 0,
          titleSpacing: 20,
          titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.black, //       HexColor('333739'),
            statusBarIconBrightness: Brightness.dark,
          )),
      iconTheme: const IconThemeData(color: Colors.white),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          // HexColor('333739'),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          elevation: 20),
      textTheme: const TextTheme(bodyText1: TextStyle(color: Colors.white)),
      scaffoldBackgroundColor: Colors.black, //HexColor('333739'),
    );
  }
}
