import 'package:cookly/services/firestore.dart';
import 'package:cookly/utils/colors.dart';
import 'package:cookly/widgets/quickfood_appbar.dart';
import 'package:cookly/widgets/quickfood_card.dart';
import 'package:flutter/material.dart';

class QuikfoodScreen extends StatefulWidget {
  const QuikfoodScreen({super.key});

  @override
  State<QuikfoodScreen> createState() => _QuikfoodScreenState();
}

class _QuikfoodScreenState extends State<QuikfoodScreen> {
  List<Map<String, dynamic>> foods = []; // Lista para armazenar os dados do Firestore

  @override
  void initState() {
    super.initState();
    _loadRecipes(); // Chama a função para carregar as receitas
  }

  // Função para carregar as receitas
  Future<void> _loadRecipes() async {
    FirestoreService firestoreService = FirestoreService();
    List<Map<String, dynamic>> fetchedFoods = await firestoreService.getAllRecipes();
    setState(() {
      foods = fetchedFoods; // Atualiza a lista de alimentos com os dados do Firestore
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const QuickAndFastAppbar(),
                const SizedBox(
                  height: 30,
                ),
                foods.isEmpty
                    ? const Center(child: CircularProgressIndicator()) // Exibe um indicador de carregamento
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
