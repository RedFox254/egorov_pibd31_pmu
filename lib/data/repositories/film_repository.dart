import 'package:dio/dio.dart';
import 'package:pibd31_egorov_pmu/data/dtos/films_dto.dart';
import 'package:pibd31_egorov_pmu/data/mappers/films_mapper.dart';
import 'package:pibd31_egorov_pmu/domain/models/home.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_interface.dart';

class FilmRepository extends ApiInterface {
  static final Dio _dio = Dio()
    ..interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
    ))
    ..options.baseUrl = _baseUrl
    ..options.headers['X-API-KEY'] = _apiKey;

  static const String _baseUrl = 'https://api.kinopoisk.dev';
  static const String _apiKey = 'TJ9JQC4-0EA4EG9-HQXAXN2-DAJC7T4';

  @override
  Future<HomeData?> loadData({
    String? q,
    int page = 1,
    int pageSize = 25, // Можно увеличить по необходимости
    OnErrorCallback? onError,
  }) async {
    try {
      const String url = '$_baseUrl/v1.4/movie';

      /*final Map<String, dynamic> queryParams = {
        if (q != null) 'filter[name_cont]': q,
        'page': page,
        'limit': limit,
      };*/

      final Response<dynamic> response = await _dio.get<Map<dynamic, dynamic>>(
        url,
        queryParameters: {
          //'filter[name_cont]' : q,
          'page': page,
          'limit': pageSize,
        },
      );

      final FilmsDto dto = FilmsDto.fromJson(
          response.data as Map<String, dynamic>);
      final HomeData data = dto.toDomain();
      return data;
    } on DioException catch (e) {
      onError?.call(e.response?.statusMessage);
      return null;
    }
  }
}
