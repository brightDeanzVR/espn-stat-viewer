import 'package:betviewapp/models/stats/assists.dart';
import 'package:betviewapp/models/stats/points.dart';
import 'package:betviewapp/models/stats/rebounds.dart';

class PlayerStats {
  final List<String> rebounds;
  final List<String> assists;
  final List<String> points;

  const PlayerStats(
      {required this.rebounds, required this.assists, required this.points});

  factory PlayerStats.fromJson(Map<String, dynamic> json) {
    return PlayerStats(
      rebounds: json['Rebounds'],
      assists: json['Assists'],
      points: json['Points'],
    );
  }
}
