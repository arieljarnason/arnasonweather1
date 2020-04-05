import 'package:arnason_weather/service/weather.dart';
import 'package:flutter/material.dart';
// import 'package:path/path.dart';
// import "package:flappy_search_bar/flappy_search_bar.dart";
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
    var main = data.main;
    var temp = data.temp;


    // String daytimeImage = data[]
    print(data.location);
    print(data.temp);
    print("keyrir!");
    print(data.iconUrl);

    return Scaffold(
      appBar: AppBar(
        title: 
            Text("$location"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
            // Navigator.of(context).pop();
            Navigator.pushNamed(context, "/search");
            },
          ),
        ],

        // FlatButton.icon(
        //   icon: Icon(
        //     Icons.search,
        //     color: Colors.white,
        //   ),
        //   onPressed: () {
        //     setState(() {
        //       this.isSearching = !this.isSearching;
        //     });
        //     // Navigator.of(context).pop();
        //     // Navigator.pushNamed(context, "/search");
        //   },
        //   label: Text(" "),
        //   shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
        // )
        // ],
        // title: Text("$location",
        //   style: TextStyle(color: Colors.white),
        //   textDirection: TextDirection.ltr),
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
              child: Text("Settings", style: TextStyle(fontSize: 30.0)),
            ),
            // SizedBox(height: 20.0),
            // ListTile(
            //   title: Text("The week's weather"),
            //   trailing: Icon(Icons.view_week),
            //   onTap: () {
            //     Navigator.of(context).pop();
            //     try{
            //     Navigator.pushNamed(context, "/week");
            //     }
            //     catch(e){
            //       print("woops");
            //     }
            //   },
            // ),
            // Divider(),
            ListTile(
                title: Text("C° / F°"),
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
                title: Text("English / Icelandic"),
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
              title: Text("Current location"),
              trailing: Icon(Icons.location_on),
            ),
            ListTile(
              title: Text("My location 1"),
              trailing: Icon(Icons.location_city),
            ),
            ListTile(
              title: Text("My location 2"),
              trailing: Icon(Icons.location_city),
            ),
            ListTile(
              title: Text("Add new location"),
              trailing: Icon(Icons.add),
              onTap: () {
                Navigator.pushNamed(context, "/search");
              },
            ),
          ],
        ),
      ),

      // trailing: SwitchWidget()

      body: 
      
      
      
      Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          // child: Center(
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
                        'Weather in $location',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 16, 0, 0),
                      child: Text("${data.main}, ${data.description}",style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.1, 7, 0, 0),
                      child: Text("Temperature: ${data.temp} C°",style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.8, 2, 0, 0),
                      child: Text("Feels like: ${data.feelsLike} C°",style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 7, 0, 0),
                      child: Text("Temp min: ${data.tempMin},  max: ${data.tempMax}",style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(16.0, 2, 0, 0),
                    //   child: Text("Temp max ${data.tempMax}",style: TextStyle(fontSize: 16.0),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 2, 0, 0),
                      child: Text("Pressure: ${data.pressure}  Humidity ${data.humidity}",style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 2, 0, 0),
                      child: Text("Windspeed: ${data.windSpeed} from direction degree: ${data.windDirection} ",style: TextStyle(fontSize: 16.0),
                      ),
                    ),

                     Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 2, 0, 0),
                      child: Text("Sunrise: ${data.sunrise}  Sunset ${data.sunset}",style: TextStyle(fontSize: 16.0),
                      ),
                    ), 
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(16.0, 2, 0, 0),
                    //   child: Text("Windspeed: ${data.windSpeed}",style: TextStyle(fontSize: 14.0),
                    //   ),
                    // ),

                    // "sunrise": myinstance.sunrise,
      // "sunset": myinstance.sunset,
                    // ListTile(
                    //   subtitle: Text('sdf'),
                    // ),
                    // ListTile(
                    //   subtitle: Text(''),
                    // ),

                    


      // "location": curInstance.location,
      // "main": myinstance.main,
      // "description": myinstance.description,
      // "iconUrl": myinstance.iconUrl,
      // "temp": myinstance.temp,
      // "tempMin": myinstance.tempMin,
      // "tempMax": myinstance.tempMax,
      // "pressure": myinstance.pressure,
      // "humidity": myinstance.humidity,
      // "feelsLike": myinstance.feelsLike,
      // "windSpeed": myinstance.windSpeed,
      // "windDirection": myinstance.windDirection,
      // "sunrise": myinstance.sunrise,
      // "sunset": myinstance.sunset,
      // "isDaytime": myinstance.isDaytime
      // "isDaytime": myinstance.isDaytime,
                  ],
                ),
                  // child: Text(
                  //   "Weather in $location",
                  //   style: TextStyle(
                  //     color: Colors.blueGrey[900],
                  //     fontSize: 20.0,
                  //     letterSpacing: 2.0,
                ),
              ),
            ),
          // ),
        ),
      ]),
        // Expanded(
        //     child: Text("Weather in $location:",
        //         style: TextStyle(fontSize: 40.0))),
        // Expanded(child: Text("$main", style: TextStyle(fontSize: 20.0))),
        // Expanded(child: Text("$temp C°", style: TextStyle(fontSize: 20.0)))
      //  Text(
      //   "Weather in $location:",
      //   style: TextStyle(fontSize: 40.0),

      //    $main"
      // ),
      // ),
    );
  }
}
