import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:universal_io/io.dart';

import 'package:flutter_presentation/models/movie.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class API {
  static Stream<List<Movie>> getPopularMovies() async* {
    String movieSplit = '<td class="posterColumn">';
    String titleSplitStart = '<td class="titleColumn">';
    String titleSplitEnd = '</a>';
    String yearSplitStart = '<span class="secondaryInfo">(';
    String yearSplitEnd = ')</span>';
    String imageSplitStart = '<div class="poster">';
    String plotSplitStart = '<h2>Storyline</h2>';
    String ratingSplitStart = '<strong title="';
    String ratingSplitEnd = '">';
    String durationSplitStart = '<time datetime=';
    String categoriesSplitStart = 'title="See more release dates"';

    var response = await http.get(
        Uri.parse("https://www.imdb.com/chart/moviemeter/?ref_=nv_mv_mpm"));

    String rawBody = response.body;
    List<String> rawMovies = rawBody.split(movieSplit);
    List<Movie> movies = [];

    for (String rawMovie in rawMovies) {
      if (rawMovie.contains(titleSplitStart)) {
        String moreInfoRequest = rawMovie
            .split(titleSplitStart)[1]
            .split('<a href="')[1]
            .split('"')[0];

        var moreInfoResponse =
            await http.get(Uri.parse("https://www.imdb.com$moreInfoRequest"));

        String image = moreInfoResponse.body
            .split(imageSplitStart)[1]
            .split('src="')[1]
            .split('"')[0];

        String plot = moreInfoResponse.body
            .split(plotSplitStart)[1]
            .split("<span>")[1]
            .split("</span>")[0]
            .trim();

        String? duration;
        if (moreInfoResponse.body.contains(durationSplitStart)) {
          duration = moreInfoResponse.body
              .split(durationSplitStart)[1]
              .split('">')[1]
              .split("</time>")[0]
              .trim();
        }

        String allCategories = moreInfoResponse.body
            .split('<div class="title_wrapper">')[1]
            .split('<div class="subtext">')[1]
            .split(categoriesSplitStart)[0];

        List<String> categories = [];
        allCategories.split("\n<a href=\"").forEach((rawCategory) {
          if (rawCategory.contains(">")) {
            String category = rawCategory.split('>')[1].split("</a")[0];
            if (!category.contains("</span") && !category.contains("</time")) {
              categories.add(category);
            }
          }
        });

        String title = rawMovie
            .split(titleSplitStart)[1]
            .split('" >')[1]
            .split(titleSplitEnd)[0];

        int year =
            int.parse(rawMovie.split(yearSplitStart)[1].split(yearSplitEnd)[0]);

        double? rating;
        if (rawMovie.contains(ratingSplitStart)) {
          String ratingString =
              rawMovie.split(ratingSplitStart)[1].split(ratingSplitEnd)[0];
          rating = double.parse(ratingString.split("based")[0]);
        }

        movies.add(Movie(
            title, image, plot, duration, categories.join(", "), year, rating));

        yield [
          Movie(
              title, image, plot, duration, categories.join(", "), year, rating)
        ];
      }
    }

    if (Platform.isWindows) {
      saveData(movies);
    }
  }

  static Future<void> saveData(List<Movie> movies) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      File file = File(
          '${directory.path}\\projects\\flutter_presentation\\assets\\movies.json');
      file.writeAsString(
          JsonEncoder().convert(movies.map((e) => e.toJson()).toList()));
    } catch (e) {
      print(e.toString());
    }
  }

  static Stream<List<Movie>> getData(BuildContext context) async* {
    String contents =
        (await DefaultAssetBundle.of(context).loadString("assets/movies.json"))
            .replaceAll('\\"', '');

    List<Movie> movies = [];

    List<dynamic> moviesJsons = JsonDecoder().convert(contents);
    for (dynamic movieJson in moviesJsons) {
      movies.add(Movie.fromJson(movieJson));
    }

    yield movies;
  }
}
