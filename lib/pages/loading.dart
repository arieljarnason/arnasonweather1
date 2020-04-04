import 'package:flutter/material.dart';
import "package:flutter_spinkit/flutter_spinkit.dart";
import 'package:arnason_weather/service/weather.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String _res = 'Unknown';

  //api keys
  //temp one:
  String apikey = '12b6e28582eb9298577c734a31ba9f4f';
  //my api:
  //String key = '8ed0ab17ad4325bb6592a4fd43f7fc9a';
  //Declare the weatherstation
  // WeatherStation ws;

  // void setupWeather() async {
  void setupWorldWeather() async {
    WorldWeather myinstance =
        WorldWeather(location: "Reykjavik", url: "Reykjavik&appid=$apikey");
    await myinstance.getWeather();

    Navigator.pushNamed(context, "/today", arguments: {
      "location": myinstance.location,
      "main": myinstance.main,
      "description": myinstance.description,
      "iconUrl": myinstance.iconUrl,
      "temp": myinstance.temp,
      "tempMin": myinstance.tempMin,
      "tempMax": myinstance.tempMax,
      "pressure": myinstance.pressure,
      "humidity": myinstance.humidity,
      "feelsLike": myinstance.feelsLike,
      "windSpeed": myinstance.windSpeed,
      "windDirection": myinstance.windDirection,
      "sunrise": myinstance.sunrise,
      "sunset": myinstance.sunset,
      "isDaytime": myinstance.isDaytime
      // "isDaytime": myinstance.isDaytime,
    });
    // Navigator.pushNamed(context, "/week");
  }
  // setja upp instance af mínu weather object
  //
  //api example city name:
  //http://api.openweathermap.org/data/2.5/weather?q=London&appid=12b6e28582eb9298577c734a31ba9f4f

  // WorldTime myinstance = WorldTime(location: "London", flag: "Britain.png", url: "Europe/London");
  // await myinstance.getTime();

  // kalla á geo location, my locatoin, finna lat og long
  // https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22

  //senda instance yfir í today

  @override
  void initState() {
    super.initState();
    setupWorldWeather();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(children: <Widget>[
        SizedBox(height: 90.0),
        Image(image: AssetImage("assets/logo1.png"), height: 100),
        SizedBox(height: 110.0),
        SpinKitPulse(color: Colors.blueGrey[200]),
        // Text(
        //     "  Loading...",
        //     style: TextStyle(
        //       fontSize: 18.0,
        //       color: Colors.blueGrey[700],
        //     )
        // ),
        SizedBox(height: 10.0),
      ])),
    );
  }
}
// ws = new WeatherStation(apikey);
// initPlatformState();
// setupWeather();
// Future<void> initPlatformState() async{
//   quearyWeather();
// }

//fetched current weather
// void quearyWeather() async {
//   // ws.Location() = "Reykjavik";
//   Weather w = await ws.currentWeather();
//   print(ws.location.getLocation().toString());
//   setState(() {
//     _res = w.toString();
//   });
// }

//makes list of 5 day weather forecast, will use in "week" tab
// move this call somewhere else? or load here and throw away?

// void quearyForecast() async {
//   List<Weather> f = await ws.fiveDayForecast();
//   setState(() {
//     _res = f.toString();
//   });
// }
