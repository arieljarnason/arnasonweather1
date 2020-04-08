import 'package:flutter/services.dart' show rootBundle;
import 'package:arnason_weather/service/weekbuilder.dart';
import "package:flutter_spinkit/flutter_spinkit.dart";
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:arnason_weather/service/weather.dart';

List<String> citylist = [];

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setupWorldWeather() async {

    //loads list of available cities (200.000 ish from openweathermap.org)
    await rootBundle.loadString('assets/mynewfancylist.txt').then((q){
      for (String i in LineSplitter().convert(q)){
        citylist.add(i);
        }
      }
    );
  
    // later implement saved currently used saved instance

    // getting cur location from phone
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude;
    var long = position.longitude;

    // initalize worldweather (today info) 
    //and weekbuilder (5 day forecast) instances
    // api weather calls look like this for geo location:
    // api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={your api key}
    // and for name of city:
    // api.openweathermap.org/data/2.5/weather?q={city name}&appid={your api key}

    WorldWeather curInstance =
    WorldWeather(
      url: "lat=$lat&lon=$long&appid=$apikey");
      await curInstance.getWeather();

    Weekbuilder curWeekInstance = 
    Weekbuilder(
      url: "lat=$lat&lon=$long&appid=$apikey");
      await curWeekInstance.getWeatherWeek();
    
    // push instances to today page
    List myInstances = [];
    myInstances.add(curInstance);
    myInstances.add(curWeekInstance);

    Navigator.of(context).pop();
    Navigator.pushNamed(
      context, "/today", 
      arguments: myInstances);
    }
 
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
            SizedBox(height: 10.0),
          ]
        )
        ),
      );
    }
  }