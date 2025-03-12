import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

ImageProvider<Object> loadImage(String imageData) {
  if (imageData.startsWith("http") || imageData.startsWith("https")) {
    return NetworkImage(imageData); // Mantém NetworkImage se for URL
  } else {
    try {
      Uint8List bytes = base64Decode(imageData);
      return MemoryImage(bytes); // Usa MemoryImage para base64
    } catch (e) {
      print("Erro ao decodificar imagem base64: $e");
      return const AssetImage('assets/images/placeholder.png'); // Imagem padrão
    }
  }
}
