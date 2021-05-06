import 'package:flutter/material.dart';
import 'package:flutter_presentation/models/movie.dart';
import 'package:flutter_presentation/pages/movie_page.dart';

class MovieWidget extends StatefulWidget {
  final Movie movie;

  MovieWidget({required this.movie});

  @override
  _MovieWidgetState createState() => _MovieWidgetState();
}

class _MovieWidgetState extends State<MovieWidget> {
  bool showContainer = false;
  bool showText = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MoviePage(movie: widget.movie),
          ),
        );
      },
      onHover: (entered) {
        setState(() {
          if (entered) {
            showContainer = true;
          } else if (!entered && showContainer && !showText) {
            showContainer = false;
          } else {
            showText = false;
          }
        });
      },
      child: Stack(
        children: [
          Image.network(
            widget.movie.image,
            width: 300.0,
            height: 300.0 / 0.7,
            fit: BoxFit.fill,
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              width: 300.0,
              height: showContainer ? (300 / 0.6) / 4 : 0.0,
              color: Colors.black.withOpacity(0.6),
              duration: Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              onEnd: () {
                if (showContainer) {
                  setState(() {
                    showText = true;
                  });
                }
              },
              child: AnimatedOpacity(
                opacity: showText ? 1.0 : 0.0,
                duration: Duration(milliseconds: 100),
                curve: Curves.easeIn,
                onEnd: () {
                  if (!showText) {
                    setState(() {
                      showContainer = false;
                    });
                  }
                },
                child: _getMovieInfo(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getMovieInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${widget.movie.title} (${widget.movie.year})",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 22.0),
        ),
        Padding(padding: const EdgeInsets.all(8.0)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.star,
              color: Colors.yellow[700],
            ),
            Padding(padding: const EdgeInsets.all(8.0)),
            Text(
              widget.movie.rating != null
                  ? widget.movie.rating.toString()
                  : "No rating",
              style: TextStyle(color: Colors.white, fontSize: 22.0),
            ),
          ],
        ),
      ],
    );
  }
}
