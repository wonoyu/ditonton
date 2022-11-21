import 'package:core/core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:series_core/series_core.dart';

@GenerateMocks([
  SeriesRepository,
  SeriesRemoteDataSource,
  SeriesLocalDataSource,
  DatabaseHelper,
  FirebaseCrashlytics,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
