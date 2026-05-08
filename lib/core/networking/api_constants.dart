import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static const String baseUrl = 'https://listen-api.listennotes.com/api/v2';
  static String get apiKey => dotenv.get('LISTEN_NOTES_API_KEY');
}
