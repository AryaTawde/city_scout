import 'package:city_scout/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(
              Icons.travel_explore,
              size: 100,
            ),

            SizedBox(height: 25),

            Text(
              "CityScout",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "Discover amazing places around every city.",
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 40),

            ElevatedButton(
             onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
              child: Text("Get Started"),
            )

          ],
        ),
      ),
    );
  }
}