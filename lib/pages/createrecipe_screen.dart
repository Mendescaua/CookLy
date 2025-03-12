import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cookly/services/firestore.dart';
import 'package:cookly/utils/colors.dart';

class CreateRecipeScreen extends StatefulWidget {
  const CreateRecipeScreen({super.key});

  @override
  State<CreateRecipeScreen> createState() => _CreateRecipeScreenState();
}

class _CreateRecipeScreenState extends State<CreateRecipeScreen> {
  FirestoreService firestoreService = FirestoreService();

  // Controllers
  final _nameController = TextEditingController();
  final _calController = TextEditingController();
  final _timeController = TextEditingController();

  File? _image;
  String? base64Image;

  // Função para selecionar imagem e converter para Base64
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      List<int> imageBytes = await imageFile.readAsBytes();
      String encodedImage = base64Encode(imageBytes);

      setState(() {
        _image = imageFile;
        base64Image = encodedImage;
      });
    }
  }

  // Função para criar a receita
  void createRecipe() async {
    final name = _nameController.text;
    final cal = _calController.text;
    final time = _timeController.text;

    if (base64Image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Por favor, selecione uma imagem."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    String? errorMessage = await firestoreService.createRecipe(
      name: name,
      cal: cal,
      time: time,
      imageBase64: base64Image!,
    );

    if (errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Receita criada com sucesso!"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.of(context).pushNamed('/quikfood');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
  backgroundColor: secondaryColor,
  resizeToAvoidBottomInset: false, // Impede o teclado de quebrar o layout
  body: SafeArea(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                "Create Recipe",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 37,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Add your favorite recipe",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container( // Adicionamos este Container para garantir que ocupe a tela toda
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: _image == null
                          ? Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Icon(Icons.camera_alt, size: 50, color: Colors.grey),
                            )
                          : Image.file(_image!, height: 150, width: double.infinity, fit: BoxFit.cover),
                    ),
                    const SizedBox(height: 20),
                    myTextField("Name", controller: _nameController),
                    myTextField("Calories", controller: _calController),
                    myTextField("Time", controller: _timeController),
                    const SizedBox(height: 80), // Espaço extra para evitar sobreposição com teclado
                    ElevatedButton(
                      onPressed: createRecipe,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        minimumSize: Size(size.width * 0.9, 0),
                      ),
                      child: const Text(
                        "Create",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  ),
);


  }
}

// Função para criar campos de entrada reutilizáveis
Widget myTextField(String hint, {required TextEditingController controller}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
        fillColor: Colors.grey[200],
        filled: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide.none,
        ),
        labelText: hint,
        labelStyle: const TextStyle(color: Colors.black54),
      ),
    ),
  );
}
