import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/fabric.dart';

Future<List<Fabric>> fetchFabrics() async {
  final url = Uri.parse(
    'http://192.168.1.21:3000/fabric',
  ); // Mets ton IP locale

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => Fabric.fromJson(json)).toList();
  } else {
    throw Exception('Erreur lors du chargement des tissus');
  }
}
