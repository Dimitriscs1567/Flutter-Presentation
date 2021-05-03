import 'package:flutter_presentation/models/movie.dart';
import 'package:http/http.dart' as http;

class API {
  static Stream<Movie> getPopularMovies() async* {
    String movieSplit = '<td class="posterColumn">';
    String titleSplitStart = '<td class="titleColumn">';
    String titleSplitEnd = '</a>';
    String yearSplitStart = '<span class="secondaryInfo">(';
    String yearSplitEnd = ')</span>';
    String imageSplitStart = '<div class="poster">';
    String imageSplitEnd = '" width';
    String ratingSplitStart = '<strong title="';
    String ratingSplitEnd = '">';

    var response = await http.get(
        Uri.parse("https://www.imdb.com/chart/moviemeter/?ref_=nv_mv_mpm"));

    String rawBody = response.body;
    List<String> rawMovies = rawBody.split(movieSplit);

    for (String rawMovie in rawMovies) {
      if (rawMovie.contains(titleSplitStart)) {
        String imageRequest = rawMovie
            .split(titleSplitStart)[1]
            .split('<a href="')[1]
            .split('"')[0];

        var imageResponse =
            await http.get(Uri.parse("https://www.imdb.com$imageRequest"));

        String image = imageResponse.body
            .split(imageSplitStart)[1]
            .split('src="')[1]
            .split('"')[0];

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

        yield Movie(title, image, year, rating);
      }
    }
  }
}
