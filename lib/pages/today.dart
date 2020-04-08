import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:arnason_weather/service/weather.dart';
import 'package:arnason_weather/service/weekbuilder.dart';

List instanceList;
var now = new DateTime.now();

class Today extends StatefulWidget {
  @override
  _TodayState createState() => _TodayState();
}

class _TodayState extends State<Today> {
  // Map data = {};
  WorldWeather data;
  Weekbuilder weekData;
  bool tempSwitch = true;
  bool langSwitch = false;
  Future<List> cities;

  @override
  Widget build(BuildContext context) {
    
    // all kinds of variables ---------------------------------------------------

    double paddingSizeSmall = MediaQuery.of(context).size.height * 0.01;
    double paddingSizeMed = MediaQuery.of(context).size.height * 0.02;
    double paddingSizeTiny = 0.187;

    //passa data sé ekki empty
    // data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    
    instanceList = ModalRoute.of(context).settings.arguments;
    data = instanceList[0];
    weekData = instanceList[1];

    String nowdate = DateFormat('EEEE, d MMM, yyyy').format(now); // prints Tuesday, 10 Dec, 2019
    // String nowDayShort = DateFormat('EEE').format(now);

    // list of strings to call for info, next five days
    // both in 2020-12-24 format as well as "Tue" format
    List<String> weekStrings = [];
    List<String> weekStringsShort = [];
    
    List tempWeek = [];
    List iconWeek = [];
    List windWeek = [];
    
    List<Widget> callMeBabyList = [];
    List<Widget> drawerList = [];

    
    for (var i = 1; i<6; i++){
      //each day has a string of numbers in 2020-12-24
      // use to define and consequently show a map of icons, temperatures and windspeed for next 5 days
      var today = now.add(new Duration(days:i));
      String nowDayShort = DateFormat('EEE').format(today);
      var dayString = today.toString().substring(0,10);

      weekStrings.add(dayString);
      weekStringsShort.add(nowDayShort);

      //populate icon, temp, wind lists
      if(weekData.mapOfTemp[dayString] == null){tempWeek.add("");}
      else{tempWeek.add(weekData.mapOfTemp[dayString]);}

      if(weekData.mapOfIconUrl[dayString] == null){iconWeek.add("50n");}
      else{iconWeek.add(weekData.mapOfIconUrl[dayString]);}

      if(weekData.mapOfWind[dayString] == null){windWeek.add("");}
      else{windWeek.add(weekData.mapOfWind[dayString]);}
    }
    
    // how to call map of 5 day forecast data
    // print(weekData.mapOfIconUrl[weekStrings[0]]);
    // print(weekData.mapOfForecasts[weekStrings[1]]);

// all kinds of variables END ---------------------------------------------------


  // method that makes week boxes START -----------------------------------------
  // because I dont know flutter, made a seperate method for the 5 boxes
    weekMethod(instanceDay,instanceIcon,instanceTemp,instanceWind) {
      String picUrl;
      try{
        picUrl = "http://openweathermap.org/img/w/$instanceIcon.png";
      }
      catch (e) {
        print("Caught Error: $e");
        picUrl = "http://openweathermap.org/img/w/50n.png";
      }

      return Expanded(
        child: Container(
          width: MediaQuery.of(context).size.width * paddingSizeTiny,
          height: MediaQuery.of(context).size.height * 0.25,
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0,paddingSizeSmall,0,0),
                    child: Center(
                      child: Text(
                      "$instanceDay",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        fontFamily: 'Montserrat'
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.height * 0.07,
                    height: MediaQuery.of(context).size.height * 0.07,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        
                        image: NetworkImage(
                          picUrl)
                        )
                      )
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, paddingSizeSmall, 0, 0),
                      child: Text(
                      "$instanceTemp C°",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.03,
                        fontFamily: 'OpenSans'
                      ),
                    ),
                  ),
                ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, paddingSizeSmall, 0, 0),
                      child: Text(
                      "$instanceWind m/sec",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                          fontFamily: 'OpenSans'
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ),
          ),
        ),
      );
    }


  // method that calls the weekmethod week boxes START -----------------------------------------
    callMeBaby() {
      for (var i = 0; i < 5; i++){
        callMeBabyList.add(weekMethod(weekStringsShort[i], iconWeek[i], tempWeek[i], windWeek[i]));
      }
    }
  
  // method that makes week boxes END -----------------------------------------
    callMeBaby();



    // Original drawer items:
    makingTheDrawer(){
      if (drawerList.length < 1){
        drawerList.add(
          DrawerHeader(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: <Color>[
                Colors.blueGrey[200],Colors.blueGrey[900]
              ]
            )
          ),
          child: Text("Grey Weather App 1.0", style: TextStyle(
            fontSize: 30.0,
              fontFamily: 'Montserrat'
              )
            ),
          )
        );
          drawerList.add(
            ListTile(
              title: Text("Current location",
              style: TextStyle(
              fontFamily: 'Montserrat')),
              trailing: Icon(Icons.location_on),
              // move this function to another place!!!!!! ------------------
              onTap: () async {
                Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                var lat = position.latitude;
                var long = position.longitude;
                WorldWeather curInstance =
                  WorldWeather(
                    url: "lat=$lat&lon=$long&appid=$apikey");
                await curInstance.getWeather();
                  Weekbuilder curWeekInstance = 
                    Weekbuilder(
                    url: "lat=$lat&lon=$long&appid=$apikey");
                await curWeekInstance.getWeatherWeek();

                List myInstances = [];
                myInstances.add(curInstance);
                myInstances.add(curWeekInstance);
                Navigator.of(context).pop();
                Navigator.pushNamed(
                context, "/today", 
                arguments: myInstances);
              },
            // move to another placee END !!!!!! ------------------
            )
          );
          drawerList.add(Divider());
            }//org drawer stuff ends
          }
  // method for BASE list of locations in DRAWER END -----------------------------------------
    makingTheDrawer();


  // UI START -----------------------------------------

    // return Scaffold(
      Scaffold scaffold = Scaffold(
      appBar: AppBar(
        title: 
            Text("$nowdate ${data.name}",
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.02,
                fontFamily: 'OpenSans',
                letterSpacing: 1),
            ),
        // automaticallyImplyLeading: false,    
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
            // Navigator.of(context).pop();
            Navigator.pushNamed(context, "/search");
            },
          ),
        ],
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [Colors.blueGrey[200], Colors.blueGrey[900]],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
      ),

      drawer: Drawer(
        child: ListView(
          children: drawerList
        ),
      ),

      body: 
      SingleChildScrollView(
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0,paddingSizeMed,0,paddingSizeMed),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.45,
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: MediaQuery.of(context).size.height * 0.05,
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage(
                              'http://openweathermap.org/img/w/${data.iconUrl}.png',
                              ),
                            ),
                            title: Text(
                              'Weather in ${data.name}',
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.height * 0.03,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                              )
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, paddingSizeSmall, 0, 0),
                          child: Text(
                              "${data.temp} C°",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height * 0.05,
                              fontFamily: 'Montserrat'
                              ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(17, 0, 0, 0),
                          child: Text(
                            "Feels like: ${data.feelsLike} C°",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                            fontFamily: 'OpenSans'
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, paddingSizeSmall, 0, 0),
                          child: Text(
                              "${data.main}, ${data.description}",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height * 0.027,
                              fontFamily: 'Montserrat'
                              ),
                          ),
                        ),
                        
                        Padding(
                          padding: EdgeInsets.fromLTRB(16.0, paddingSizeSmall, 0, 0),
                          child: Text(
                            "Temp min: ${data.tempMin},  max: ${data.tempMax}",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                            fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16.0, 2, 0, 0),
                          child: Text(
                            "Pressure: ${data.pressure}  Humidity ${data.humidity}",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                            fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(16.0, 2, 0, 0),
                          child: Text(
                            "Windspeed: ${data.windSpeed} m/sec,  direction: ${data.windDirection} ",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                            fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(16.0, paddingSizeMed, 0, 0),
                          child: Text(
                            "Sunrise: ${data.sunrise}  Sunset ${data.sunset}",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.025,
                            fontFamily: 'OpenSans'),
                          ),
                        ), 
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0,0,0,MediaQuery.of(context).size.height * 0.015),
              child: Center(
                child: Text(
                  "Week forecast",
                  style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height * 0.025,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            )
                ),
              ),
            ),

            // WEEK FORECAST generation call
            Padding(
              padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.03,0,0,0),
              child: Row(
                children: callMeBabyList
                //don't be crazy
              ),
            )
          ]
        ),
      ),
    );
    try{
      return scaffold;
    }catch (e) {
      print("Caught Error: $e");}
    }  
}