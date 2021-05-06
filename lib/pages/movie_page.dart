import 'package:flutter/material.dart';
import 'package:flutter_presentation/models/movie.dart';
import 'package:flutter_presentation/widgets/big_movie_info_widget.dart';

class MoviePage extends StatelessWidget {
  final Movie movie;

  MoviePage({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 900) {
            return BigMovieInfoWidget(movie: movie);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
