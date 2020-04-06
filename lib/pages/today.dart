import 'package:arnason_weather/service/weather.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

var data;

class Today extends StatefulWidget {
  @override
  _TodayState createState() => _TodayState();
}

class _TodayState extends State<Today> {
  // Map data = {};
  WorldWeather data;
  bool tempSwitch = true;
  bool langSwitch = false;

  Future<List> cities;
  // bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    //passa data sé ekki empty
    setState(() {});
    data = ModalRoute.of(context).settings.arguments;
    // data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    var location = data.location;


    return Scaffold(
      appBar: AppBar(
        title: 
            Text("${data.name}",
            style: TextStyle(
                fontSize: 24.0,
                fontFamily: 'OpenSans',
                letterSpacing: 1.5),
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
            ListTile(
                title: Text("C° / F°",
                style: TextStyle(
                fontFamily: 'Montserrat')),
                trailing: Switch(
                  value: tempSwitch,
                  onChanged: (value) {
                    setState(() {
                      tempSwitch = value;
                    });
                  },
                  activeTrackColor: Colors.lightBlueAccent,
                  activeColor: Colors.lime,
                )),
            ListTile(
                title: Text("English / Icelandic",
                style: TextStyle(
                fontFamily: 'Montserrat')),
                trailing: Switch(
                  value: langSwitch,
                  onChanged: (value) {
                    setState(() {
                      langSwitch = value;
                    });
                  },
                  activeTrackColor: Colors.lightBlueAccent,
                  activeColor: Colors.lime,
                )),
            Divider(),
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
                      Navigator.pushNamed(
                      context, "/today", 
                      arguments: curInstance);
              },
            ),
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
      Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      // Image(image: AssetImage('assets/logo1.png')),
                      ListTile(
                        leading: CircleAvatar(
                          radius: 40.0,
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(
                          'http://openweathermap.org/img/w/${data.iconUrl}.png',
                          ),
                        ),
                        title: Text(
                          'Weather in ${data.name}',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 16, 0, 0),
                        child: Text(
                            "${data.main}, ${data.description}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Montserrat'
                            ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15.5, 7, 0, 0),
                        child: Text(
                            "Temperature: ${data.temp} C°",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'Montserrat'
                            ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(17, 2, 0, 0),
                        child: Text(
                          "Feels like: ${data.feelsLike} C°",
                        style: TextStyle(
                          fontSize: 17.0,
                          fontFamily: 'OpenSans'
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 10, 0, 0),
                        child: Text(
                          "Temp min: ${data.tempMin},  max: ${data.tempMax}",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 2, 0, 0),
                        child: Text(
                          "Pressure: ${data.pressure}  Humidity ${data.humidity}",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 2, 0, 0),
                        child: Text(
                          "Windspeed: ${data.windSpeed} m/sec,  direction: ${data.windDirection} ",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 12, 0, 0),
                        child: Text(
                          "Sunrise: ${data.sunrise}  Sunset ${data.sunset}",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'OpenSans'),
                        ),
                      ), 
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}
