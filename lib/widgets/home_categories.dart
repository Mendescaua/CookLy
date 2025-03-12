
import 'package:cookly/models/category.dart';
import 'package:cookly/utils/colors.dart';
import 'package:flutter/material.dart';

class home_categories extends StatelessWidget {
  const home_categories({
    super.key,
    required this.currentCat,
  });

  final String currentCat;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(
              catgories.length,
              (index) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), 
                margin: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: currentCat == catgories[index]
                          ? secondaryColor
                          : textColor,
                    ),
                    child: Text(catgories[index], style: const TextStyle(color: Colors.white),),
                  ))
        ],
      ),
    );
  }
}
