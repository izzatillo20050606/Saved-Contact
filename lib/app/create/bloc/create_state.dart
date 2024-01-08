part of 'create_bloc.dart';

@immutable
abstract class CreateState {}

class CreateInitial extends CreateState {}

class CreateError extends CreateState {
  final String? itemIdError;
  final String? itemNameError;
  final String? barcodeError;
  CreateError({this.itemIdError, this.itemNameError, this.barcodeError});
}

class CreateSuccess extends CreateState {}
