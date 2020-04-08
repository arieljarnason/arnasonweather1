import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

//api keys-------------------------------------------------
//temp one:
// String apikey = '12b6e28582eb9298577c734a31ba9f4f';
//my api:
String apikey = '8ed0ab17ad4325bb6592a4fd43f7fc9a';
//api keys-------------------------------------------------


class WorldWeather {
  String  location, 
          name, 
          main, 
          url, 
          description, 
          iconUrl, 
          sunrise, 
          sunset;
  var     temp,
          tempMin,
          tempMax,
          pressure,
          humidity,
          feelsLike,
          windSpeed,
          windDirection,
          windDegrees;
  //location where to get weather info for

  bool isDaytime; //check whether day or night

  WorldWeather({this.location, this.url});

  Future<void> getWeather() async {
    try {
      // make the api request
      Response response = await get(
          "http://api.openweathermap.org/data/2.5/weather?$url&units=metric");

      // map all the data from the api and set up in variables
      Map data = jsonDecode(response.body);
      List weather =    data["weather"];
      Map weathermap =  weather[0];
      Map wind =        data["wind"];
      Map maindata =    data["main"];

      name =            data["name"];
      description =     weathermap["description"];
      iconUrl =         weathermap["icon"];
      main =            weathermap["main"];
      temp =            maindata["temp"].round();
      tempMin =         maindata["temp_min"];
      tempMax =         maindata["temp_max"];
      pressure =        maindata["pressure"];
      humidity =        maindata["humidity"];
      feelsLike =       maindata["feels_like"];
      windSpeed =       wind["speed"];
      
      // unreliable wind degree from API
      try{
        windDirection =   wind["deg"];
        windDegrees = wind["deg"];
        if (windDegrees < 11.25) {windDirection = "N";}
        if (windDegrees >= 11.25) {windDirection = "NNE";}
        if (windDegrees >= 33.75) {windDirection = "NE";}
        if (windDegrees >= 56.25) {windDirection = "ENE";}
        if (windDegrees >= 78.75) {windDirection = "E";}
        if (windDegrees >= 101.25) {windDirection = "ESE";}
        if (windDegrees >= 123.75) {windDirection = "SE";}
        if (windDegrees >= 146.25) {windDirection = "SSE";}
        if (windDegrees >= 168.75) {windDirection = "S";}
        if (windDegrees >= 191.25) {windDirection = "SSW";}
        if (windDegrees >= 213.75) {windDirection = "SW";}
        if (windDegrees >= 236.25) {windDirection = "WSW";}
        if (windDegrees >= 258.75) {windDirection = "W";}
        if (windDegrees >= 281.25) {windDirection = "WNW";}
        if (windDegrees >= 303.75) {windDirection = "WN";}
        if (windDegrees >= 326.25) {windDirection = "NNW";}
        if (windDegrees >= 348.75) {windDirection = "N";}
        // windDirection;
      }
      catch (e) {
        print("Caught Error: $e");
      windDirection = "Unknown";
    }

      var sys = data["sys"];
      var sunriseNum = sys["sunrise"];
      var sunsetNum = sys["sunset"];

      var sunriseTime =
          new DateTime.fromMillisecondsSinceEpoch(sunriseNum * 1000);
      sunrise =
          (sunriseTime.hour.toString() + ":" + sunriseTime.minute.toString());

      var sunsetTime =
          new DateTime.fromMillisecondsSinceEpoch(sunsetNum * 1000);
      sunset =
          (sunsetTime.hour.toString() + ":" + sunsetTime.minute.toString());

      var now = new DateTime.now();
      if (now.hour > sunriseTime.hour && now.hour < sunsetTime.hour) {
        isDaytime = true;
      } else {
        isDaytime = false;
      }
     
    } catch (e) {
      print("Caught Error: $e");
      main = "Data unknown";
    }
  }
}
