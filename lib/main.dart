import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.lightBlue
      ),
      home: const MyHomePage(title: 'Егоров Максим Александрович'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.tealAccent,
        title: Text(widget.title),
      ),
      backgroundColor: Colors.cyan,
      body: const MyWidget(),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});


  @override
  Widget build(BuildContext context) {
    final data = [
      _CardData(
        'Граф Монте-Кристо',
        description: 'Дантес становится загадочным графом Монте-Кристо ',
        image: "https://face2friend.com/majesticvfx/images/gallery/09.jpg",
      ),
      _CardData(
          'Беляковы в отпуске',
          description: 'Обычная семья Беляковых из города Таганрога приезжает на отдых в Турцию',
          image: 'https://avatars.mds.yandex.net/i?id=2226f5b0408e5ebf2ba41e87514e0981_l-2462069-images-thumbs&n=13'
      ),
      _CardData(
        'Молодёжка. Новая смена',
        description: 'Команда Студенческой хоккейной лиги «Акулы Политеха» на грани расформирования',
        image: '',
      ),
      _CardData(
          'Субстанция',
          description: 'Слава голливудской звезды Элизабет Спаркл осталась в прошлом',
          image: 'https://avatars.mds.yandex.net/i?id=ff9096d677431b95e2fce0d4764a618def37ec4c-5235538-images-thumbs&n=13'
      )
    ];
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: data.map((e) => _MyCardWidget.formData(e)).toList(),
        ),
      ),
    );
  }
}
class _CardData {
  final String text;
  final String description;
  final String? image;

  _CardData(
      this.text, {
        required this.description,
        this.image,
      });
}

class _MyCardWidget extends StatelessWidget {
  final String text;
  final String description;
  final String? image;
  const _MyCardWidget(
      this.text, {
        required this.description,
        this.image,
      });
  factory _MyCardWidget.formData(_CardData data) => _MyCardWidget(
    data.text,
    description: data.description,
    image: data.image,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.lime,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.black,
            width: 3,
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: SizedBox(
              height: 200,
              width: 150,
              child: Image.network(
                image ?? '',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Placeholder(),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}