import 'package:json_annotation/json_annotation.dart';

part 'films_dto.g.dart';

// Вспомогательные функции для обработки данных
String? _toString(dynamic value) {
  if (value == null) return null;
  return value.toString();
}

List<String>? _listOfStringsFromJson(dynamic json) {
  if (json == null || json is! List) return null;
  return json
      .whereType<dynamic>()
      .map((e) => e != null ? e.toString() : null)
      .where((element) => element != null)
      .cast<String>()
      .toList();
}

// Обработка вложенных объектов genres и countries (массив объектов с полем 'name')
List<String>? _listOfGenreNames(dynamic json) {
  if (json == null || json is! List) return null;
  return json
      .whereType<Map<String, dynamic>>()
      .map((item) => item['name'] as String?)
      .where((name) => name != null)
      .cast<String>()
      .toList();
}

// Обработка poster: извлечение URL из объекта
String? _posterUrlFromJson(dynamic json) {
  if (json == null || json is! Map<String, dynamic>) return null;
  return json['url'] as String?;
}

// Модель для списка фильмов
@JsonSerializable(createToJson: false)
class FilmsDto {
  @JsonKey(name: 'docs')
  final List<FilmDataDto>? docs;
  final MetaDto? meta;

  const FilmsDto({this.docs, this.meta});

  factory FilmsDto.fromJson(Map<String, dynamic> json) =>
      _$FilmsDtoFromJson(json);
}

// Модель для отдельного фильма
@JsonSerializable(createToJson: false)
class FilmDataDto {
  @JsonKey(fromJson: _toString)
  final String? id;

  @JsonKey(fromJson: _toString)
  final String? name;

  @JsonKey(fromJson: _toString)
  final String? alternativeName;

  @JsonKey(fromJson: _toString)
  final String? type;

  @JsonKey(fromJson: _toString)
  final String? year;

  @JsonKey(fromJson: _listOfGenreNames)
  final List<String>? genres;

  @JsonKey(fromJson: _listOfGenreNames)
  final List<String>? countries;

  @JsonKey(fromJson: _posterUrlFromJson)
  final String? poster;

  // Можно добавить другие поля по необходимости

  const FilmDataDto({
    this.id,
    this.name,
    this.alternativeName,
    this.type,
    this.year,
    this.genres,
    this.countries,
    this.poster,
  });

  factory FilmDataDto.fromJson(Map<String, dynamic> json) =>
      _$FilmDataDtoFromJson(json);
}
@JsonSerializable(createToJson: false)
class MetaDto {
  final PaginationDto? pagination;

  const MetaDto({this.pagination});

  factory MetaDto.fromJson(Map<String, dynamic> json) =>
      _$MetaDtoFromJson(json);
}
@JsonSerializable(createToJson: false)
class PaginationDto {
  final int? current;
  final int? next;
  final int? last;
  final int? records;

  const PaginationDto({this.current, this.next, this.last, this.records});

  factory PaginationDto.fromJson(Map<String, dynamic> json) =>
      _$PaginationDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class FilmAttributesDataDto {
  final String? name;
  final String? alternativeName;
  final String? type;
  final String? year;
  final String? genres;
  final String? countries;
  final String? poster;
  const FilmAttributesDataDto({
    this.name, //название
    this.alternativeName, // альтернативное название (например в другой стране)
    this.type, // тип в коде
    this.year, //год производства
    this.genres, //жанры
    this.countries, //ингредиенты
    this.poster, //картинка
  });
  factory FilmAttributesDataDto.fromJson(Map<String, dynamic> json) =>
      _$FilmAttributesDataDtoFromJson(json);
}
