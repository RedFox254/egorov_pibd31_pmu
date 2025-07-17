import 'package:flutter/material.dart';
class CardData {
  final String text;
  final String description;
  final String? image;

  CardData(
      this.text, {
        required this.description,
        this.image,
      });
}