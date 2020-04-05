import 'package:flutter/material.dart';
// import 'package:path/path.dart';
import "package:flappy_search_bar/flappy_search_bar.dart";

class Today extends StatefulWidget {
  @override
  _TodayState createState() => _TodayState();
}

class _TodayState extends State<Today> {
  Map data = {};
  bool tempSwitch = true;
  bool langSwitch = false;

  Future<List> cities;
  // bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    var temp = data["temp"];
    var main = data["main"];
    var location = data["location"];
    // String daytimeImage = data[]
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

      body: Column(children: <Widget>[
        Expanded(
            child: Text("Weather in $location:",
                style: TextStyle(fontSize: 40.0))),
        Expanded(child: Text("$main", style: TextStyle(fontSize: 20.0))),
        Expanded(child: Text("$temp C°", style: TextStyle(fontSize: 20.0)))
      ]),
      //  Text(
      //   "Weather in $location:",
      //   style: TextStyle(fontSize: 40.0),

      //    $main"
      // ),
      // ),
    );
  }
}
