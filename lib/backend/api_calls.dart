import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class BackendApi {
  static const String baseUrl = 'http://localhost:8000';
  static const String playerPath = '/nba/player/';
  static const String playerStatPath = '/stats';

  static Future<http.Response> getPlayersByLastName(String lastName) {
    return http.get(
      Uri.parse('$baseUrl$playerPath$lastName'),
    );
  }

  static Future<http.Response> getPlayerStats(String id) {
    return http.get(
      Uri.parse('$baseUrl$playerPath$id$playerStatPath'),
    );
  }
}
