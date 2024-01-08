import 'package:objectbox/objectbox.dart';

import '../models/item.dart';

class DBHelper {
  
  static Future<List<Item>> getItems(Store store) async {
    List<Item> items = store.box<Item>().getAll();
    return items;
  }

  static Future<List<int>> putItem(
    Store store, {
    required List<Item> data,
  }) async {
    return store.box<Item>().putMany(data);
  }

  static Future<bool> deleteItem(Store store, {required int itemId}) async {
    return store.box<Item>().remove(itemId);
  }
}
