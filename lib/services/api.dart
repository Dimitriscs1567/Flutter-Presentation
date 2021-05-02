import 'package:flutter_presentation/models/movie.dart';
import 'package:http/http.dart' as http;

class API {
  static Stream<Movie> getPopularMovies() async* {
    String movieSplit = '<td class="posterColumn">';
    String imageSplitStart = 'img src="';
    String imageSplitEnd = '" width';

    var response = await http.get(
        Uri.parse("https://www.imdb.com/chart/moviemeter/?ref_=nv_mv_mpm"));

    String rawBody = response.body;
    List<String> rawMovies = rawBody.split(movieSplit);

    rawMovies.forEach((rawMovie) {
      if (rawMovie.contains(imageSplitStart)) {
        String image =
            rawMovie.split(imageSplitStart)[1].split(imageSplitEnd)[0];
      }
    });
  }
}
