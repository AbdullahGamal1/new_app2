part of 'news_cubit.dart';

@immutable
abstract class NewsState {}

class NewsInitialState extends NewsState {}

class NewsBottomNavState extends NewsState {}

//Business
class NewsGetBusinessSuccessState extends NewsState {}

class NewsGetBusinessErrorState extends NewsState {
  final String error;

  NewsGetBusinessErrorState(this.error);
}

class NewsGetBusinessLoadingState extends NewsState {}

//Sports
class NewsGetSportsSuccessState extends NewsState {}

class NewsGetSportsErrorState extends NewsState {
  final String error;

  NewsGetSportsErrorState(this.error);
}

class NewsGetSportsLoadingState extends NewsState {}

//Science

class NewsGetScienceSuccessState extends NewsState {}

class NewsGetScienceErrorState extends NewsState {
  final String error;

  NewsGetScienceErrorState(this.error);
}

class NewsGetScienceLoadingState extends NewsState {}

//Mode
class NewsChangeAppModeState extends NewsState {}
