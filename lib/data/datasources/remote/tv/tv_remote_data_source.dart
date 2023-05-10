import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tv_movie_app/data/models/tv/tv_response.dart';

import '../../../../common/exception.dart';
import '../../../models/tv/tv_detail_model.dart';
import '../../../models/tv/tv_model.dart';



abstract class TvRemoteDataSource {
  Future<List<TvModel>> getTvAiringToday();

  Future<List<TvModel>> getTvOnTheAir();

  Future<List<TvModel>> getTvTopRated();

  Future<List<TvModel>> getTvPopular();

  Future<TvDetailModel> getDetailTv(int id);

  Future<List<TvModel>> getTvRecommendations(int id);

  Future<List<TvModel>> searchTv(String query);
}

class TvRemoteDataSourceImpl extends TvRemoteDataSource {
  static const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const baseUrl = 'https://api.themoviedb.org/3';

  final http.Client client;

  TvRemoteDataSourceImpl({required this.client});

  @override
  Future<TvDetailModel> getDetailTv(int id) async {
    final response = await client.get(Uri.parse('$baseUrl/tv/$id?$apiKey'));
    if (response.statusCode == 200) {
      return TvDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTvAiringToday() async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/airing_today?$apiKey'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTvOnTheAir() async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey'));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTvPopular() async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/popular?$apiKey'));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTvRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$baseUrl/tv/$id/recommendations?$apiKey'));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    }
    throw ServerException();
  }

  @override
  Future<List<TvModel>> getTvTopRated() async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey'));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> searchTv(String query) async {
    final response = await client
        .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$query'));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }
}
