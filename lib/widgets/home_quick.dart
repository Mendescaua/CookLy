import 'package:cookly/pages/recipe_screen.dart';
import 'package:cookly/services/firestore.dart';
import 'package:cookly/utils/colors.dart';
import 'package:cookly/utils/images64.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class QuickAndEasy extends StatefulWidget {
  const QuickAndEasy({super.key});

  @override
  State<QuickAndEasy> createState() => _QuickAndEasyState();
}

class _QuickAndEasyState extends State<QuickAndEasy> {
  @override
  Widget build(BuildContext context) {
    // Instanciando o FirestoreService
    FirestoreService firestoreService = FirestoreService();

    Future<bool> favoriteRecipe(docId, isLiked) async {
      return await firestoreService.favoriteRecipe(docId, isLiked);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Quick & Easy",
              style: TextStyle(
                  color: textColor, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/quikfood");
              },
              child: const Text(
                "View all",
                style: TextStyle(color: secondaryColor),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        // Usando o FutureBuilder para pegar dados do Firestore
        FutureBuilder<List<Map<String, dynamic>>>(
          future: firestoreService
              .getAllRecipes(), // Chamando o método getAllRecipes do serviço
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            }

            final foods = snapshot.data ?? [];

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: foods.map((food) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RecipeScreen(
                          food:
                              food, // Passando o Map diretamente para RecipeScreen
                        ),
                      ));
                    },
                    child: Container(
                      width: 200,
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                width: double.infinity,
                                height: 140,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: loadImage(food['image'] ?? ''),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                // Separando o nome e sobrenome
                                food['name'] != null
                                    ? food['name']!
                                        .split(' ')
                                        .take(2)
                                        .join(' ') // Pega nome e sobrenome
                                    : 'Nome da Receita', // Caso não tenha nome
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: textColor,
                                  fontSize: 15,
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(Iconsax.flash_1,
                                      size: 16, color: Colors.grey),
                                  Text(
                                    " ${food['cal']} cal",
                                    style: const TextStyle(
                                        color: textColor, fontSize: 10),
                                  ),
                                  const Text(
                                    "  -  ",
                                    style: TextStyle(
                                        color: textColor, fontSize: 10),
                                  ),
                                  const Icon(Iconsax.timer_1,
                                      size: 16, color: Colors.grey),
                                  Text(
                                    " ${food['time']} min",
                                    style: const TextStyle(
                                        color: textColor, fontSize: 10),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Positioned(
                            top: 1,
                            right: 10,
                            child: IconButton(
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.white,
                                fixedSize: const Size(30, 30),
                              ),
                              onPressed: () async {
                                bool newStatus =
                                    !food['isLiked']; // Alterna o valor atual
                                bool success =
                                    await favoriteRecipe(food['id'], newStatus);

                                if (success) {
                                  setState(() {
                                    food['isLiked'] =
                                        newStatus; // Atualiza a UI
                                  });
                                }
                              },
                              icon: food['isLiked']
                                  ? const Icon(Iconsax.heart5,
                                      size: 20, color: Colors.red)
                                  : const Icon(Iconsax.heart, size: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),
      ],
    );
  }
}
