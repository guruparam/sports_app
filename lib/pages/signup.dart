import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../components/snackbar.dart';
import '../services/service_api/users_api.dart';

class RegistrationPage extends StatefulWidget {
  final VoidCallback toggleView;

  const RegistrationPage({super.key, required this.toggleView});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _register() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        // Make the API call to login
        Response response = await UserAPI.instance.register(
          _firstnameController.text,
          _lastnameController.text,
          _emailController.text,
          _passwordController.text,
        );

        // Handle successful response
        if (response.statusCode == 200) {
          // Save token to secure storage
          // Navigate to home screen
          Navigator.pushNamed(context, '/auth');
          showSnackbar(context, 'User created Successfully');
        } else {
          showSnackbar(context, 'Registration failed: ${response.data}');
        }
      } on DioException catch (e) {
        // Handle error response
        if (e.response != null && e.response!.statusCode == 400) {
          showSnackbar(context, 'Registration failed: ${e.response!.data}');
        } else {
          // Handle network or other errors
          showSnackbar(context, 'An error occurred: ${e.message}');
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
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text(
              'Register',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(
              height: 30.0,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _firstnameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                labelText: 'First Name',
                prefixIcon: const Icon(Icons.person),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _lastnameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                labelText: 'Last Name',
                prefixIcon: const Icon(Icons.person),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
              // onSaved: (value) {
              //   _username = value!;
              // },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                labelText: 'Email',
                prefixIcon: const Icon(Icons.email),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an email address';
                }
                // Add additional email validation if needed
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
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
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a password';
                }
                // Add additional password validation if needed
                return null;
              },
            ),
            const SizedBox(height: 24),
            OutlinedButton(
              onPressed: _register,
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
                'Register',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            TextButton(
              onPressed: widget.toggleView,
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}
