import 'package:flutter/material.dart';
import 'package:city_scout/widgets/place_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("CityScout")),
      body: 
        SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "👋 Hello Arya",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 97, 97),
                ),
              ),

              Text(
                "Ready for your next adventure?",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 97, 97),
                ),
              ),
              SizedBox(height: 15),

              TextField(
                decoration: InputDecoration(
                  hintText: "Search any city...",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),

              Text("Popular Cities"),
              SizedBox(height: 15),

              PlaceCard(
                cityName: "Mumbai",
                rating: 4.8,
                attractions: 247,
              ),
              SizedBox(height: 12),

              PlaceCard(
                cityName: "Goa",
                rating: 4.9,
                attractions: 180,
              ),
              SizedBox(height: 12),

              PlaceCard(
                cityName: "Delhi",
                rating: 4.6,
                attractions: 210,
              ),
              SizedBox(height: 12),

              PlaceCard(
                cityName: "Jaipur",
                rating: 4.7,
                attractions: 165,
              ),
              SizedBox(height: 12),

              Text("Recent Searches"),
              SizedBox(height: 15),
            ],
          ),
        ),
      
    );
  }
}
