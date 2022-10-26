import 'package:coinz_app/widgets/widgets.dart';
import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../cubit/app_cubit.dart';
import '../../cubit/app_state.dart';
import '../../models/TNews.dart';
import '../../network/local/cach_helper.dart';

class NewsDetailsScreen extends StatelessWidget {
  int index;

  NewsDetailsScreen({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoinzCubit, CoinzState>(
        listener: (context, state) => {},
        builder: (context, state) {
          CoinzCubit cubit = CoinzCubit.get(context);
          var news;
          return ConnectivityBuilder(builder: (context, isConnected, status) {
            news = isConnected ?? false
                ? cubit.news[index]
                : News.decode(CachHelper.getData(key: 'news') ?? '')[index];

            return Directionality(
              textDirection: TextDirection.rtl,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    cubit.changeBottom(false);
                                  },
                                  child: smallText(
                                      context: context,
                                      text: 'عودة',
                                      size: 13)),
                              smallText(
                                  context: context, text: 'مشاركة', size: 13)
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          bigText(context: context, text: '${news.sTitle}'),
                          smallText(
                              context: context,
                              text: '${news.dtCreatedDate}',
                              color: const Color(0xFFccc7c5)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Image.network(
                      news.sImage!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, ex, stackTree) {
                        return Image.asset('assets/images/news.jpg');
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 110,
                                height: 35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: const Color(0xff2D609B)),
                                child: TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'مشاركة عبر فيسبوك',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 110,
                                height: 35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: const Color(0xff00C3F3)),
                                child: TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'مشاركة عبر تويتر',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey),
                                child: TextButton(
                                  onPressed: () {},
                                  child: Icon(
                                    Icons.share,
                                    color: Colors.grey[300],
                                    size: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // bigText(context:context ,text: '${news.sDescription}', size: 14)
                          Html(data: '${news.sDescription}')
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }
}
