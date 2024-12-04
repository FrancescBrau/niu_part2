import 'package:flutter/material.dart';
import 'package:niu_part2/config/themes.dart';
import 'package:niu_part2/features/auth/auth_screen.dart';
import 'package:niu_part2/home_screen.dart';
import 'package:niu_part2/shared/repositories/database_repository.dart';
import 'package:niu_part2/shared/repositories/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

late DatabaseRepository databaseRepository;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  databaseRepository = SharedPreferencesRepository(prefs);

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool isDarkTheme = true;

  void _toggleTheme() {
    setState(() {
      isDarkTheme = !isDarkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      title: 'Niu App',
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthScreen(),
        '/home': (context) => HomeScreen(
              toggleTheme: _toggleTheme,
              isDarkTheme: isDarkTheme,
              databaseRepository: databaseRepository,
            ),
      },
    );
  }
}
