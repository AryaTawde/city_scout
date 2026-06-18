import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("WELCOME BACK",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ) ),
            SizedBox(height: 10),

            Text("Continue exploring amazing cities."),
            SizedBox(height: 25),

            ElevatedButton(
              onPressed: () {}, 
            child: Text("Continue with Google")
            ),
            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {}, 
            child: Text("Continue with Email")
            ),
          ],
        ),
        
      ),
    );
  }
}