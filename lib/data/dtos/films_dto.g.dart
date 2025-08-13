// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'films_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilmsDto _$FilmsDtoFromJson(Map<String, dynamic> json) => FilmsDto(
      docs: (json['docs'] as List<dynamic>?)
          ?.map((e) => FilmDataDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : MetaDto.fromJson(json['meta'] as Map<String, dynamic>),
    );

FilmDataDto _$FilmDataDtoFromJson(Map<String, dynamic> json) => FilmDataDto(
      id: _toString(json['id']),
      name: _toString(json['name']),
      alternativeName: _toString(json['alternativeName']),
      type: _toString(json['type']),
      year: _toString(json['year']),
      genres: _listOfGenreNames(json['genres']),
      countries: _listOfGenreNames(json['countries']),
      poster: _posterUrlFromJson(json['poster']),
    );

MetaDto _$MetaDtoFromJson(Map<String, dynamic> json) => MetaDto(
      pagination: json['pagination'] == null
          ? null
          : PaginationDto.fromJson(json['pagination'] as Map<String, dynamic>),
    );

PaginationDto _$PaginationDtoFromJson(Map<String, dynamic> json) =>
    PaginationDto(
      current: json['current'] as int?,
      next: json['next'] as int?,
      last: json['last'] as int?,
      records: json['records'] as int?,
    );

FilmAttributesDataDto _$FilmAttributesDataDtoFromJson(
        Map<String, dynamic> json) =>
    FilmAttributesDataDto(
      name: json['name'] as String?,
      alternativeName: json['alternativeName'] as String?,
      type: json['type'] as String?,
      year: json['year'] as String?,
      genres: json['genres'] as String?,
      countries: json['countries'] as String?,
      poster: json['poster'] as String?,
    );
