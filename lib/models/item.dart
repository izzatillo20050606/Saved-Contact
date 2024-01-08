import 'package:objectbox/objectbox.dart';

@Entity()
class Item {
  @Id()
  int? id;
  String itemId;
  String itemName;
  String barcode;

  Item({
    this.id,
    required this.itemId,
    required this.itemName,
    required this.barcode,
  });
}
