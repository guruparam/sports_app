import 'package:flutter/material.dart';

import '../components/custom_app_bar.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool _obscureText = true;

  void logout() {
    print("logout");
    Navigator.pushNamed(context, '/auth');
  }

  @override
  Widget build(BuildContext context) {
       return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
        showBackButton: true,
        onBackButtonPressed: () {
          Navigator.pushNamed(context, '/home');
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Profile photo
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/images/Profile_img.png"),
              ),
            ),
            const SizedBox(height: 20),

            // Full Name
            TextFormField(
              initialValue: 'Paramaguru',
              decoration: const InputDecoration(
                labelText: 'Full Name',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
              readOnly: true,
            ),
            const SizedBox(height: 20),

            // Email
            TextFormField(
              initialValue: 'guru@example.com',
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
              readOnly: true,
            ),
            const SizedBox(height: 20),

            // Phone Number
            TextFormField(
              initialValue: '123-456-7890',
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(),
              ),
              readOnly: true,
            ),
            const SizedBox(height: 20),

            // Password
            TextFormField(
              initialValue: '********',
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
                border: const OutlineInputBorder(),
              ),
              readOnly: true,
              obscureText: _obscureText,
            ),
            const SizedBox(height: 20),

            // Edit Profile Button
            ElevatedButton(
              onPressed: () {
                // Handle edit profile
              },
              child: const Text('Edit Profile'),
            ),
            const SizedBox(height: 10),

            // Logout Button
            OutlinedButton(
              onPressed: logout,
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
