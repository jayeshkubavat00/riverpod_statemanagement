import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_statemanagement/modules/failure.dart';
import 'package:riverpod_statemanagement/modules/movie_trailler/models/movies_trillers_model.dart';
import 'package:riverpod_statemanagement/services/api_services_impl.dart';

var movieTraillerRepository =
    Provider<MovieTraillerRepository>((ref) => MovieTraillerRepository());

class MovieTraillerRepository {
  Future<Either<Failure, MoviesTraillerModel>> getMoviesTrailler(
      {Map<String, dynamic>? parms}) async {
    try {
      final response = await ApiServiceImpl().postRequest(
        endpoint: "https://hoblist.com/api/movieList",
        data: parms,
        isXWwwForm: true,
      );
      log("response: $response");
      if (response.statusCode == 200) {
        return Right(MoviesTraillerModel.fromJson(response.data));
      } else {
        return Left(Failure(message: "somthing is wrong"));
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
