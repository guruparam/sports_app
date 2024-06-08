import 'package:flutter/material.dart';
import 'package:sports_app/pages/login.dart';
import 'package:sports_app/pages/signup.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final PageController _pageController = PageController();
  bool _isLoginPage = true;

  void toggleView() {
    setState(() {
      _isLoginPage = !_isLoginPage;
      _pageController.animateToPage(
        _isLoginPage ? 0 : 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 87, 86, 86),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    padding: const EdgeInsets.all(20.0),
                    child: const Image(
                      image: AssetImage("assets/images/logo.png"),
                      height: 240.0,
                    ),
                  ),
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 14),
                      child: SizedBox(
                        height: 400, // Set a fixed height for the PageView
                        child: PageView(
                          controller: _pageController,
                          children: [
                            LoginPage(toggleView: toggleView),
                            RegistrationPage(toggleView: toggleView),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
