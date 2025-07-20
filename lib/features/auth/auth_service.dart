import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final _secureStorage = FlutterSecureStorage();

Future<bool> registerUser(String email, String password) async {
  final url = Uri.parse('http://192.168.1.21:3000/register');

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email': email, 'password': password}),
  );

  if (response.statusCode == 201) {
    return true;
  } else {
    print('Erreur : ${response.body}');
    return false;
  }
}

Future<bool> loginUser(String email, String password) async {
  final response = await http.post(
    Uri.parse('http://192.168.1.21:3000/login'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email': email, 'password': password}),
  );

  if (response.statusCode == 200) {
    final token = jsonDecode(response.body)['token'];
    await _secureStorage.write(key: 'jwt_token', value: token);
    return true;
  } else {
    return false;
  }
}

