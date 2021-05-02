import 'package:flutter/material.dart';
import 'package:flutter_presentation/services/api.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    API.getPopularMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
