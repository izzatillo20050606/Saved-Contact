part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Item> items;
  SearchLoaded({required this.items});
}

class SearchDeleteSuccess extends SearchState {}

class SearchDeleteFailed extends SearchState {}
