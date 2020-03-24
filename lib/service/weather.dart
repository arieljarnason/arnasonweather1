import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
 

class WorldWeather {

  String location;  //location where to get weather info for
  String time;      //time in that location 
  String url;       //url for api ending
  bool isDaytime;   //check whether day or night
  // set string f stuff
  
  // location og info sem ég vil sýna úr veðurs json info
  WorldWeather({ this.location, this.url });

  Future<void> getWeather() async {

    try {
      // make the api request
      Response response = await get(
        "http://api.openweathermap.org/data/2.5/weather?q=$url&units=metric");

      // map all the data from the api and set up in variables
      Map data = jsonDecode(response.body);
      
      List weather = data["weather"];
      Map weathermap = weather[0];
      
      String main = weathermap["main"];
      String description = weathermap["description"];
      String iconUrl = weathermap["icon"];

      Map maindata = data["main"];
      var temp = maindata["temp"];
      var tempMin = maindata["temp_min"];
      var tempMax = maindata["temp_max"];
      var pressure = maindata["pressure"];
      var humidity = maindata["humidity"];
      var feelsLikse = maindata["feels_like"];
 
      // print(maindata["humidity"]);
      // print("windspeed m/s: "+wind["speed"].toString());
      //windspeed m/s
      //wind direction degrees
      // print(windSpeed);

      Map wind = data["wind"];
      String windSpeed = wind["speed"].toString();
      String windDirection = wind["deg"].toString();


      var sys = data["sys"];
      var sunriseNum = sys["sunrise"];
      var sunsetNum = sys["sunset"];

      var sunriseTime = new DateTime.fromMillisecondsSinceEpoch(sunriseNum * 1000);
      String sunriseTimeShort = 
      (sunriseTime.hour.toString()+":"+sunriseTime.minute.toString());

      var sunsetTime = new DateTime.fromMillisecondsSinceEpoch(sunsetNum * 1000);
      String sunsetTimeShort = 
      (sunsetTime.hour.toString()+":"+sunsetTime.minute.toString());



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

    }
    catch(e) {

      print("Caught Error: $e");
      time = "Could not get time data";

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