part of 'create_bloc.dart';

@immutable
abstract class CreateEvent {}

class OnSave extends CreateEvent {
  final int? id;
  final String itemId;
  final String itemName;
  final String barcode;

  OnSave(
      {this.id,
      required this.itemId,
      required this.itemName,
      required this.barcode});
}
