class Movie {
  String _title;
  String _image;
  String _plot;
  String? _duration;
  String _categories;
  int _year;
  double? _rating;

  Movie(this._title, this._image, this._plot, this._duration, this._categories,
      this._year, this._rating);

  static Movie fromJson(Map<String, dynamic> body) {
    String title = body["title"];
    String image = body["image"];
    String plot = body["plot"];
    String? duration = body["duration"] ?? null;
    String categories = body["categories"];
    int year = body["year"];
    double? rating = body["rating"] ?? null;

    return Movie(title, image, plot, duration, categories, year, rating);
  }

  String get title => this._title;

  String get image => this._image;

  String get plot => this._plot;

  String? get duration => this._duration;

  String get categories => this._categories;

  int get year => this._year;

  double? get rating => this._rating;

  Map<String, dynamic> toJson() {
    return {
      "title": this._title,
      "image": this._image,
      "plot": this._plot,
      "duration": this._duration,
      "categories": this._categories,
      "year": this._year,
      "rating": this._rating,
    };
  }
}
