class Points {
  final List<int> pts;

  const Points({required this.pts});

  factory Points.fromJson(Map<String, dynamic> json) {
    return Points(pts: json['Points']);
  }

  Map<String, dynamic> toJson() {
    return {
      'Points': pts,
    };
  }
}
