class Movie {
  String _title;
  String _image;
  int _year;
  double? _rating;

  Movie(this._title, this._image, this._year, this._rating);

  String get title => this._title;

  String get image => this._image;

  int get year => this._year;

  double? get rating => this._rating;
}
