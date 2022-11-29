class Player {
  final String name;
  final String id;

  Player({required this.name, required this.id});

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(name: json['name'], id: json['id']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
    };
  }
}
