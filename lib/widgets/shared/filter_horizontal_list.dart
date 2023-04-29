import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:filmoteca_app/utils/string_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum FilterListVariantType { outlined, filled }

class FilterHorizontalList extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final FilterListVariantType variant;
  final Function(Map<String, dynamic>, int index) onPressed;
  final bool itemRemovable;
  final int selectedItemIndex;

  const FilterHorizontalList({
    super.key,
    required this.items,
    required this.onPressed,
    this.itemRemovable = false,
    this.selectedItemIndex = 0,
    this.variant = FilterListVariantType.filled,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 35,
        child: ListView.builder(
          itemCount: items.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: ((context, index) => Container(
                height: 35,
                margin: const EdgeInsets.only(right: 6),
                child: ElevatedButton(
                    onPressed: () {
                      onPressed(items[index], index);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          (index == selectedItemIndex || itemRemovable)
                              ? AppColors.primaryColor
                              : variant == FilterListVariantType.filled
                                  ? AppColors.darkSecondaryColor
                                  : Colors.transparent,
                      minimumSize: const Size(70, 35.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: variant == FilterListVariantType.filled
                            ? BorderSide.none
                            : const BorderSide(
                                color: AppColors.primaryColor,
                                width: 1,
                              ),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          capitalizeText(items[index]['name']),
                          style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                        if (itemRemovable) const SizedBox(width: 6),
                        if (itemRemovable)
                          const Icon(
                            CupertinoIcons.xmark,
                            color: Colors.white,
                            size: 12,
                          )
                      ],
                    )),
              )),
        ));
  }
}
