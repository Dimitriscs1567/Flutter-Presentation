class Movie {
  String _name;
  int _year;
  double _rating;

  Movie(this._name, this._year, this._rating);

  String get name => this._name;

  int get year => this._year;

  double get rating => this._rating;
}
