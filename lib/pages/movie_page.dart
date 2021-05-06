import 'package:flutter/material.dart';
import 'package:flutter_presentation/models/movie.dart';

class MoviePage extends StatelessWidget {
  final Movie movie;

  MoviePage({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black.withOpacity(0.8),
        alignment: Alignment.center,
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 900) {
              return Container(
                width: 900,
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                          movie.image,
                          fit: BoxFit.fill,
                          width: 250.0,
                        ),
                        Padding(padding: const EdgeInsets.all(20.0)),
                        Expanded(
                          child: _movieInfo(false),
                        ),
                      ],
                    ),
                    _backButton(context, false),
                  ],
                ),
              );
            } else {
              return Stack(
                children: [
                  Center(
                    child: Opacity(
                      opacity: 0.5,
                      child: Image.network(
                        movie.image,
                        height: MediaQuery.of(context).size.height - 10,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: _movieInfo(true),
                  ),
                  _backButton(context, true),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _movieInfo(bool small) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${movie.title} (${movie.year})",
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Padding(padding: const EdgeInsets.all(8.0)),
        Row(
          children: [
            Text(
              movie.categories,
              style: TextStyle(
                fontSize: small ? 15.0 : 17.0,
                color: Colors.white,
              ),
            ),
            _iconText(movie.year.toString(), Icons.calendar_today, small),
            _iconText(movie.duration ?? "Not Available", Icons.timer, small),
            _iconText(
              movie.rating != null ? movie.rating.toString() : "Not available",
              Icons.star,
              small,
            ),
          ],
        ),
        Padding(padding: const EdgeInsets.all(8.0)),
        Text(
          movie.plot,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: small ? 14.0 : 16.0,
          ),
          maxLines: 20,
        ),
      ],
    );
  }

  Widget _iconText(String text, IconData icon, bool small) {
    return Row(
      children: [
        Padding(padding: new EdgeInsets.all(small ? 8.0 : 10.0)),
        Icon(
          icon,
          color: Colors.white,
          size: small ? 14.0 : 16.0,
        ),
        Padding(padding: const EdgeInsets.all(3.0)),
        Text(
          text,
          style: TextStyle(
            fontSize: small ? 15.0 : 17.0,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _backButton(BuildContext context, bool small) {
    return Padding(
      padding: const EdgeInsets.only(top: 26.0),
      child: Container(
        color: small ? Colors.grey[800] : Colors.transparent,
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
