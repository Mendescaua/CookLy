
import 'package:cookly/utils/colors.dart';
import 'package:cookly/widgets/home_appbar.dart';
import 'package:cookly/widgets/home_categories.dart';
import 'package:cookly/widgets/home_dayRecipe.dart';
import 'package:cookly/widgets/home_quick.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String currentCat = "All";
    return Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeAppbar(),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Categories",
                  style: TextStyle(color: textColor, fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                home_categories(currentCat: currentCat),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Today's Recipe",
                  style: TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                const HomeDayrecipe(),
                // Container(
                //   width: double.infinity,
                //   height: 170,
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(20),
                //       image: const DecorationImage(
                //           image: AssetImage('assets/images/explore.png'),
                //           fit: BoxFit.fill)),
                // ),
                const SizedBox(
                  height: 10,
                ),
                const QuickAndEasy(),
              ],
            ),
          ),
        )));
  }
}
