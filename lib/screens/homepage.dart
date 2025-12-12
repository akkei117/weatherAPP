// ignore_for_file: unnecessary_string_interpolations, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/services/waether_service.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController cityController = TextEditingController();
  WeatherModel? weather;
  bool isLoading = false;
  String? error;

  Future<void> fetchweather() async {
    final city = cityController.text.trim();
    if (city.isEmpty) {
      return;
    }
    try {
      setState(() {
        isLoading = true;
        error = null;
      });

      final Service = WaetherService();
      final result = await Service.getWeather(city);

      setState(() {
        weather = result;
      });
    } catch (e , stack) {
      print(e);
      print(stack);
      setState(() {
        error = e.toString();
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: cityController,
            decoration: InputDecoration(
              hintText: "Enter city name",
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: fetchweather,
              ),
            ),
          ),

          SizedBox(height: 20),

          // LOADING STATE
          if (isLoading) Center(child: CircularProgressIndicator()),

          // ERROR STATE
          if (error != null)
            Text(error!, style: TextStyle(color: Colors.red, fontSize: 16)),

          // WEATHER DATA
          if (weather != null && !isLoading)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${weather!.description}", style: TextStyle(fontSize: 22)),
                SizedBox(height: 10),
                Text(
                  "${weather!.temp}°C",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text("Humidity: ${weather!.humidity}%"),
              ],
            ),
        ],
      ),
    );
  }
}
