import 'package:coinz_app/Api/DioHelper.dart';
import 'package:coinz_app/Api/Repo/CurrencyRepo.dart';
import 'package:coinz_app/Api/Repo/NewsRepo.dart';
import 'package:coinz_app/Api/Repo/TriggerRepo.dart';
import 'package:coinz_app/cubit/app_state.dart';
import 'package:coinz_app/models/TNews.dart';
import 'package:coinz_app/models/TTrigger.dart';
import 'package:coinz_app/modules/coinz_alert_screen.dart';
import 'package:coinz_app/modules/coinz_price_screen.dart';
import 'package:coinz_app/modules/news/news_details_screen.dart';
import 'package:coinz_app/modules/news/news_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:coinz_app/network/local/cach_helper.dart';
import '../models/TCoinz.dart';
import '../models/TStatus.dart';

class CoinzCubit extends Cubit<CoinzState> {
  CoinzCubit() : super(CoinzInitialState());

  static CoinzCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  ScrollController scrollController = ScrollController();

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        icon: SvgPicture.asset('assets/images/coinz_price.svg'),
        activeIcon: SvgPicture.asset('assets/images/selected_coins_price.svg'),
        label: "أسعار العملات"),
    BottomNavigationBarItem(
        icon: SvgPicture.asset('assets/images/bell.svg'),
        activeIcon: SvgPicture.asset('assets/images/selected_bell.svg'),
        label: "منبه العملات"),
    BottomNavigationBarItem(
        icon: SvgPicture.asset('assets/images/menu.svg'),
        activeIcon: SvgPicture.asset('assets/images/selected_menu.svg'),
        label: "أخبار وتقارير"),
  ];
  List<Widget> screens = [
    CoinzPriceScreen(),
    CoinzAlertScreen(),
    const NewsScreen()
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(CoinzBottomNavState());
  }

  List<Currencies> currencies = [];
  var pageNumber = 1;

  void getCoinsData() async {
    Map<String, dynamic> map = {
      'i_page_count': 20,
      'i_page_number': pageNumber
    };
    currencies = await CurrencyRepo.instance.getCurrencyRequest(map: map);
    emit(CoinzGetCoinsListState());
  }

  addLoadMoreTrigger() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        loadMore();
      }
    });
  }

  onRefresh() {
    currencies.clear();
    pageNumber = 1;
    stopLoadMore = false;
    getCoinsData();
  }

  bool stopLoadMore = false;

  void loadMore() async {
    if (stopLoadMore) return;

    List<Currencies> loadMoreList = [];
    pageNumber += 1;
    // isLoadingRequest = true;
    // update();

    Map<String, dynamic> map = {
      'i_page_count': 20,
      'i_page_number': pageNumber
    };
    loadMoreList = await CurrencyRepo.instance.getCurrencyRequest(map: map);

    if (loadMoreList.isEmpty) stopLoadMore = true;

    currencies.addAll(loadMoreList);
    // isLoadingRequest = false;

    emit(CoinzLoadMoreState());
  }

  List<News> news = [];
  List<News> sharedNews = [];
  String newsEncodedData = '';
  void getNews() async {
    news = await NewsRepo.instance.getNewsRequest();
    if (news.isNotEmpty) {
      newsEncodedData = News.encode(news);
      CachHelper.saveData(key: 'news', value: newsEncodedData).then((value) {
        emit(CoinzGetNewsListState());
      });
      //sharedNews = news;
    }
      emit(CoinzGetNewsListState());

  }

  List<Condition> conditions = [];

  void getTriggers() async {
    conditions = await TriggerRepo.instance.getTriggerRequest();
    emit(CoinzGetTriggerListState());
  }

  bool details = false;

  changeBottom(bool isDetails, {int? index}) {
    details = isDetails;
    screens = [
      CoinzPriceScreen(),
      CoinzAlertScreen(),
      details
          ? NewsDetailsScreen(
              index: index!,
            )
          : const NewsScreen()
    ];

    emit(CoinzChangeBottomState());
  }

  bool isDark = true;

  void changeAppMode({bool? dark}) {
    if (dark != null) {
      isDark = dark;
      emit(CoinzChangeModeState());
    } else {
      isDark = !isDark;
      CachHelper.saveData(key: 'isDark', value: isDark).then((value) {
        emit(CoinzChangeModeState());
      });
    }
  }

  bool check = false;

  int coinsIndex = 0;

  void changeCoinsType({required int index}) {
    coinsIndex = index;
    emit(CoinzChangeCoinsTypeState());
  }

  List<String> valueType = [
    'أكبر من',
    'يساوي',
    'أصغر من',
  ];

  int valueIndex = 0;

  void changeValueType({required int index}) {
    valueIndex = index;
    emit(CoinzChangeValueTypeState());
  }

  TStatus? tStatus ;
  void addTrigger({required context ,required String name, required int type, required String value}) async {
    tStatus = await TriggerRepo.instance.addTrigger(context:context , name:name , type:type , value:value);
    getTriggers();
    emit(CoinzAddTriggerState());
  }

  //  List<Favourites> favourites =[];
  // var favIsLoading = false ;
  //  void getFav() async {
  //    favIsLoading = true;
  //    emit(CoinzLoadingState());
  //    favourites = await FavouritesRepo.instance.getFavouriteRequest();
  //    favIsLoading = false;
  //    emit(CoinzGetFavListState());
  //
  //  }

  List<Currencies> favourites  =[];
  String encodedData ='' ;
  void addFav({required Currencies currency}) {
    favourites = getFav();
    favourites.add(currency);
      encodedData = Currencies.encode(favourites);
      CachHelper.saveData(key: 'favourites', value: encodedData).then((value) {
        emit(CoinzAddFavListState());
      });
    emit(CoinzAddFavListState());

  }
  List<Currencies> getfavourites =[];
  List<Currencies> getFav(){
    final String favString = CachHelper.getData(key: 'favourites') ??'';
    if(favString.isNotEmpty) {
      getfavourites = Currencies.decode(favString);
    }
    emit (CoinzGetFavListState());

    return getfavourites ;

  }
  String encodedRemoveData ='' ;
  void removeFav({required Currencies currency}) {
    favourites.remove(currency);
    encodedData = Currencies.encode(favourites);
    CachHelper.saveData(key: 'favourites', value: encodedData).then((value) {
      emit(CoinzRemoveFav());
    });    emit(CoinzRemoveFav());
  }

  removeAlert(int id) async {
    await DioHelper().delete('/triggers?id=$id');
    getTriggers();
    emit(CoinzDeleteAlarmState());
  }
}
