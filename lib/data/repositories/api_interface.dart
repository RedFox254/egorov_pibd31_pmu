import '../../domain/models/card.dart';
import '../../domain/models/home.dart';

typedef OnErrorCallback = void Function(String? error);

abstract class ApiInterface {
  Future<HomeData?> loadData({OnErrorCallback? onError});
}