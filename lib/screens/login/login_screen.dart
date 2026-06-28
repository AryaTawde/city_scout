import 'package:flutter/material.dart';
import 'package:city_scout/screens/home/home_screen.dart';
import 'package:city_scout/services/auth_service.dart';

class LoginScreen extends StatelessWidget {
 LoginScreen({super.key});
  final AuthService authService = AuthService();

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
              onPressed: () async {
                final user = await authService.signInWithGoogle();
                if (user != null && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Login Successful 🎉"),
                    ),
                  );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HomeScreen(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Login Failed"),
                    ),
                  );
                }
              }, 
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