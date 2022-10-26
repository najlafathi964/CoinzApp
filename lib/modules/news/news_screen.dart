import 'package:coinz_app/models/TNews.dart';
import 'package:coinz_app/widgets/widgets.dart';
import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/app_cubit.dart';
import '../../cubit/app_state.dart';
import '../../network/local/cach_helper.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoinzCubit, CoinzState>(
        listener: (context, state) => {},
        builder: (context, state) {
          CoinzCubit cubit = CoinzCubit.get(context);
          List<News> newsList = [];
          return ConnectivityBuilder(builder: (context, isConnected, status) {
            newsList = isConnected ?? false
                ? cubit.news
                : News.decode(CachHelper.getData(key: 'news') ?? '');

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: bigText(context: context, text: 'أخبار و تقارير'),
                ),
                Expanded(
                    child: (newsList.length > 0)
                        ? ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  cubit.changeBottom(true, index: index);
                                },
                                child: builtItem(newsList[index], context)),
                            itemCount: newsList.length,
                          )
                        : Center(child: CircularProgressIndicator())),
              ],
            );
          });
        });
  }

  Widget builtItem(News newsList, context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
          top: 5, bottom: 5, end: 20, start: 20),
      child: Container(
        height: 110,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[300]!, width: 0.8)),
        child: Row(
          children: [
            Container(
              width: 124,
              height: 95,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.network(
                newsList.sImage!,
                fit: BoxFit.cover,
                errorBuilder: (context, ex, stackTree) {
                  return Image.asset('assets/images/news.jpg');
                },
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                height: 124,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    bigText(
                        context: context, size: 12, text: '${newsList.sTitle}'),
                    smallText(
                        context: context,
                        text: '${newsList.dtCreatedDate}',
                        color: Colors.grey,
                        size: 10),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            )
          ],
        ),
      ),
    );
  }
}
