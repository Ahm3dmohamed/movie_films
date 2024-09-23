import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/service/models/newrealse_section.dart';
import 'package:movie_app/service/models/recommended_sction.dart';
import 'package:movie_app/service/models/search_model.dart';
import 'package:movie_app/service/models/top_side_movei_section.dart';
import 'package:movie_app/service/models/topside_details.dart';

class ApiManager {
  final String _apiKey = '1d442be9531cc906b3b584d93cfb491c';
  final String _searchApi =
      'https://api.themoviedb.org/3/search/movie?api_key=';

  final String _sideApiSection =
      "https://api.themoviedb.org/3/movie/popular?api_key=";

// https://api.themoviedb.org/3/movie/533535?api_key=1d442be9531cc906b3b584d93cfb491c
//   final String _searchApi = 'https://api.themoviedb.org/3/search/movie?api_key=1d442be9531cc906b3b584d93cfb491c';

  final String _newRealseSection =
      "https://api.themoviedb.org/3/movie/upcoming?api_key=";
  final String _recomendedSection =
      "https://api.themoviedb.org/3/movie/top_rated?api_key=";

  final String _topsideDetails =
      "https://api.themoviedb.org/3/movie/533535?api_key=";

  Future<TopSideMovei> getTopSideMovei() async {
    try {
      final response = await http.get(Uri.parse('$_sideApiSection$_apiKey'));

      if (response.statusCode == 200) {
        return TopSideMovei.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Failed to load Data");
      }
    } catch (e) {
      throw Exception("Failed to load API: $e");
    }
  }

  Future<NewRealeaseSection> getNewRealseMovei() async {
    try {
      final response = await http.get(Uri.parse('$_newRealseSection$_apiKey'));

      if (response.statusCode == 200) {
        return NewRealeaseSection.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Failed to load Data");
      }
    } catch (e) {
      throw Exception("Failed to load API: $e");
    }
  }

  Future<RecommendedSection> getRecomendedSection() async {
    try {
      final response = await http.get(Uri.parse('$_recomendedSection$_apiKey'));

      if (response.statusCode == 200) {
        return RecommendedSection.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Failed to load Data");
      }
    } catch (e) {
      throw Exception("Failed to load API: $e");
    }
  }

  Future<TopSideDetailsModel> getTopSideDetails() async {
    try {
      final response = await http.get(Uri.parse('$_topsideDetails$_apiKey'));

      if (response.statusCode == 200) {
        return TopSideDetailsModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Failed to load Data");
      }
    } catch (e) {
      throw Exception("Failed to load API: $e");
    }
  }

  Future<SearchModel> getSearchData(String query) async {
    try {
      final response =
          await http.get(Uri.parse('$_searchApi$_apiKey&query=$query'));

      if (response.statusCode == 200) {
        return SearchModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Failed to load Data");
      }
    } catch (e) {
      throw Exception("Failed to load API: $e");
    }
  }
}
