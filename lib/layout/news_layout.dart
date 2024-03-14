import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app2/modules/search/search.dart';
import 'package:new_app2/shared/component/components.dart';
import 'package:new_app2/shared/cubit/news_cubit.dart';

class NewsScreen extends StatelessWidget {
  static String routeName = 'HomeScreen';

  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var newsCubit = BlocProvider.of<NewsCubit>(context);
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = newsCubit;
        return Scaffold(
          appBar: AppBar(
            title: const Text('News'),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                  icon: const Icon(Icons.search)),
              IconButton(
                icon: const Icon(Icons.brightness_4),
                onPressed: () {
                  NewsCubit.get(context).changeAppMode();
                },
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {},
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
    );
  }
}
