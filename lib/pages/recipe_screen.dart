import 'package:cookly/services/firestore.dart';
import 'package:cookly/utils/colors.dart';
import 'package:cookly/utils/images64.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class RecipeScreen extends StatefulWidget {
  final Map<String, dynamic> food; // Alterado para Map<String, dynamic>
  const RecipeScreen({super.key, required this.food});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  FirestoreService firestoreService = FirestoreService();
  int currentNumber = 1;

  Future<bool> favoriteRecipe(docId, isLiked) async {
    return await firestoreService.favoriteRecipe(docId, isLiked);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        child: Row(children: [
          Expanded(
            flex: 5,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: Size(size.width * 1, 0),
              ),
              child: const Text(
                "Start Cooking",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: IconButton(
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
              style: IconButton.styleFrom(
                padding: EdgeInsets.all(10),
                shape: const CircleBorder(
                  side: BorderSide(
                    color: Colors.grey,
                    width: 1.5,
                  ),
                ),
              ),
              icon: widget.food['isLiked']
                  ? const Icon(
                      Iconsax.heart5,
                      size: 35,
                      color: Colors.red,
                    )
                  : const Icon(
                      Iconsax.heart,
                      size: 35,
                      color: Colors.grey,
                    ),
            ),
          )
        ]),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              Positioned(
                  child: Container(
                height: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: loadImage(widget.food['image'] ??
                        ''), // Usando o Map para acessar a URL da imagem
                    fit: BoxFit.cover,
                  ),
                ),
              )),
              Positioned(
                top: 40,
                left: 10,
                right: 10,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: IconButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: secondaryColor,
                          fixedSize: const Size(55, 55),
                        ),
                        icon: const Icon(CupertinoIcons.chevron_back,
                            color: textColor),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: IconButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: secondaryColor,
                          fixedSize: const Size(55, 55),
                        ),
                        icon: const Icon(Icons.edit, color: textColor),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: MediaQuery.of(context).size.width - 50,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                  ))
            ]),
            Center(
              child: Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.food['name'] ?? 'Nome da Receita', // Usando o Map
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Iconsax.flash_1,
                        color: textColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${widget.food['cal']} Cal", // Usando o Map
                        style: const TextStyle(color: textColor),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Icon(
                        Iconsax.clock,
                        color: textColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${widget.food['time']} min", // Usando o Map
                        style: const TextStyle(color: textColor),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(children: [
                    const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ingredients',
                            style: TextStyle(
                                color: textColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'How many servings?',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ]),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2.5, color: Colors.grey),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              if (currentNumber != 1) {
                                setState(() {
                                  currentNumber--;
                                });
                              }
                            },
                            icon: Icon(Iconsax.minus),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '$currentNumber',
                            style: TextStyle(color: textColor),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            onPressed: () {
                              if (currentNumber != 10) {
                                setState(() {
                                  currentNumber++;
                                });
                              }
                            },
                            icon: Icon(CupertinoIcons.plus),
                          ),
                        ],
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 20,
                  ),
                  Ingredients(
                      widget: widget) // Usando o Map em Ingredients também
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Ingredients extends StatelessWidget {
  const Ingredients({
    super.key,
    required this.widget,
  });

  final RecipeScreen widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                  image: NetworkImage(widget.food['image'] ?? ''),
                  fit: BoxFit.fill), // Usando a imagem do Map
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            widget.food['name'] ?? 'Nome da Receita', // Usando o Map
            style: const TextStyle(
                color: textColor, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          const Text(
            "400g",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ]),
        const Divider(
          height: 20,
          color: Color(0xA29E9E9E),
        ),
        Row(children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                  image: NetworkImage(widget.food['image'] ?? ''),
                  fit: BoxFit.cover), // Usando a imagem do Map
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            widget.food['name'] ?? 'Nome da Receita', // Usando o Map
            style: const TextStyle(
                color: textColor, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          const Text(
            "400g",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ]),
      ],
    );
  }
}
