import 'package:dio/dio.dart';
import 'package:pibd31_egorov_pmu/data/dtos/films_dto.dart';
import 'package:pibd31_egorov_pmu/data/mappers/films_mapper.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../domain/models/card.dart';
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

  /*@override
  Future<List<CardData>?> loadData(
      {String? q, OnErrorCallback? onError}) async {
    try {
      const String url = '$_baseUrl/v1.4/movie?year=2023';

      final Response<dynamic> response = await _dio.get<Map<dynamic, dynamic>>(
        url,
        queryParameters: q != null ? {'filter[name_cont]': q} : null,
      );
      final FilmsDto dto = FilmsDto.fromJson(response.data as Map<String, dynamic>);
      final List<CardData>? data = dto.docs?.map((e) => e.toDomain()).toList();
      return data;
    } on DioException catch (e){
      onError?.call(e.response?.statusMessage);
      return null;
    }
  }
}*/
  @override
  Future<List<CardData>?> loadData({
    String? q,
    int page = 1,
    int limit = 100, // Можно увеличить по необходимости
    OnErrorCallback? onError,
  }) async {
    try {
      final String url = '$_baseUrl/v1.4/movie?year=2023';

      final Map<String, dynamic> queryParams = {
        if (q != null) 'filter[name_cont]': q,
        'page': page,
        'limit': limit,
      };

      final Response<dynamic> response = await _dio.get<Map<dynamic, dynamic>>(
        url,
        queryParameters: queryParams,
      );

      final FilmsDto dto = FilmsDto.fromJson(
          response.data as Map<String, dynamic>);
      final List<CardData>? data = dto.docs?.map((e) => e.toDomain()).toList();
      return data;
    } on DioException catch (e) {
      onError?.call(e.response?.statusMessage);
      return null;
    }
  }

  Future<List<CardData>> loadAllData({String? q}) async {
    List<CardData> allData = [];
    int currentPage = 1;
    const int limitPerPage = 100; // или больше, если API позволяет

    while (true) {
      final dataChunk = await loadData(
          q: q, page: currentPage, limit: limitPerPage);
      if (dataChunk == null || dataChunk.isEmpty) break;

      allData.addAll(dataChunk);

      // Если получили меньше элементов чем limit — это последняя страница
      if (dataChunk.length < limitPerPage) break;

      currentPage++;
    }

    return allData;
  }
}

/*
import 'package:dio/dio.dart';
import 'package:pibd31_egorov_pmu/data/dtos/films_dto.dart';
import 'package:pibd31_egorov_pmu/data/mappers/films_mapper.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../domain/models/card.dart';

import 'api_interface.dart';

class FilmRepository extends ApiInterface {
  static final Dio _dio = Dio()
    ..interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
    ));

  static const String _baseUrl = 'https://api.kinopoisk.dev';

  @override
  Future<List<CardData>?> loadData({String? q, OnErrorCallback? onError}) async {
    try {
      const String url = '$_baseUrl/v1/films';

      // Выполняем GET-запрос с параметрами фильтрации
      final Response<Map<String, dynamic>> response = await _dio.get<Map<String, dynamic>>(
        url,
        queryParameters: q != null ? {'filter[name_cont]': q} : null,
      );

      // Проверяем, что ответ содержит данные
      if (response.data == null) {
        onError?.call('Нет данных в ответе');
        return null;
      }

      // Преобразуем JSON в DTO
      final FilmsDto dto = FilmsDto.fromJson(response.data!);

      // Преобразуем DTO в доменные модели
      final List<CardData>? data = dto.data?.map((e) => e.toDomain()).toList();

      return data;
    } on DioException catch (e) {
      // Обработка ошибок сети или сервера
      onError?.call(e.response?.statusMessage ?? e.message);
      return null;
    } catch (e) {
      // Обработка других ошибок
      onError?.call(e.toString());
      return null;
    }
  }
}
*/