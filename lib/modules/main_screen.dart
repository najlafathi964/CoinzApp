import 'package:coinz_app/Application.dart';
import 'package:coinz_app/cubit/app_cubit.dart';
import 'package:coinz_app/cubit/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Application.init() ;

    print('uuid ${Application.uid}');
    return BlocConsumer<CoinzCubit, CoinzState>(
        listener: (context, state) => {},
        builder: (context, state) {
          CoinzCubit cubit = CoinzCubit.get(context);
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                      onPressed: () {
                        cubit.changeAppMode() ;
                      },
                      icon: const Icon(Icons.brightness_4_outlined ,)
                  )                ],
              ),
              body: cubit.screens[cubit.currentIndex],
              bottomNavigationBar: SizedBox(
                //height: 85,
                child: BottomNavigationBar(
                  items: cubit.bottomItems,
                  currentIndex: cubit.currentIndex,
                  onTap: (index) {
                    cubit.changeBottomNavBar(index);
                  },
                ),
              ),
            ),
          );
        });
  }
}


