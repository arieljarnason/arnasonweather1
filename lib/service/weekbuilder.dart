import 'package:http/http.dart';
import 'dart:convert';

// example api call for weather forecast
// "http://api.openweathermap.org/data/2.5/forecast?$url&units=metric"

class Weekbuilder{
  String location;
  String url;
  List forecastList;
  Map mapOfForecasts    = Map();  
  Map mapOfTemp         = Map();
  Map mapOfIconUrl      = Map();
  Map mapOfWind         = Map();

  Weekbuilder({this.location, this.url});
  Future<void> getWeatherWeek() async{

    try{
      Response response = await get(
        "http://api.openweathermap.org/data/2.5/forecast?$url&units=metric");

    // recieve json data
    Map weekData = jsonDecode(response.body);
    var now = new DateTime.now();
    var nowstring = now.toString();
    var todayString = nowstring.substring(0,10);
    var tempTemp, tempIcon, tempWind;
    forecastList = weekData['list'];

    // each 3 hour json output looks like this: ------------------------------------------------
    // {dt: 1586714400, 
    // main: {temp: 19.03, feels_like: 18.11, temp_min: 19.03, temp_max: 19.03, pressure: 1016, 
    // sea_level: 1016, grnd_level: 1016, humidity: 55, temp_kf: 0}, 
    // weather: [{id: 800, main: Clear, description: clear sky, icon: 01d}], 
    // clouds: {all: 8}, wind: {speed: 1.3, deg: 322}, sys: {pod: d}, 
    // dt_txt: 2020-04-12 18:00:00}
    // -----------------------------------------------------------------------------------------


    //populate various data maps for use in app and in week forecast
    // loop through each json output map
    for (Map i in forecastList){
      //sort by day
      String tempstring = i["dt_txt"].substring(0,10);
      
      //edge case bug fix.................
      if ((i["dt_txt"]).contains('00:00')){
        tempTemp = i["main"]["temp"];
        tempIcon = i["weather"][0]["icon"];
        tempWind = i["wind"]["speed"];
      }

      if ((i["dt_txt"]).contains('12:00')){
          if ((i["dt_txt"]).contains(todayString)){
            continue;
            }
        mapOfForecasts[tempstring] = i;
        if (i["main"]["temp"] == null){
          print("Boom");
          print("tempTemp");
          mapOfTemp[tempstring] = tempTemp;
          }
        else{mapOfTemp[tempstring] = i["main"]["temp"].round();}

        mapOfIconUrl[tempstring] =i["weather"][0]["icon"];
        mapOfWind[tempstring] = i["wind"]["speed"];
        }
      }
    }
  catch (e) {
      print("Caught Error: $e");
    }
  }
}
