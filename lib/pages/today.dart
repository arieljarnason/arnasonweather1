import 'package:flutter/material.dart';
import 'package:path/path.dart';


class Today extends StatefulWidget {
  @override
  _TodayState createState() => _TodayState();
}

class _TodayState extends State<Today> {
  Map data = {};
  bool tempSwitch = true;
  
  // bool langSwitch = false;

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    var temp = data["temp"];
    var main = data["main"];
    var location = data["location"];
    // String daytimeImage = data[]
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            // PopupMenuButton<String>(
            //   itemBuilder: (BuildContext context){
            //     return
            //   },
            // )
            FlatButton.icon(
              icon: Icon(
                Icons.location_city,
                color: Colors.white,
              ),
              onPressed: () {},
              label: Text("$location",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  )),
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            )
          ],
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
              // ListTile(
              //   title: Text("English / Icelandic"),
              //   trailing: Switch(
              //   value: langSwitch,
              //     onChanged: (value) {
              //       setState(() {
              //         langSwitch = value;
              //       });
              //     },
              //     activeTrackColor: Colors.lightBlueAccent,
              //     activeColor: Colors.lime,
              //     )),
              Divider(),
              ListTile(
                title: Text("Current location"),
                trailing: Icon(Icons.location_on),
              ),
            ],
          ),
        ),

        // trailing: SwitchWidget()

        body: Column(
          children: <Widget>[
            Expanded(
              child: Text("Weather in $location:",
              style: TextStyle(fontSize: 40.0)
              )
            ),
            Expanded(
              child: Text("$main",
              style: TextStyle(fontSize: 20.0)
              )
            ),
            Expanded(
              child: Text("$temp C°",
              style: TextStyle(fontSize: 20.0)
              )
            )
          ]
        ),
          //  Text(
          //   "Weather in $location:",
          //   style: TextStyle(fontSize: 40.0),

          //    $main"
          // ),
        // ),
      ),
    );
  }
}

// bottomNavigationBar: new Theme(
//     data: Theme.of(context).copyWith(
//         // sets the background color of the `BottomNavigationBar`
//         canvasColor: Colors.green,
//         // sets the active color of the `BottomNavigationBar` if `Brightness` is light
//         primaryColor: Colors.red,
//         textTheme: Theme
//             .of(context)
//             .textTheme
//             .copyWith(caption: new TextStyle(color: Colors.yellow))), // sets the inactive color of the `BottomNavigationBar`
//     child: new BottomNavigationBar(
//       type: BottomNavigationBarType.fixed,
//       currentIndex: 0,
//       items: [
//         new BottomNavigationBarItem(
//           icon: new Icon(Icons.add),
//           title: new Text("Add"),
//         ),
//         new BottomNavigationBarItem(
//           icon: new Icon(Icons.delete),
//           title: new Text("Delete"),
//         )
//       ],
//     ),
//   ),

//   title: Text(
//     "$location"),
//     backgroundColor: Colors.blueGrey[500],
//   ),
// drawer: Drawer(
//   child: ListView(
//     children: <Widget>[
//       ListTile()
//     ],
//   ),
// ),

//   appBar: AppBar(
//     title:
//     Text("Arnason Weather app"),
//     centerTitle: true,
//     backgroundColor: Colors.lightBlue[900],
// leading: new IconButton(
//     icon: new Icon(Icons.more_vert),
//         onPressed: () => Navigator.of(context).pop(null),
//     )
//   ),
