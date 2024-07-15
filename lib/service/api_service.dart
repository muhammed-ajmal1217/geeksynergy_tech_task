import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:greeksinergy_tech_movie_app/model/get_model.dart';
import 'package:greeksinergy_tech_movie_app/model/post_model.dart';

class ApiService {
  final Dio dio = Dio();

  Future<void> postData(PostModel post) async {
    final url = 'https://hoblist.com/api/movieList';
    try {
      Map<String, dynamic> postData = post.toJson();
      await dio.post(url, data: postData);
    } catch (e) {
      throw Exception('Error posting data: $e');
    }
  }

  Future<List<GetModel>> fetchMovies() async {
    final url = 'https://hoblist.com/api/movieList';
    try {
      Response response = await dio.post(
        url,
        data: {
          "category": "movies",
          "language": "tamil",
          "genre": "all",
          "sort": "voting",
        },
      );
      if (response.statusCode == 200) {
        if (response.data != null && response.data['result'] != null) {
          List<GetModel> fetchedMovies = (response.data['result'] as List)
              .map((item) => GetModel.fromJson(item))
              .toList();
          return fetchedMovies;
        } else {
          throw Exception('Error in Fetching');
        }
      } else {
        throw Exception(
            'Failed to fetch : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
