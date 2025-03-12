import 'package:cookly/pages/recipe_screen.dart';
import 'package:cookly/services/firestore.dart';
import 'package:cookly/utils/colors.dart';
import 'package:cookly/utils/images64.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class FoodCard extends StatefulWidget {
  final Map<String, dynamic> food;
  const FoodCard({super.key, required this.food});
  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  FirestoreService firestoreService = FirestoreService();

  Future<bool> favoriteRecipe(docId, isLiked) async {
    return await firestoreService.favoriteRecipe(docId, isLiked);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Passa os dados diretamente para a RecipeScreen
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => RecipeScreen(food: widget.food)));
      },
      child: Container(
        width: 200,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Usando os dados do Firestore para a imagem
                Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: loadImage(widget.food['image'] ??
                          ''), // Usa a URL da imagem do Firestore
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Exibindo o nome da receita
                Text(
                  widget.food['name'] ?? 'Nome da receita',
                  style: const TextStyle(color: textColor, fontSize: 15),
                ),
                Row(
                  children: [
                    const Icon(
                      Iconsax.flash_1,
                      size: 16,
                      color: Colors.grey,
                    ),
                    // Exibe as calorias da receita
                    Text(
                      " ${widget.food['cal']} cal",
                      style: const TextStyle(color: textColor, fontSize: 10),
                    ),
                    Text("  -  ",
                        style: const TextStyle(color: textColor, fontSize: 10)),
                    const Icon(
                      Iconsax.timer_1,
                      size: 16,
                      color: Colors.grey,
                    ),
                    // Exibe o tempo de preparo
                    Text(
                      " ${widget.food['time']} min",
                      style: const TextStyle(color: textColor, fontSize: 10),
                    ),
                  ],
                ),
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
                      !widget.food['isLiked']; // Alterna o valor atual
                  bool success =
                      await favoriteRecipe(widget.food['id'], newStatus);

                  if (success) {
                    setState(() {
                      widget.food['isLiked'] = newStatus; // Atualiza a UI
                    });
                  }
                },
                icon: widget.food['isLiked']
                    ? const Icon(
                        Iconsax.heart5,
                        size: 20,
                        color: Colors.red,
                      )
                    : const Icon(
                        Iconsax.heart,
                        size: 20,
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
