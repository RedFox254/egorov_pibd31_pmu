import 'package:pibd31_egorov_pmu/domain/models/home.dart';

import '../../domain/models/card.dart';
import 'api_interface.dart';
class MockRepository extends ApiInterface {
  @override
  Future<HomeData?> loadData({OnErrorCallback? onError}) async {
    return HomeData(
      data: [
      CardData(
        'Граф Монте-Кристо',
        description: 'Дантес становится загадочным графом Монте-Кристо ',
        image:
        "https://media.clicktv.platform24.tv/img/c0/98/c0985b818f579d8264d309452959df1b.jpeg?w=160&format=webp",
      ),
      CardData(
          'Беляковы в отпуске',
          description: 'Обычная семья Беляковых из города Таганрога приезжает на отдых в Турцию',
          image:
          'https://avatars.mds.yandex.net/i?id=76b97b750cb8da2f2bf6f34c42a9d47144ea35f0-5070572-images-thumbs&n=13'
      ),
      CardData(
        'Молодёжка. Новая смена',
        description: 'Команда Студенческой хоккейной лиги «Акулы Политеха» на грани расформирования',
        image: '',
      ),
      CardData(
          'Субстанция',
          description: 'Слава голливудской звезды Элизабет Спаркл осталась в прошлом',
          image:
          'https://avatars.mds.yandex.net/i?id=ff9096d677431b95e2fce0d4764a618def37ec4c-5235538-images-thumbs&n=13'
      )
    ],
    );
  }
}