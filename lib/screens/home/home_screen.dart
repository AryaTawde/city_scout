import 'package:flutter/material.dart';
import 'package:city_scout/widgets/place_card.dart';
import '../../models/city.dart';
import '../../services/city_service.dart';
import '../../services/image_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CityService cityService = CityService();
  final ImageService imageService = ImageService();

  List<City> cities = [];
    final TextEditingController searchController =
    TextEditingController();
  @override
  void initState() {
    super.initState();
    loadCities();
  }

  Future<void> loadCities() async {
    final result = await cityService.searchCity("India");

    setState(() {
      cities = result;
    });
  }

  Future<void> searchCity() async {
    if (searchController.text.trim().isEmpty) return;

    final result = 
      await cityService.searchCity(searchController.text);

    for (final city in result) {
      city.imageUrl =
          await imageService.getCityImage(city.name);
    }
    setState(() {
      cities = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("CityScout")),
      body: SingleChildScrollView(
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
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search any city...",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: searchCity,
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: (_) => searchCity(),
            ),
            SizedBox(height: 15),

            const Text(
              "Popular Cities",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            SizedBox(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cities.length,
                itemBuilder: (context, index) {

                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: PlaceCard(
                      city: cities[index],
                    ),
                  );

                },
              ),
            ),
            const SizedBox(height: 30),

            Row(
              children: [
                Icon(Icons.local_fire_department, color: Colors.orange),
                SizedBox(width: 8),
                Text(
                  "Trending Places",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            SizedBox(
              height: 70,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [

                  Chip(label: Text("Marine Drive")),

                  SizedBox(width: 10),

                  Chip(label: Text("Gateway of India")),

                  SizedBox(width: 10),

                  Chip(label: Text("Baga Beach")),

                  SizedBox(width: 10),

                  Chip(label: Text("Amber Fort")),
                ],
              ),
            ),
            const SizedBox(height: 30),

            const Text(
              "Nearby You",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Card(
              child: ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text("Marine Drive"),
                subtitle: const Text("2.4 km away"),
                trailing: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Visit"),
                ),
              ),
            ),
            const SizedBox(height: 30),

            const Text(
              "Events This Week",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Card(
              child: ListTile(
                leading: const Icon(Icons.event),
                title: const Text("Goa Music Festival"),
                subtitle: const Text("Starts Friday"),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: const [

                Chip(
                  avatar: Icon(Icons.history),
                  label: Text("Mumbai"),
                ),

                Chip(
                  avatar: Icon(Icons.history),
                  label: Text("Goa"),
                ),

                Chip(
                  avatar: Icon(Icons.history),
                  label: Text("Delhi"),
                ),
              ],
            ),
          ], // children
        ),
      ),
    );
  }
}
