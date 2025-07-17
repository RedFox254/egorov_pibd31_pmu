import 'package:flutter/material.dart';

import '../../domain/models/card.dart';

class DetailsPage extends StatelessWidget {
  final CardData data;

  const DetailsPage(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Детальная информация"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Image.network(data.image ?? '',),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              data.text,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          Text(
            data.description,
            style: Theme.of(context).textTheme.bodyLarge,
          )
        ],
      ),
    );
  }
}