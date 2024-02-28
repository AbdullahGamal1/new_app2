import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app2/modules/business_Screen/business.dart';
import 'package:new_app2/modules/sciens_screen/science.dart';
import 'package:new_app2/modules/settings_screen/settings.dart';
import 'package:new_app2/modules/sports_screen/sports.dart';
import 'package:new_app2/network/remote/dio_helper.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Sciens'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
  ];

  void changeBottomNavBarIndex(int index) {
    currentIndex = index;
    emit(NewsBottomNavState());
  }

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    Science(),
    SettingScreen()
  ];

  List<Map> business = [];

  void getBusiness() {
    DioHelper.getData(url: 'v2/top-headlines', query: {
      "country": "eg",
      'category': 'business',
      "apiKey": "4ba02a56473e4228a7a8748f2a12303f"
    }).then((value) {
      print(value.data['articles'][0]['title']);
    }).catchError((error) {
      print(error.toString());
    });
  }
}
