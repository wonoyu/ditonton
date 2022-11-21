import 'package:core/core.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:movies/movies.dart';
import 'package:tv_series/tv_series.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  SeriesRepository,
  SeriesRemoteDataSource,
  SeriesLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
