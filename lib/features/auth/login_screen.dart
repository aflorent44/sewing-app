import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir votre email';
                  }
                  return null;
                },
                onSaved: (value) => _email = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Mot de passe'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir votre mot de passe';
                  }
                  return null;
                },
                onSaved: (value) => _password = value!,
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: () async {
                  print('Login button pressed');
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    bool success = await loginUser(_email, _password);
                    if (success) {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setString('email', _email);
                      await prefs.setBool('isLoggedIn', true);
                      // Naviguer vers la page d’accueil
                      Navigator.pushReplacementNamed(context, '/main');
                    } else {
                      // Afficher un message d’erreur
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Email ou mot de passe incorrect'),
                        ),
                      );
                    }
                  }
                },
                child: const Text('Se connecter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool> loginUser(String email, String password) async {

  try {
    final url = Uri.parse(
      'http://192.168.1.21:3000/login',
    ); // remplace par ton IP
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    return response.statusCode == 200;
  } catch (e) {
    print('Erreur pendant la requête HTTP : $e');
    return false;
  }
}
