import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:arnason_weather/service/weather.dart';
import 'package:arnason_weather/service/weekbuilder.dart';



// var todayData, weekData;
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
  // bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    
    // all kinds of variables ---------------------------------------------------

    double paddingSizeSmall = MediaQuery.of(context).size.height * 0.01;
    double paddingSizeMed = MediaQuery.of(context).size.height * 0.02;
    double paddingSizeMed2 = MediaQuery.of(context).size.width * 0.1;
    double paddingSizeTiny = 0.187;

    //passa data sé ekki empty
    // data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    // setState(() {});
    // data = ModalRoute.of(context).settings.arguments;
    instanceList = ModalRoute.of(context).settings.arguments;
    data = instanceList[0];
    weekData = instanceList[1];


    var location = data.location;
    String nowdate = DateFormat('EEEE, d MMM, yyyy').format(now); // prints Tuesday, 10 Dec, 2019
    // String nowDayShort = DateFormat('EEE').format(now);


    var day1 = now.add(new Duration(days:1));
    var day1string = day1.toString().substring(0,10);
    // var todayString = nowstring.substring(0,10);
    // print(day1string);

    // list of strings to call for info, next five days
    // both in 2020-12-24 format as well as "Tue" format
    List<String> weekStrings = [];
    List<String> weekStringsShort = [];
    
    List tempWeek = [];
    List iconWeek = [];
    List windWeek = [];
    
    List<Widget> callMeBabyList = [];

    
    for (var i = 1; i<6; i++){
      //each day has a string of numbers in 2020-12-24
      // use to define and consequently show a map of icons, temperatures and windspeed for next 5 days
      var today = now.add(new Duration(days:i));
      String nowDayShort = DateFormat('EEE').format(today);
      var dayString = today.toString().substring(0,10);

      weekStrings.add(dayString);
      // print(dayString);
      weekStringsShort.add(nowDayShort);

      //populate icon, temp, wind lists
      tempWeek.add(weekData.mapOfTemp[dayString]);
      iconWeek.add(weekData.mapOfIconUrl[dayString]);
      windWeek.add(weekData.mapOfWind[dayString]);
    }
      print(iconWeek);
      print(windWeek);
      print(tempWeek);

    
      //köllunaraðferð fyrir map of weekdata
    // print(weekData.mapOfIconUrl[weekStrings[0]]);
    // print(weekData.mapOfForecasts[weekStrings[1]]);

// all kinds of variables END ---------------------------------------------------


  // method that makes week boxes START -----------------------------------------
  // because I dont know flutter, made a seperate method for the 5 boxes i dno
  weekMethod(
    instanceDay,
    instanceIcon, 
    instanceTemp, 
    instanceWind
    ){
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        width: MediaQuery.of(context).size.width * paddingSizeTiny,
        height: MediaQuery.of(context).size.height * 0.3,
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
                child: new Container(
                  width: MediaQuery.of(context).size.height * 0.07,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage(
                        "http://openweathermap.org/img/w/$instanceIcon.png")
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
                      fontSize: MediaQuery.of(context).size.height * 0.025,
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
                        fontSize: MediaQuery.of(context).size.height * 0.025,
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

  callMeBaby() {
    for (var i = 0; i < 5; i++){
      callMeBabyList.add(weekMethod(weekStringsShort[i], iconWeek[i], tempWeek[i], windWeek[i]));
    }
  }
  callMeBaby();
  // method that makes week boxes END -----------------------------------------

  // method for list of locations in DRAWER START -----------------------------------------
  // method for list of locations in DRAWER END -----------------------------------------



  // UI START -----------------------------------------

    return Scaffold(
      appBar: AppBar(
        title: 
            Text("$nowdate   ${data.name}",
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.025,
                fontFamily: 'OpenSans',
                letterSpacing: 1),
            ),
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
          children: <Widget>[
            DrawerHeader(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: <Color>[
                Colors.blueGrey[200],
                Colors.blueGrey[900]
              ])),
              child: Text("Arnason Weather", style: TextStyle(
                fontSize: 30.0,
                fontFamily: 'Montserrat')),
            ),
            // ListTile(
            //     title: Text("C° / F°",
            //     style: TextStyle(
            //     fontFamily: 'Montserrat')),
            //     trailing: Switch(
            //       value: tempSwitch,
            //       onChanged: (value) {
            //         setState(() {
            //           tempSwitch = value;
            //         });
            //       },
            //       activeTrackColor: Colors.lightBlueAccent,
            //       activeColor: Colors.lime,
            //     )),
            // ListTile(
            //     title: Text("English / Icelandic",
            //     style: TextStyle(
            //     fontFamily: 'Montserrat')),
            //     trailing: Switch(
            //       value: langSwitch,
            //       onChanged: (value) {
            //         setState(() {
            //           langSwitch = value;
            //         });
            //       },
            //       activeTrackColor: Colors.lightBlueAccent,
            //       activeColor: Colors.lime,
            //     )),
            ListTile(
              title: Text("Current location",
              style: TextStyle(
              fontFamily: 'Montserrat')),
              trailing: Icon(Icons.location_on),
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
                
                Navigator.pushNamed(
                context, "/today", 
                arguments: myInstances);
              },
            ),
            Divider(),
            // ListTile(
            //   title: Text("My location 1"),
            //   trailing: Icon(Icons.location_city),
            // ),
            // ListTile(
            //   title: Text("My location 2"),
            //   trailing: Icon(Icons.location_city),
            // ),

            ListTile(
              title: Text("Add new location",
              style: TextStyle(
              fontFamily: 'Montserrat')),
              trailing: Icon(Icons.add),
              onTap: () {
                Navigator.pushNamed(context, "/search");
              },
            ),
          ],
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
                        // Image(image: AssetImage('assets/logo1.png')),
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
                                fontSize: MediaQuery.of(context).size.height * 0.04,
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
                              fontWeight: FontWeight.w600,
                            )
                ),
              ),
            ),

            // week overview (yes i know, need children for loop)
            Row(
            // figured out the loop
              children: callMeBabyList
            )
          ]
        ),
      ),
    );



  }
}