import 'package:coinz_app/cubit/app_cubit.dart';
import 'package:coinz_app/cubit/app_state.dart';
import 'package:coinz_app/models/TCoinz.dart';
import 'package:coinz_app/models/TFav.dart';
import 'package:coinz_app/modules/fav_screen.dart';
import 'package:coinz_app/widgets/widgets.dart';
import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_table/sliver_table.dart';
import 'package:coinz_app/network/local/cach_helper.dart';


class CoinzPriceScreen extends StatelessWidget {
  List<Color> beginColors = [ const Color(0xff9B81EC) ,const Color(0xffFFA500) , const Color(0xff02DFB6) , const Color(0xff478EDA) ,] ;

  List<Color> endColors = [const Color(0xffFB79B4) ,const Color(0xffFFDB00) ,   const Color(0xff47E546) , const Color(0xff58C4D8) ,] ;

  List<String> header = ['العملة' , 'السعر' , 'التداول'];

  CoinzPriceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = CoinzCubit.get(context) ;

    final SliverTableController _tableController = SliverTableController(
      colsCount: 3,
      rowsCount: cubit.currencies.length ,
      cellWidth: MediaQuery.of(context).size.width/2.1,
      cellHeight: 50.0,
      topHeaderHeight: 60.0,
      leftHeaderCellWidth: 15,
      topLeftCorner: Container(
        color: Colors.grey[100],
      ),
      topHeaderBuilder: (context, i) {
        return  Container(
          alignment: Alignment.center,
          color: Colors.grey[100],
          child: smallText(context :context , text :header[i] , color: const Color(0xFFccc7c5)),
        );
      },
      leftHeaderBuilder: (context, i) {
        return Text('${i + 1}' ,textAlign:TextAlign.center ,style: const TextStyle(fontSize: 10 , color: Colors.grey),);
      },
      cellBuilder: (context, row, col) {
        if(col == 0){
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            Image(image:NetworkImage(cubit.currencies[row].sIcon!) ,width: 24,height: 24,) ,
            const SizedBox(width: 2,) ,
            smallText(context:context ,text: ' ${cubit.currencies[row].sName!}' , size: 12),
          ],);
        }else if(col == 1){
          return Center(child: smallText(context: context,text: '${cubit.currencies[row].dValue!}   \$' ,size: 12));

        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(cubit.currencies[row].bEnabled! ? Icons.arrow_upward_outlined : Icons.arrow_downward_outlined , size: 12,color: cubit.currencies[row].bEnabled! ? Colors.green : Colors.red) ,
            const SizedBox(width: 5,) ,
            Text('${cubit.currencies[row].dTrading}%' , style: TextStyle(color: cubit.currencies[row].bEnabled! ? Colors.green : Colors.red),),
          ],
        );
      },
    );

    return BlocConsumer<CoinzCubit , CoinzState >(
      listener: (context, state) {
      },
      builder: (context , state) {
        List<Currencies> favourites = cubit.getFav() ;

        return
          ConnectivityBuilder(
              builder: (context ,isConnected , status) {
                return isConnected?? false ?
                  cubit.currencies.isEmpty  ? Center(child: CircularProgressIndicator()) : CustomScrollView(
              slivers: [
                SliverList(delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.only(right: 20 , left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        bigText(context: context,
                            text: 'أسـعار العملات الالكترونية' ),
                        Row(
                          children: [
                            smallText(
                              context: context,
                                text: 'آخر تحديث : ' , color: const Color(0xFFccc7c5)),
                            smallText(
                              context: context,
                                text: '09-19-2018' , color: const Color(0xFFccc7c5)),
                          ],
                        ) ,
                        const SizedBox(height: 20,) ,
                        GridView.count(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing:8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 155/96 ,
                          children: List.generate(favourites.length>=4 ?4:favourites.isEmpty ? 1 : favourites.length+1,
                                  (index) =>(index <= favourites.length-1  )?
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> FavScreen()));

                                    },
                                    child: Container(
                                decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      gradient: LinearGradient(
                                          begin: AlignmentDirectional.topEnd ,
                                          end: AlignmentDirectional.bottomStart ,
                                          colors:[ beginColors[index] , endColors[index] ]
                                      )
                                ),
                                child:  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(favourites[index].sIcon!, width: 30 , height: 30,) ,
                                      SizedBox(height: 5,),
                                      smallText(context:context ,text: '${favourites[index].sName }' , color: Colors.white,) ,
                                      smallText(context:context ,text: '${favourites[index].dValue}   \$  ' , color: Colors.white,) ,

                                    ],),
                              ),
                                  ) :
                              GestureDetector(
                                onTap: (){
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=> FavScreen()));
                                   },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.grey[300]
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                     const Icon(Icons.add_circle_outline_sharp , color: Color(0xFFccc7c5)) ,
                                      smallText( context:context ,text: 'اضغط للاضافة' , color: const Color(0xFFccc7c5)) ,

                                    ],),
                                ),
                              ) ),
                        ) ,
                        const SizedBox(height: 20,) ,
                      ],
                    ),
                  ),
                ])) ,
                SliverTableHeader(tableController: _tableController),
                cubit.currencies.isEmpty ? SliverToBoxAdapter(child: Center(child: CircularProgressIndicator(),),):SliverTableBody(tableController: _tableController),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(height: 15,),
                      Center(child: Text('جاري تحميل البيانات ..')),
                    ],
                  ),

                )
              ],
            )
                : Center(child: Image.asset('assets/images/no_internet.jpg'));
          }
        );
      }
    );
  }
}

