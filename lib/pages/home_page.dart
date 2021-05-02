import 'package:flutter/material.dart';
import 'package:flutter_presentation/models/movie.dart';
import 'package:flutter_presentation/services/api.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Movie> movies = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Most Popular Movies"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: StreamBuilder(
          stream: API.getPopularMovies(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              movies.add(snapshot.data as Movie);
            }

            if (movies.isNotEmpty) {
              return GridView.extent(
                maxCrossAxisExtent: 300.0,
                crossAxisSpacing: 30.0,
                childAspectRatio: 0.6,
                children: movies
                    .map((movie) => Image.network(
                          movie.image,
                          width: 350.0,
                          fit: BoxFit.contain,
                        ))
                    .toList(),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
