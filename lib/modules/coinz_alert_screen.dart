import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:coinz_app/cubit/app_cubit.dart';
import 'package:coinz_app/cubit/app_state.dart';
import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/widgets.dart';

class CoinzAlertScreen extends StatelessWidget {
  CoinzAlertScreen({Key? key}) : super(key: key);
TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var cubit = CoinzCubit.get(context);
    return BlocConsumer<CoinzCubit, CoinzState>(
        listener: (context, state) {},
        builder: (context, state) {
          cubit.getTriggers() ;
          return ConnectivityBuilder(builder: (context, isConnected, status) {
            return isConnected ?? false
                ? Padding(
                    padding:
                        const EdgeInsetsDirectional.only(start: 20, end: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        bigText(context: context, text: 'منبه العملات'),
                        smallText(
                            context: context,
                            text: 'يرجى اختيـار نوع العملة ',
                            color: const Color(0xFFccc7c5),
                            size: 10),
                        const SizedBox(
                          height: 5,
                        ),
                        containerStyle(
                            context: context,
                            title: cubit.currencies[cubit.coinsIndex].sName!,
                            image: cubit.currencies[cubit.coinsIndex].sIcon,
                            icon: Icons.arrow_drop_down,
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: AlertDialog(
                                            scrollable: true,
                                            title: const Text('اختر نوع العملة'),
                                            content: Column(
                                              children: List.generate(
                                                  cubit.currencies.length,
                                                  (index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    cubit.changeCoinsType(
                                                        index: index);
                                                    Navigator.pop(context);
                                                  },
                                                  child: ListTile(
                                                    leading: Image(
                                                      image: NetworkImage(cubit.currencies[index].sIcon!),
                                                      width: 23,
                                                      height: 23,
                                                    ),
                                                    title: Text(cubit.currencies[index].sName!,),
                                                  ),
                                                );
                                              }),
                                            )),
                                      ));
                            }),
                        const SizedBox(
                          height: 16,
                        ),
                        smallText(
                            context: context,
                            text: 'يرجى تحديد قيمة المنبه ',
                            color: const Color(0xFFccc7c5),
                            size: 10),
                        const SizedBox(height: 5,),
                        Row(
                          children: [
                            containerStyle(
                                context: context,
                                title: cubit.valueType[cubit.valueIndex],
                                width: MediaQuery.of(context).size.width / 2 - 20,
                                end: true,
                                icon: Icons.arrow_drop_down,
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Container(
                                              margin: const EdgeInsets.only(top: 120),
                                              child: AlertDialog(
                                                  alignment: Alignment.topCenter,
                                                  scrollable: true,
                                                  content: Column(
                                                    children: List.generate(3,
                                                        (index) =>
                                                            GestureDetector(
                                                              onTap: () {
                                                                cubit.changeValueType(index: index);
                                                                Navigator.pop(context);
                                                              },
                                                              child: ListTile(title: Text(cubit.valueType[index],),),
                                                            )),
                                                  )),
                                            ),
                                          ));
                                }),
                            // containerStyle(
                            //     context: context,
                            //     title: '10000  \$',
                            //     width: MediaQuery.of(context).size.width / 2 - 20),
                            Container(
                              height:  60,
                              width: MediaQuery.of(context).size.width / 2 - 20,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadiusDirectional.only(
                                      topEnd: Radius.circular(10),
                                      bottomEnd: Radius.circular(10)),
                                  border: Border.all(color: Colors.grey[300]!, width: 0.8)),
                              child: TextField(
                                controller: controller,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: '10000   \$' ,
                                  hintStyle: TextStyle(fontSize: 14 , fontWeight: FontWeight.bold , color: Colors.black),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 20,),
                        GestureDetector(
                          onTap: () {
                            cubit.addTrigger(
                              context:context ,
                                name: cubit.currencies[cubit.coinsIndex].sCode!,
                                type: cubit.valueIndex + 1,
                                value: controller.text);

                          },
                          child: Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: const LinearGradient(
                                    begin: AlignmentDirectional.topEnd,
                                    end: AlignmentDirectional.bottomStart,
                                    colors: [
                                      Color(0xffFFDB00),
                                      Color(0xffFFA500)
                                    ])),
                            child: Center(
                                child: bigText(
                                    context: context,
                                    text: 'اضافة تنبيه',
                                    size: 16)),
                          ),
                        ),
                        const SizedBox(height: 50,),
                        Expanded(
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  containerStyle(
                                      context: context,
                                      image: cubit.conditions[index].sIcon,
                                      title: cubit.conditions[index].sName!,
                                      value: cubit.conditions[index].iType == '1' ? 'أكبر من'  : cubit.conditions[index].iType == '2' ? 'يساوي' : 'أصغر من',
                                      price: cubit.conditions[index].dValue!,
                                      isAlarm: true,
                                      icon: Icons.restore_from_trash_outlined,
                                      onTapIcon: () {
                                        cubit.removeAlert(cubit.conditions[index].pkIId!);
                                      }),
                                  const SizedBox(height: 10,)
                                ],
                              );
                            },
                            itemCount: cubit.conditions.length,
                            // itemCount: list.length
                          ),
                        ),
                      ],
                    ),
                  )
                : Center(child: Image.asset('assets/images/no_internet.jpg'));
          });
        });
  }

  Widget containerStyle(
      {required context,
      required String title,
      String? price,
      String? value,
      String? image,
      double? width,
      bool end = false,
      bool isAlarm = false,
      Function()? onTap,
      Function()? onTapIcon,
      IconData? icon}) {
    double screenWidth = MediaQuery.of(context).size.width;
    screenWidth = width ?? screenWidth;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: isAlarm ? 70 : 60,
        width: screenWidth,
        decoration: BoxDecoration(
            borderRadius: screenWidth == MediaQuery.of(context).size.width
                ? BorderRadius.circular(10)
                : end
                    ? const BorderRadiusDirectional.only(
                        topStart: Radius.circular(10),
                        bottomStart: Radius.circular(10))
                    : const BorderRadiusDirectional.only(
                        topEnd: Radius.circular(10),
                        bottomEnd: Radius.circular(10)),
            border: Border.all(color: Colors.grey[300]!, width: 0.8)),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ListTile(
              leading: image != null
                  ? Image(
                      image: NetworkImage(image),
                      width: 23,
                      height: 23,
                    )
                  : null,
              title: isAlarm
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          smallText(context: context, text: title, size: 14),
                          smallText(
                              context: context,
                              text: '${value!}    $price \$',
                              size: 11,
                              color: value == 'أكبر من'
                                  ? Colors.orange
                                  : value == 'يساوي'
                                      ? Colors.green
                                      : Colors.red)
                        ],
                      ),
                    )
                  : smallText(context: context, text: title, size: 14),
              trailing: icon != null
                  ? GestureDetector(
                      onTap: onTapIcon,
                      child: Icon(
                        icon,
                        color: isAlarm ? Colors.green : null,
                      ))
                  : null,
            )),
      ),
    );


  }
}
