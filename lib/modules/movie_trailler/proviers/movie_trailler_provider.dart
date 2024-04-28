import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_statemanagement/modules/movie_trailler/models/movies_trillers_model.dart';
import 'package:riverpod_statemanagement/modules/movie_trailler/repo/movie_trailler_repo.dart';

var movieTraillerProvider =
    ChangeNotifierProvider.autoDispose((ref) => MovieTraillerProvider(ref));

class MovieTraillerProvider extends ChangeNotifier {
  Ref ref;
  MovieTraillerProvider(this.ref) {
    getEmployeeData();
  }

  MoviesTraillerEnum moviesTraillerEnum = MoviesTraillerEnum.initial;
  List<MoviesTraillerData> moviesTraillerData = [];
  List<MoviesTraillerData>? get moviesTrailler => moviesTraillerData;

  getEmployeeData() async {
    await ref.read(movieTraillerRepository).getMoviesTrailler(parms: {
      "category": "movies",
      "language": "kannada",
      "genre": "all",
      "sort": "voting",
    }).then(
      (response) {
        moviesTraillerEnum = MoviesTraillerEnum.dataLoading;
        notifyListeners();
        response.fold(
          (error) => {throw error},
          (res) => {
            {
              moviesTraillerData = res.result,
              moviesTraillerEnum = MoviesTraillerEnum.dataLoaded,
              notifyListeners(),
            }
          },
        );
      },
    );
  }

  
}

enum MoviesTraillerEnum {
  initial,
  dataLoading,
  dataLoaded,
  dataError,
}
