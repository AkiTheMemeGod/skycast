import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:skycast/models/weather_model.dart';
import 'package:skycast/service/weather_service.dart';

class Weatherpage extends StatefulWidget {
  const Weatherpage({super.key});

  @override
  State<Weatherpage> createState() => _WeatherpageState();
}

class _WeatherpageState extends State<Weatherpage> {
  final _weatherservice = WeatherService("22d363f57bcd26b1e5f6edc7189f9af5");

  Weather? _weather;

  _fetchweather() async {
    String cityname = await _weatherservice.getCurrentCity();
    try {
      // Await the asynchronous getWeather method
      final weather = await _weatherservice.getWeather(cityname);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeather(String? maincondition) {
    if (maincondition == null) return 'lottie/sunny.json';

    switch (maincondition.toLowerCase()) {
      case 'clouds':
        return 'lottie/cloudy.json';
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'lottie/misty.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'lottie/rainy.json';
      case 'thunderstorm':
        return 'lottie/thunderstorm.json';
      case 'clear':
        return 'lottie/sunny.json';
      default:
        return 'lottie/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchweather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 130.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.location_on, size: 40, color: Colors.grey),
                  Text(
                    " ${_weather?.cityName}" ?? "loading city..",
                    style: GoogleFonts.redHatDisplay(
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
            Lottie.asset(getWeather(_weather?.mainCondition)),
            Text(_weather?.description ?? "loading",
                style: GoogleFonts.redHatDisplay(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Colors.grey.shade700)),
            Padding(
              padding: const EdgeInsets.only(bottom: 180),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text("Temperature",
                          style: GoogleFonts.redHatDisplay(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.grey)),
                      Text(
                          _weather != null
                              ? "${_weather!.temperature.round()}°C"
                              : "loading temperature..",
                          style: GoogleFonts.redHatDisplay(
                              fontWeight: FontWeight.w300,
                              fontSize: 20,
                              color: Colors.grey)),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Feels Like",
                          style: GoogleFonts.redHatDisplay(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.grey)),
                      Text(
                          _weather != null
                              ? "${_weather!.feelslike.round()}°C"
                              : "loading temperature..",
                          style: GoogleFonts.redHatDisplay(
                              fontWeight: FontWeight.w300,
                              fontSize: 20,
                              color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
            /*Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: Text(_weather?.mainCondition ?? "",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.grey)),
            )*/
          ],
        ),
      ),
    );
  }
}
