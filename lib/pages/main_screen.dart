import 'package:cookly/pages/createrecipe_screen.dart';
import 'package:cookly/pages/favorite_screen.dart';
import 'package:cookly/pages/home_screen.dart';
import 'package:cookly/pages/settings_screen.dart';
import 'package:cookly/utils/colors.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTab = 0;
  @override
  Widget build(BuildContext context) {
    List screens = const [
      HomeScreen(),
      Scaffold(),
      CreateRecipeScreen(),
      FavoriteScreen(),
      SettingsScreen(),
    ];
    final items = <Widget>[
  Icon(currentTab == 0 ? Iconsax.home5 : Iconsax.home,
      size: 30, color: currentTab == 0 ? secondaryColor : Colors.grey),
  Icon(currentTab == 1 ? CupertinoIcons.search : CupertinoIcons.search,
      size: 30, color: currentTab == 1 ? secondaryColor : Colors.grey),
  Container(
    padding: const EdgeInsets.all(1), // Ajuste para melhor toque
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: secondaryColor, // Cor de fundo para destaque
      boxShadow: [
        BoxShadow(
          color: secondaryColor.withOpacity(0.4), // Sombra da cor secundária
          blurRadius: 10,
          spreadRadius: 3,
          offset: const Offset(0, 3), // Efeito de elevação
        ),
      ],
    ),
    child: const Icon(Iconsax.add,
        size: 45, color: Colors.white), // Ícone maior para destaque
  ),
  Icon(currentTab == 3 ? Iconsax.heart5 : Iconsax.heart,
      size: 30, color: currentTab == 3 ? secondaryColor : Colors.grey),
  Icon(currentTab == 4 ? Icons.settings : Icons.settings_outlined,
      size: 30, color: currentTab == 4 ? secondaryColor : Colors.grey),
];


    return Scaffold(
        body: screens[currentTab],
        backgroundColor: backgroundColor,
        bottomNavigationBar: SafeArea(
            child: Container(
          height: 70,
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: backgroundColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List<Widget>.generate(
                items.length,
                (index) => GestureDetector(
                      onTap: () => setState(() => currentTab = index),
                      child: items[index],
                    )),
          ),
        )));
  }
}

// SafeArea(
//           child: CurvedNavigationBar(
//         backgroundColor: Colors.transparent,
//         color: Colors.white,
//         height: 60,
//         items: items,
//         onTap: (index) => setState(() => currentTab = index),
//       )),