
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../domain/models/card.dart';
import '../details_page/details_page.dart';

part 'card.dart';
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
        backgroundColor: Colors.lightBlue,
        title: Text(widget.title),
      ),
      backgroundColor: Colors.lightBlue,
      body: const Body(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});


  @override
  Widget build(BuildContext context) {
    final data = [
      CardData(
        'Граф Монте-Кристо',
        description: 'Дантес становится загадочным графом Монте-Кристо ',
        image: "https://face2friend.com/majesticvfx/images/gallery/09.jpg",
      ),
      CardData(
          'Беляковы в отпуске',
          description: 'Обычная семья Беляковых из города Таганрога приезжает на отдых в Турцию',
          image: 'https://avatars.mds.yandex.net/i?id=2226f5b0408e5ebf2ba41e87514e0981_l-2462069-images-thumbs&n=13'
      ),
      CardData(
        'Молодёжка. Новая смена',
        description: 'Команда Студенческой хоккейной лиги «Акулы Политеха» на грани расформирования',
        image: '',
      ),
      CardData(
          'Субстанция',
          description: 'Слава голливудской звезды Элизабет Спаркл осталась в прошлом',
          image: 'https://avatars.mds.yandex.net/i?id=ff9096d677431b95e2fce0d4764a618def37ec4c-5235538-images-thumbs&n=13'
      )
    ];
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: data.map((e) => _MyCardWidget.formData(e,
            onLike: (bool isLiked) {
              _showSnackBar(context, isLiked);
            },
            onTap: () => _navToDetails(context, e),
          )).toList(),
        ),
      ),
    );
  }
  void _showSnackBar(BuildContext context, bool isLiked) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Вы ${isLiked ? 'лайкнули карточку' : 'убрали лайк с карточки'}',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        backgroundColor: Colors.lightGreenAccent,
        duration: const Duration(seconds: 2),
      ));
    });
  }
  void _navToDetails(BuildContext context, CardData data) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => DetailsPage(data)),
    );
  }
}
