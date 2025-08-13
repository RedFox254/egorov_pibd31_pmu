import '../../domain/models/card.dart';
import '../../domain/models/home.dart';
import '../dtos/films_dto.dart';
import '';

const _imagePlaceHolder =
    'https://www.shutterstock.com/image-vector/blank-image-placeholder-profile-picture-260nw-1923893873.jpg';

extension FilmDataDtoToModel on FilmDataDto {
  CardData toDomain() {
    final description = _makeDescription(this);
    return CardData(
      name ?? 'UNKNOWN',
      image: poster ?? _imagePlaceHolder,
      description: description,
    );
  }
}

String _makeDescription(FilmDataDto film) {
  final year = film.year ?? 'UNKNOWN';

  final genresStr = (film.genres != null && film.genres!.isNotEmpty)
      ? film.genres!.join(', ')
      : 'UNKNOWN';

  final countriesStr = (film.countries != null && film.countries!.isNotEmpty)
      ? film.countries!.join(', ')
      : 'UNKNOWN';

  return '''
date: $year,
genre: $genresStr,
country: $countriesStr,
''';
}
extension FilmsDtoToModel on FilmsDto {
  HomeData toDomain() => HomeData(
    data: docs?.map((e) => e.toDomain()).toList(),
    nextPage: meta?.pagination?.next,
  );
}
