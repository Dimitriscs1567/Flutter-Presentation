import 'package:flutter/material.dart';
import 'package:flutter_presentation/models/movie.dart';

class BigMovieInfoWidget extends StatelessWidget {
  final Movie movie;

  BigMovieInfoWidget({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.8),
      alignment: Alignment.center,
      child: Container(
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
                  child: Column(
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
                              fontSize: 17.0,
                              color: Colors.white,
                            ),
                          ),
                          _iconText(
                              movie.year.toString(), Icons.calendar_today),
                          _iconText(
                              movie.duration ?? "Not Available", Icons.timer),
                          _iconText(
                            movie.rating != null
                                ? movie.rating.toString()
                                : "Not available",
                            Icons.star,
                          ),
                        ],
                      ),
                      Padding(padding: const EdgeInsets.all(8.0)),
                      Text(
                        movie.plot,
                        style: TextStyle(color: Colors.grey[400], fontSize: 16),
                        maxLines: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 26.0),
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
          ],
        ),
      ),
    );
  }

  Widget _iconText(String text, IconData icon) {
    return Row(
      children: [
        Padding(padding: const EdgeInsets.all(10.0)),
        Icon(
          icon,
          color: Colors.white,
          size: 16.0,
        ),
        Padding(padding: const EdgeInsets.all(3.0)),
        Text(
          text,
          style: TextStyle(
            fontSize: 17.0,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
