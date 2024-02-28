import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app2/layout/news_layout.dart';
import 'package:new_app2/network/remote/dio_helper.dart';
import 'package:new_app2/shared/style/bloc_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(color: Colors.black),
              titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: Colors.orangeAccent,
              ),
              backgroundColor: Colors.white,
              elevation: 0.0),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: Colors.orange,
              type: BottomNavigationBarType.fixed),
          floatingActionButtonTheme:
              FloatingActionButtonThemeData(backgroundColor: Colors.orange)),
      home: NewsScreen(),
    );
  }
}
