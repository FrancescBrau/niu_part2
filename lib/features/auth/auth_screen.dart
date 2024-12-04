import 'package:flutter/material.dart';
import 'package:niu_part2/features/auth/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_model.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  AuthScreenState createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> {
  final TextEditingController _emailController = TextEditingController();
  late AuthRepository _authRepository;
  bool _isLoggingIn = true;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeRepository();
  }

  Future<void> _initializeRepository() async {
    final prefs = await SharedPreferences.getInstance();
    _authRepository = AuthRepository(prefs);
    setState(() {
      _isLoading = false;
    });
  }

  void _onAuthenticate() async {
    final email = _emailController.text.trim();
    final authModel = AuthModel(email: email);

    if (!authModel.isValid()) {
      _showSnackBar("Invalid email format");
      return;
    }

    final success = await _authRepository.authenticate(email);
    if (success) {
      _navigateToHome(); // Navega a la pantalla de inicio
    } else {
      _showSnackBar("Email not found. Please sign up.");
    }
  }

  void _onCreateUser() async {
    final email = _emailController.text.trim();
    final authModel = AuthModel(email: email);

    if (!authModel.isValid()) {
      _showSnackBar("Invalid email format");
      return;
    }

    final success = await _authRepository.createUser(email);
    if (success) {
      _showSnackBar("User registered successfully!");
      _navigateToHome(); // Navega a la pantalla de inicio
    } else {
      _showSnackBar("User already exists.");
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _navigateToHome() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _isLoggingIn ? _onAuthenticate : _onCreateUser,
                      child: Text(_isLoggingIn ? 'Log in' : 'Sign up'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLoggingIn = !_isLoggingIn;
                        });
                      },
                      child: Text(
                        _isLoggingIn
                            ? 'No account? Sign up'
                            : 'Already have an account? Log in',
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
