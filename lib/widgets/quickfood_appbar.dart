import 'package:cookly/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class QuickAndFastAppbar extends StatelessWidget {
  
  const QuickAndFastAppbar({
    super.key,
  });

  @override
  
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
      Padding(
        padding: EdgeInsets.only(right: size.width * 0.15),
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
            backgroundColor: secondaryColor,
            fixedSize: const Size(55, 55),
          ),
          icon: const Icon(CupertinoIcons.chevron_back, color: darkColor),
        ),
      ),
      const Text(
        "Quick & Easy",
        style: TextStyle(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
      
      
    ]);
  }
}
