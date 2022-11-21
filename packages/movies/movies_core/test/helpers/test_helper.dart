import 'package:core/core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:movies_core/movies_core.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelper,
  FirebaseCrashlytics,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
