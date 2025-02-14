import 'package:flutter/material.dart';

class DogData extends ChangeNotifier {
  String? breed;
  int? age;
  String? gender;

  void getDogData(int? newage, String? newgender) {
   // breed = newbreed;
    age = newage;
    gender = newgender;
  }

  void getDogBreed(String? newbreed) {
    breed = newbreed;
  }
  @override
  notifyListeners();
}
