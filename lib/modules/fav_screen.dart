import 'package:coinz_app/cubit/app_cubit.dart';
import 'package:coinz_app/cubit/app_state.dart';
import 'package:coinz_app/models/TCoinz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_table/sliver_table.dart';

import '../widgets/widgets.dart';

class FavScreen extends StatelessWidget {
  List<String> header = ['العملة', 'السعر', 'التداول'];

  FavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = CoinzCubit.get(context);
    List all = [];
    List fav = [];
    List<Currencies> favourites = cubit.getFav();

    for (int i = 0; i < cubit.currencies.length; i++) {
      all.add(cubit.currencies[i].sName!);
    }
    for (int i = 0; i < favourites.length; i++) {
      fav.add(favourites[i].sName);
    }

    final lists = [all, fav];
    final common = lists
        .fold<Set>(
            lists.first.toSet(),
            (previousValue, element) =>
                previousValue.intersection(element.toSet()))
        .toList();
    Color color = Colors.white;
    IconData icon = Icons.favorite_border;
    final SliverTableController _tableController = SliverTableController(
      colsCount: 3,
      rowsCount: cubit.currencies.length,
      cellWidth: MediaQuery.of(context).size.width / 2,
      cellHeight: 50.0,
      topHeaderHeight: 60.0,
      leftHeaderCellWidth: 60,
      topLeftCorner: Container(
        color: Colors.grey[100],
      ),
      topHeaderBuilder: (context, i) {
        return Container(
          alignment: Alignment.center,
          color: Colors.grey[100],
          child: smallText(
              context: context,
              text: header[i],
              color: const Color(0xFFccc7c5)),
        );
      },
      leftHeaderBuilder: (context, i) {
        if (common.contains(cubit.currencies[i].sName)) {
          icon = Icons.favorite;
          color = Colors.grey[300]!;
        } else {
          icon = Icons.favorite_border;
          color = Colors.white;
        }
        return Container(
          color: color,
          child: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    if (common.contains(cubit.currencies[i].sName)) {
                      cubit.removeFav(currency: cubit.currencies[i]);
                    } else {
                      cubit.addFav(currency: cubit.currencies[i]);
                    }
                  },
                  child: Icon(icon, color: Colors.orange[300],)),
              SizedBox(
                width: 5,
              ),
              Text(
                '${i + 1}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
        );
      },
      cellBuilder: (context, row, col) {
        // if( common.contains(cubit.currencies[row].sName)) {
        //   color.add(Colors.orange);
        // }else{
        //   color.add(Colors.white);
        // }
        if (col == 0) {
          return Container(
            color: color,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image(
                  image: NetworkImage(cubit.currencies[row].sIcon!),
                  width: 24,
                  height: 24,
                ),
                const SizedBox(
                  width: 2,
                ),
                smallText(
                    context: context,
                    text: ' ${cubit.currencies[row].sName!}',
                    size: 12),
              ],
            ),
          );
        } else if (col == 1) {
          return Container(
              color: color,
              child: Center(
                  child: smallText(
                      context: context,
                      text: '${cubit.currencies[row].dValue}   \$',
                      size: 12)));
        }
        return Container(
          color: color,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                  cubit.currencies[row].bEnabled!
                      ? Icons.arrow_upward_outlined
                      : Icons.arrow_downward_outlined,
                  size: 12,
                  color: cubit.currencies[row].bEnabled!
                      ? Colors.green
                      : Colors.red),
              const SizedBox(
                width: 5,
              ),
              Text(
                '${cubit.currencies[row].dTrading}%',
                style: TextStyle(
                    color: cubit.currencies[row].bEnabled!
                        ? Colors.green
                        : Colors.red),
              ),
            ],
          ),
        );
      },
    );

    return BlocConsumer<CoinzCubit, CoinzState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                leading: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Center(
                        child: smallText(
                            context: context, text: 'عودة', size: 14))),
                // backgroundColor: Colors.white,
                elevation: 0,
              ),
              body: CustomScrollView(
                slivers: [
                  SliverTableHeader(tableController: _tableController),
                  SliverTableBody(tableController: _tableController),
                ],
              ),
            ),
          );
        });
  }
}
