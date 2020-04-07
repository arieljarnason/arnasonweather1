import 'package:http/http.dart';
import 'dart:convert';


// "http://api.openweathermap.org/data/2.5/weather?$url&units=metric"


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

    Map weekData = jsonDecode(response.body);
    var now = new DateTime.now();
    var nowstring = now.toString();
    var todayString = nowstring.substring(0,10);
    
    forecastList = weekData['list'];

    for (Map i in forecastList){
      String tempstring = i["dt_txt"].substring(0,10);
      if ((i["dt_txt"]).contains('12:00')){
          if ((i["dt_txt"]).contains(todayString)){
            continue;
            }
        // print(i);
        mapOfForecasts[tempstring] = i;
        mapOfTemp[tempstring] = i["main"]["temp"].round();
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
