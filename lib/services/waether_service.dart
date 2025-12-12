// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weatherapp/models/weather_model.dart';
//https://api.openweathermap.org/data/2.5/weather?q=mumbai&appid=5a186d5c93657e079229d871e089de5e&units=metric
class WaetherService {
  

  final String baseURL = "https://api.openweathermap.org/data/2.5/weather";

  String get apikey => dotenv.env['API_KEY'] ?? "";
  

  Future<WeatherModel> getWeather(String city) async{
    print("API_KEY FROM DOTENV: [$apikey]");
    print("REQUEST URL: $baseURL?q=$city&appid=$apikey&units=metric");

    
    final url = Uri.parse("$baseURL?q=${city}&appid=5a186d5c93657e079229d871e&units=metric");

    try{
      final responce = await http.get(url);
      print("STATUS CODE: ${responce.statusCode}");
      print("RESPONSE BODY: ${responce.body}");

      if(responce.statusCode != 200){
        throw Exception("Failed to load the Weather");
      }

      final data = jsonDecode(responce.body);

      return WeatherModel.fromJson(data);
    } catch(e) {
      throw Exception("Failed to load weather");
    }
  }
}