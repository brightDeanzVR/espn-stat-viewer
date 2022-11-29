class Rebounds {
  final List<int> rebs;

  const Rebounds({required this.rebs});

  factory Rebounds.fromJson(Map<String, dynamic> json) {
    return Rebounds(rebs: json['Rebounds']);
  }

  Map<String, dynamic> toJson() {
    return {
      'Rebounds': rebs,
    };
  }
}
