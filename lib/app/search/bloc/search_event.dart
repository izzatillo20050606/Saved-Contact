part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class GetItems extends SearchEvent {}

class EditItem extends SearchEvent {
  final Item item;
  EditItem({required this.item});
}

class DeleteItem extends SearchEvent {
  final int id;
  DeleteItem({required this.id});
}

class SearchItem extends SearchEvent {
  final String keyword;
  SearchItem({required this.keyword});
}
