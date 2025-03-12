import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class FirestoreService {
  final _store = FirebaseFirestore.instance;

  // Método para criar uma receita
  Future<String?> createRecipe({
  required String name,
  required String cal,
  required String time,
  required String imageBase64,
}) async {
  try {
    if(name.isEmpty || cal.isEmpty || time.isEmpty ) {
      return 'Preencha todos os campos.';
    }
    var uuid = Uuid();
    String uniqueId = uuid.v4();  // Gera um UUID version 4 (aleatório)

    // Cria o documento com o ID gerado pelo UUID
    DocumentReference docRef = _store.collection('Foods').doc(uniqueId);

    // Adiciona os dados no documento com o ID específico
    await docRef.set({
      'id': uniqueId,
      'name': name,
      'cal': cal,
      'time': time,
      'image': imageBase64,
      'isLiked': false, // Definindo o padrão como falso
    });

    print('Receita adicionada com sucesso');
    return null; // Retorna null se não houver erro
  } catch (e) {
    print('Erro ao adicionar receita: $e');
    if (e is FirebaseException) {
      print('Código do erro: ${e.code}');
      print('Mensagem do erro: ${e.message}');
      return e.message; // Retorna a mensagem do erro
    }
    return 'Erro desconhecido ao adicionar receita';
  }
}

  // Método para pegar todos os dados da coleção 'Foods'
  Future<List<Map<String, dynamic>>> getAllRecipes() async {
    try {
      QuerySnapshot snapshot = await _store.collection('Foods').get();
      List<Map<String, dynamic>> foodsList = snapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();
      return foodsList; // Retorna a lista de alimentos
    } catch (e) {
      print('Erro ao buscar documentos: $e');
      if (e is FirebaseException) {
        print('Código do erro: ${e.code}');
        print('Mensagem do erro: ${e.message}');
      }
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getAllFavoritesRecipes() async {
  try {
    QuerySnapshot snapshot = await _store
        .collection('Foods')
        .where('isLiked', isEqualTo: true) // Filtra apenas os favoritos
        .get();

    List<Map<String, dynamic>> foodsList = snapshot.docs.map((doc) {
      return doc.data() as Map<String, dynamic>;
    }).toList();

    return foodsList; // Retorna apenas as receitas favoritas
  } catch (e) {
    print('Erro ao buscar documentos: $e');
    if (e is FirebaseException) {
      print('Código do erro: ${e.code}');
      print('Mensagem do erro: ${e.message}');
    }
    return [];
  }
}


  Future<bool> favoriteRecipe(String docId, bool isLiked) async {
  try {
    var docRef = FirebaseFirestore.instance.collection('Foods').doc(docId);
    var docSnapshot = await docRef.get();

    if (!docSnapshot.exists) {
      print("Documento não encontrado.");
      return false; // Retorna false se o documento não existir
    }

    await docRef.update({'isLiked': isLiked});
    return true;
  } catch (e) {
    print("Erro ao favoritar a receita: $e");
    return false;
  }
}

Future<Map<String, dynamic>?> getRecipeOfTheDay() async {
  try {
    QuerySnapshot snapshot = await _store.collection('Foods').get();
    if (snapshot.docs.isEmpty) return null;

    int totalRecipes = snapshot.docs.length;
    int dayOfYear = DateTime.now().difference(DateTime(DateTime.now().year, 1, 1)).inDays;

    int index = dayOfYear % totalRecipes;
    
    return snapshot.docs[index].data() as Map<String, dynamic>;
  } catch (e) {
    print('Erro ao buscar receita do dia: $e');
    return null;
  }
}


}
