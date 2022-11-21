import 'package:equatable/equatable.dart';
import 'package:series_core/series_core.dart';

class SeriesTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  const SeriesTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  factory SeriesTable.fromEntity(SeriesDetail movie) => SeriesTable(
        id: movie.id,
        name: movie.name,
        posterPath: movie.posterPath,
        overview: movie.overview,
      );

  factory SeriesTable.fromMap(Map<String, dynamic> map) => SeriesTable(
        id: map['id'],
        name: map['name'],
        posterPath: map['posterPath'],
        overview: map['overview'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'posterPath': posterPath,
        'overview': overview,
      };

  Series toEntity() => Series.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        name: name,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, posterPath, overview];
}
