class Rating {
  Rating({required this.rate, required this.count});

  Rating.empty() : rate = 0.0, count = 0;

  Rating.fromJson(Map<String, dynamic> json)
    : rate = (json['rate'] as num?)?.toDouble() ?? 0.0,
      count = (json['count'] as num?)?.toInt() ?? 0;

  double rate;
  int count;

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'count': count,
    };
  }

  @override
  String toString() {
    return 'Rating('
        'rate: $rate, '
        'count: $count) ';
  }
}
