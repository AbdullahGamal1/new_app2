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
    const BottomNavigationBarItem(
        icon: Icon(Icons.business), label: 'Business'),
    const BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    const BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
    // const BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
  ];

  void changeBottomNavBarIndex(int index) {
    currentIndex = index;
    if (index == 1) {
      getSports();
    } else if (index == 2) {
      getScience();
    }
    emit(NewsBottomNavState());
  }

  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const Science(),
    const SettingScreen()
  ];

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];

  void getBusiness() {
    if (business.isEmpty) {
      emit(NewsGetBusinessLoadingState());
      DioHelper.getData(url: 'v2/top-headlines', query: {
        "country": "us",
        'category': 'business',
        "apiKey": "4ba02a56473e4228a7a8748f2a12303f"
      }).then((value) {
        business = value.data['articles'];
        emit(NewsGetBusinessSuccessState());
      }).catchError((error) {
        emit(NewsGetBusinessErrorState(error.toString()));
        print(error.toString());
      });
    } else {
      emit(NewsGetBusinessSuccessState());
    }
  }

  void getSports() {
    if (sports.isEmpty) {
      emit(NewsGetSportsLoadingState());
      DioHelper.getData(url: 'v2/top-headlines', query: {
        "country": "us",
        'category': 'sports',
        "apiKey": "4ba02a56473e4228a7a8748f2a12303f"
      }).then((value) {
        sports = value.data['articles'];
        print(sports[0]['urlToImage']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        emit(NewsGetSportsErrorState(error.toString()));
        print(error.toString());
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  void getScience() {
    if (science.isEmpty) {
      emit(NewsGetScienceLoadingState());
      DioHelper.getData(url: 'v2/top-headlines', query: {
        "country": "us",
        'category': 'science',
        "apiKey": "4ba02a56473e4228a7a8748f2a12303f"
      }).then((value) {
        science = value.data['articles'];
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        emit(NewsGetScienceErrorState(error.toString()));
        print(error.toString());
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  bool isDark = false;

  void changeAppMode() {
    isDark = !isDark;
    emit(NewsChangeAppModeState());
  }
}
