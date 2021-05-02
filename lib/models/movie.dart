class Movie {
  String _name;
  String _image;
  int _year;
  double? _rating;

  Movie(this._name, this._image, this._year, this._rating);

  String get name => this._name;

  String get image => this._image;

  int get year => this._year;

  double? get rating => this._rating;
}
