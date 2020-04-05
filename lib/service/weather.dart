import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

String apikey = '12b6e28582eb9298577c734a31ba9f4f';
//api keys
//temp one:
//my api:
//String key = '8ed0ab17ad4325bb6592a4fd43f7fc9a';



class WorldWeather {
  String location, main, url, description, iconUrl, sunrise, sunset;
  var temp,
      tempMin,
      tempMax,
      pressure,
      humidity,
      feelsLike,
      windSpeed,
      windDirection,
      windDegrees;
  //location where to get weather info for
  //String time;
  //url for api ending
  bool isDaytime; //check whether day or night

  WorldWeather({this.location, this.url});

  Future<void> getWeather() async {
    try {
      // make the api request
      Response response = await get(
          "http://api.openweathermap.org/data/2.5/weather?q=$url&units=metric");

      // map all the data from the api and set up in variables
      Map data = jsonDecode(response.body);
      // print(data);
      List weather =    data["weather"];
      Map weathermap =  weather[0];
      Map wind =        data["wind"];
      Map maindata =    data["main"];

      description =     weathermap["description"];
      iconUrl =         weathermap["icon"];
      main =            weathermap["main"];
      temp =            maindata["temp"];
      tempMin =         maindata["temp_min"];
      tempMax =         maindata["temp_max"];
      pressure =        maindata["pressure"];
      humidity =        maindata["humidity"];
      feelsLike =       maindata["feels_like"];
      windSpeed =       wind["speed"];
      // windDirection =   wind["deg"];
      windDegrees = wind["deg"];
      
      if (windDegrees < 11.25) {windDirection = "N";}
      if (windDegrees >= 11.25) {windDirection = "NNE";}
      if (windDegrees >= 33.75) {windDirection = "NE";}
      else windDirection = "S";
      // windDirection;
// N348.75 - 11.25
// NNE
// 11.25 - 33.75
// NE
// 33.75 - 56.25
// ENE
// 56.25 - 78.75
// E
// 78.75 - 101.25
// ESE
// 101.25 - 123.75
// SE
// 123.75 - 146.25
// SSE
// 146.25 - 168.75
// S
// 168.75 - 191.25
// SSW
// 191.25 - 213.75
// SW
// 213.75 - 236.25
// WSW
// 236.25 - 258.75
// W
// 258.75 - 281.25
// WNW
// 281.25 - 303.75
// NW
// 303.75 - 326.25
// NNW
// 326.25 - 348.75
      // String windSpeed = wind["speed"].toString();
      // String windDirection = wind["deg"].toString();

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
      // print(isDaytime);

      // print(now);

//       let unix_timestamp = 1549312452
// // Create a new JavaScript Date object based on the timestamp
// // multiplied by 1000 so that the argument is in milliseconds, not seconds.
// var date = new Date(unix_timestamp * 1000);
// // Hours part from the timestamp
// var hours = date.getHours();
// // Minutes part from the timestamp
// var minutes = "0" + date.getMinutes();
// // Seconds part from the timestamp
// var seconds = "0" + date.getSeconds();

      // print(sunrise);
      // String sunset = data["sunset"];
      // print(sunset);
      // get properties from the json data

      // create the customized weather object

    } catch (e) {
      print("Caught Error: $e");
      main = "Could not get weather data";
    }
  }
}

// future void getweweather

// senda get request á http://etcetc weather api /$ staðinn sem ég er að ná í

// map data json decode úr jsoninu sem ég fæ til baka
// json data mun koma svona til baka

//{"coord":{"lon":-21.9,"lat":64.14},"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"base":"stations","main":
//{"temp":272.46,"feels_like":267.7,"temp_min":272.04,"temp_max":273.15,"pressure":1006,"humidity":92},"visibility":10000,"wind":{"speed":3.6,"deg":130},"clouds":
//{"all":75},"dt":1584793121,"sys":{"type":1,"id":91,"country":"IS","sunrise":1584775401,"sunset":1584819953},"timezone":0,"id":3413829,"name":"Reykjavik","cod":200}
//tékka ef það er dagur eða nótt þar:
// iconcode = "04d"+".png"
// ná í iconin : http://openweathermap.org/img/w/$iconcode

// if (now.hour > 6 && now.hour < 20){
//   isDaytime = true;
// }
// else{
//   isDaytime = false;
// }
