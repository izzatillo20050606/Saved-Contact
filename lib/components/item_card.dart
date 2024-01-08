import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'custom_icon_button.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    required this.itemId,
    required this.itemName,
    required this.barcode,
    this.onEdit,
    this.onDelete,
    Key? key,
  }) : super(key: key);
  final String itemId;
  final String itemName;
  final String barcode;
  final dynamic Function()? onDelete;
  final dynamic Function()? onEdit;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Slidable(
        key: key,
        closeOnScroll: true,
        endActionPane: ActionPane(
          motion: const BehindMotion(),
          extentRatio: 0.30,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CustomIconButton(
                onTap: onDelete ?? () {},
                color: Colors.red.shade400,
                icon: SvgPicture.asset(
                  "assets/icons/delete.svg",
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
            ),
            CustomIconButton(
              onTap: onEdit ?? () {},
              color: Theme.of(context).colorScheme.secondary,
              icon: SvgPicture.asset(
                "assets/icons/edit.svg",
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
          ],
        ),
        child: Material(
          color: Theme.of(context).inputDecorationTheme.fillColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        itemId,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color:
                              Theme.of(context).textTheme.displayLarge!.color,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.blue.shade300,
                            borderRadius: BorderRadius.circular(26)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          child: Text(
                            barcode,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.005,
                  ),
                  Text(
                    itemName,
                    style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).hintColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
