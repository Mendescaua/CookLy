import 'package:cookly/services/firestore.dart';
import 'package:cookly/utils/colors.dart';
import 'package:cookly/widgets/quickfood_card.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Map<String, dynamic>> foods =
      []; // Lista para armazenar os dados do Firestore

  @override
  void initState() {
    super.initState();
    _loadFavoriteRecipes(); // Chama a função para carregar as receitas favoritas
  }

  // Função para carregar as receitas favoritas
  Future<void> _loadFavoriteRecipes() async {
    FirestoreService firestoreService = FirestoreService();
    List<Map<String, dynamic>> fetchedFoods = await firestoreService
        .getAllFavoritesRecipes(); // Alterado para buscar favoritos
    setState(() {
      foods =
          fetchedFoods; // Atualiza a lista de alimentos favoritos com os dados do Firestore
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text(
          "Favorites",
          style: TextStyle(
              color: textColor, fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                foods.isEmpty
                    ? Center(
                        child: Container(
                          padding: const EdgeInsets.only(top: 150),
                          child: Image.asset(
                            "assets/images/Hamburger-bro.png",
                            width: 350,
                            height: 350,
                          ),
                        )
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                        itemBuilder: (context, index) {
                          // Passa os dados diretamente para o widget FoodCard
                          return FoodCard(food: foods[index]);
                        },
                        itemCount: foods.length,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
