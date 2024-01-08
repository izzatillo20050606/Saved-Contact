import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_crud/models/item.dart';
import 'package:flutter_crud/utils/db_helper.dart';
import 'package:flutter_crud/utils/objectbox.dart';
import 'package:meta/meta.dart';

part 'create_event.dart';
part 'create_state.dart';

class CreateBloc extends Bloc<CreateEvent, CreateState> {
  final itemIdTEC = TextEditingController();
  final itemNameTEC = TextEditingController();
  final barcodeTEC = TextEditingController();

  late String? itemIdError = '';
  late String? itemNameError = '';
  late String? barcodeError = '';

  CreateBloc() : super(CreateInitial()) {
    on<OnSave>((event, emit) async {
      if (validate(event)) {
        List<int> result = await DBHelper.putItem(Objectbox.store_, data: [
          Item(
              id: event.id ?? 0,
              itemId: event.itemId,
              itemName: event.itemName,
              barcode: event.barcode)
        ]);
        if (result.isNotEmpty) {
          emit(CreateSuccess());
        }
      } else {
        emit(CreateError(
            itemIdError: itemIdError,
            itemNameError: itemNameError,
            barcodeError: barcodeError));
      }
    });
  }

  void edit(Item item) {
    itemIdTEC.text = item.itemId.toString();
    itemNameTEC.text = item.itemName;
    barcodeTEC.text = item.barcode;
  }

  bool validate(OnSave data) {
    itemIdError = '';
    itemNameError = '';
    barcodeError = '';
    if (int.tryParse(data.itemId) == null) {
      itemIdError = 'Number no ???';
    }

    if (data.itemName.isEmpty) {
      itemNameError = 'Name no ???';
    }

    // if (data.barcode.isEmpty) {
    //   barcodeError = 'code no ???';
    // }
    // || data.barcode.isEmpty

    if (data.itemId.isEmpty || data.itemName.isEmpty ) {
      return false;
    }
    return true;
  }
}
