class Assists {
  final List<int> asts;

  const Assists({required this.asts});

  factory Assists.fromJson(Map<String, dynamic> json) {
    return Assists(asts: json['Assists']);
  }

  Map<String, dynamic> toJson() {
    return {
      'Assists': asts,
    };
  }
}
