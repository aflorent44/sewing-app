import 'package:flutter/material.dart';
import 'package:mon_app_couture/core/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _email;

  @override
  void initState() {
    super.initState();
    _loadEmail();
  }

  Future<void> _loadEmail() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = prefs.getString('email');
    });
  }

  @override
  /// Affiche l'écran du profil avec un bouton pour se déconnecter.
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize
              .min, // Pour que la colonne ne prenne pas tout l’espace vertical
          children: [
            Text("Profil"),
            SizedBox(height: 20), // Un espace entre les widgets
            Text("Email: $_email"),
            SizedBox(height: 20),
            Text("Choisir le thème"),
            IconButton(
                icon: Icon(
                themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              ),
              onPressed: () => Provider.of<ThemeProvider>(context, listen:false).toggleTheme(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove(
                  'isLoggedIn',
                ); // Suppression du flag de session

                // Redirection vers l'écran de connexion
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/welcome',
                  (route) => false,
                );
              },
              child: Text("Déconnexion"),
            ),
          ],
        ),
      ),
    );
  }
}
