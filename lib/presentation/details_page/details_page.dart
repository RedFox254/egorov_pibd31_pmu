import 'package:flutter/material.dart';

import '../../domain/models/card.dart';

/*class DetailsPage extends StatelessWidget {
  final CardData data;

  const DetailsPage(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.limeAccent,
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
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
}*/
class DetailsPage extends StatelessWidget {
  final CardData data;

  const DetailsPage(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.limeAccent,
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: const Text("Детальная информация"),
      ),
      body: SingleChildScrollView( // Обернули в SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Добавим отступы для красоты
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                data.image ?? '',
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16), // Отступ между изображением и текстом
              Text(
                data.text,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 8),
              Text(
                data.description,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}