import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app2/network/remote/dio_helper.dart';
import 'package:new_app2/shared/cubit/news_cubit.dart';

class NewsScreen extends StatelessWidget {
  static String routeName = 'HomeScreen';

  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit(),
      child: BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('News'),
              actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
            ),
            body: cubit.screens[cubit.currentIndex],
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                cubit.getBusiness();
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              items: cubit.bottomItems,
              onTap: (index) {
                cubit.changeBottomNavBarIndex(index);
              },
            ),
          );
        },
      ),
    );
  }
}
