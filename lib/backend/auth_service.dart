import 'dart:convert';
import 'package:http/http.dart' as http;

const baseUrl = 'http://127.0.0.1:8000';

Future<String?> login(String email, String password) async {
  final response = await http.post(
    Uri.parse('$baseUrl/login'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email': email, 'password': password}),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['access_token'];
  } else {
    return null;
  }
}

Future<bool> register(String email, String username, String password) async {
  final response = await http.post(
    Uri.parse('$baseUrl/register'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email': email, 'username': username, 'password': password}),
  );
  return response.statusCode == 200;
}
