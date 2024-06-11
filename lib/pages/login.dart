import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../components/snackbar.dart';
import '../services/service_api/users_api.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback toggleView;

  const LoginPage({super.key, required this.toggleView});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscurePassword = true;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        // Make the API call to login
        Response response = await UserAPI.instance.login(
          _email.text,
          _password.text,
        );

        // Handle successful response
        if (response.statusCode == 200) {
          // Save token to secure storage
          const storage = FlutterSecureStorage();
          await storage.write(
              key: 'token', value: response.data['access_token']);

          // Navigate to home screen
          Navigator.pushNamed(context, '/home');
          showSnackbar(context, 'Login Successfully');
        } else {
          showSnackbar(context, 'Login failed: ${response.data['detail']}');
        }
      } catch (e) {
        showSnackbar(context, 'An error Occurred: $e ');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Login',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(
              height: 30.0,
            ),
            const SizedBox(height: 26),
            TextFormField(
              controller: _email,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                labelText: 'Email',
                prefixIcon: const Icon(Icons.person),
              ),
              validator: (value) {
                EmailValidator.validate(value!);
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _password,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword; // Toggle visibility
                    });
                  },
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            const SizedBox(height: 84),
            OutlinedButton(
              onPressed: _login,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 8,
                ),
              ),
              child: const Text(
                'Login',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            TextButton(
              onPressed: widget.toggleView,
              child: const Text('Create a new account? Register here.'),
            ),
          ],
        ),
      ),
    );
  }
}
