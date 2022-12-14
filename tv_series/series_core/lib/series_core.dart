library series_core;

export 'data/datasources/series_local_data_source.dart';
export 'data/datasources/series_remote_data_source.dart';
export 'data/models/episode_to_air_model.dart';
export 'data/models/season_model.dart';
export 'data/models/series_detail_model.dart';
export 'data/models/series_model.dart';
export 'data/models/series_response.dart';
export 'data/models/series_table.dart';
export 'data/repositories/series_repository_impl.dart';
export 'domain/entities/episode_to_air.dart';
export 'domain/entities/last_episode_to_air.dart';
export 'domain/entities/season.dart';
export 'domain/entities/series.dart';
export 'domain/entities/series_detail.dart';
export 'domain/repositories/series_repository.dart';
export 'domain/usecases/get_on_the_air_series.dart';
export 'domain/usecases/get_popular_series.dart';
export 'domain/usecases/get_series_recommendations.dart';
export 'domain/usecases/get_top_rated_series.dart';
export 'domain/usecases/get_watchlist_series.dart';
export 'domain/usecases/get_watchlist_series_status.dart';
export 'domain/usecases/remove_watchlist_series.dart';
export 'domain/usecases/save_watchlist_series.dart';
export 'presentation/pages/home_series_page.dart';
export 'presentation/pages/on_the_air_series_page.dart';
export 'presentation/pages/popular_series_page.dart';
export 'presentation/pages/season_detail_page.dart';
export 'presentation/pages/top_rated_series_page.dart';
export 'presentation/pages/watchlist_series_page.dart';
export 'presentation/bloc/on_the_air_series_bloc.dart';
export 'presentation/bloc/popular_series_bloc.dart';
export 'presentation/bloc/top_rated_series_bloc.dart';
export 'presentation/bloc/watchlist_series_bloc.dart';
export 'presentation/widgets/series_card_list.dart';
