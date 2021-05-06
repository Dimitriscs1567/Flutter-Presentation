class Movie {
  String _title;
  String _image;
  String _plot;
  String? _duration;
  List<String> _categories;
  int _year;
  double? _rating;

  Movie(this._title, this._image, this._plot, this._duration, this._categories,
      this._year, this._rating);

  String get title => this._title;

  String get image => this._image;

  String get plot => this._plot;

  String? get duration => this._duration;

  String get categories => this._categories.join(", ");

  int get year => this._year;

  double? get rating => this._rating;
}
