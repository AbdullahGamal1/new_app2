import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app2/layout/news_layout.dart';
import 'package:new_app2/network/local/cash_helper.dart';
import 'package:new_app2/network/remote/dio_helper.dart';
import 'package:new_app2/shared/cubit/news_cubit.dart';
import 'package:new_app2/shared/style/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  isDark ??= false;

  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  const MyApp(this.isDark, {super.key});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => NewsCubit()..changeAppMode(fromShared: isDark),
        ),
        BlocProvider(
            create: (_) => NewsCubit()
              ..getBusiness()
              ..getSports()
              ..getScience()),
      ],
      child: BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.orange,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                iconTheme: IconThemeData(color: Colors.black),
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.dark,
                  statusBarColor: Colors.orangeAccent,
                ),
                backgroundColor: Colors.white,
                elevation: 0.0,
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                selectedItemColor: Colors.orange,
                type: BottomNavigationBarType.fixed,
              ),
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.orange,
              ),
              textTheme: const TextTheme(
                bodyLarge: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.deepOrange,
                ),
              ),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white10,
              appBarTheme: const AppBarTheme(
                iconTheme: IconThemeData(color: Colors.white),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.light,
                  statusBarColor: Colors.orangeAccent,
                ),
                backgroundColor: Colors.white10,
                elevation: 0.0,
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Colors.white10,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                type: BottomNavigationBarType.fixed,
              ),
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
              textTheme: const TextTheme(
                bodyLarge: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.deepOrange,
                ),
              ),
            ),
            themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
            home: const NewsScreen(),
          );
        },
      ),
    );
  }
}
