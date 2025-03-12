import 'package:cookly/pages/recipe_screen.dart';
import 'package:cookly/services/firestore.dart';
import 'package:cookly/utils/colors.dart';
import 'package:cookly/utils/images64.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomeDayrecipe extends StatefulWidget {
  const HomeDayrecipe({super.key});

  @override
  State<HomeDayrecipe> createState() => _HomeDayrecipeState();
}

class _HomeDayrecipeState extends State<HomeDayrecipe> {
  FirestoreService firestoreService = FirestoreService();
  Map<String, dynamic>? food;

  @override
  void initState() {
    super.initState();
    fetchRecipe();
  }

  void fetchRecipe() async {
    var fetchedRecipe = await firestoreService.getRecipeOfTheDay();
    setState(() {
      food = fetchedRecipe;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: food == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    // Passa os dados diretamente para a RecipeScreen
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RecipeScreen(food: food!)));
                  },
                  child: Container(
                    height: 280,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: loadImage(food!['image'] ?? ''),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 110,
                    margin:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          food!['name'] ?? 'Nome da Receita',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: textColor,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Iconsax.flash_1,
                                size: 18, color: Colors.grey),
                            Text(
                              " ${food!['cal']} cal",
                              style: const TextStyle(
                                  color: textColor, fontSize: 14),
                            ),
                            const Text(
                              "  |  ",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                            const Icon(Iconsax.timer_1,
                                size: 18, color: Colors.grey),
                            Text(
                              " ${food!['time']} min",
                              style: const TextStyle(
                                  color: textColor, fontSize: 14),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
