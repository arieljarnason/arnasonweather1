import 'package:flutter/material.dart';

class SwitchWidget extends StatefulWidget {
  @override
  _SwitchWidgetState createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  @override
  Widget build(BuildContext context) {
    bool switchControl = false;
    var textHolder = 'Switch is OFF';

    void toggleSwitch(bool value){

      if(switchControl == false){
        setState((){
            switchControl = true;
          });
          print('Switch is on');
          // my code for C / F
        }
      else{
        setState((){
          switchControl = false;
        });
        print('Switch is off');
        // my code for c / f
        }
      }
      @override
      Widget build(BuildContext context) {
        return Switch(
              onChanged: toggleSwitch,
              value: switchControl,
              activeColor: Colors.blue,
              activeTrackColor: Colors.green,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.grey,
            );
      }
    }
  }

class Today extends StatefulWidget {
  @override
  _TodayState createState() => _TodayState();
}

class _TodayState extends State<Today> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;

    var main = data["main"];
    var location = data["location"];
    // String daytimeImage = data[]
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          // PopupMenuButton<String>(
          //   itemBuilder: (BuildContext context){
          //     return 
          //   },
          // )
          FlatButton.icon(
            icon: Icon(
              Icons.location_city
              ,
              color: Colors.white,
            ),
            onPressed: () {},
            label: Text(
              "$location",
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                )
              ),
                          
            shape: CircleBorder(
              side: BorderSide(
                color: Colors.transparent
                )
              ),
          )
        ],
        // title: Text("$location",
        //   style: TextStyle(color: Colors.white),
        //   textDirection: TextDirection.ltr),
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              colors: [
                const Color(0xFF37474F),
                const Color(0xFF78909C),
                      ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp
            ),
          ),
        ),        
      ),
          
          
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader( 
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/logo1.png"), 
                )
              ),
              child: Text(
                "Weather",
                style: TextStyle(
                  fontSize: 40.0
                )
              ),
            ),
            // SizedBox(height: 20.0),
            ListTile(
              title: Text("Today's weather"),
              trailing: Icon(Icons.cloud)
            ),
            ListTile(
              title: Text("The week's weather"),
              trailing: Icon(Icons.view_week)
            ),
            Divider(),
            ListTile(
              title: Text("C° / F°"),
              // trailing: SwitchWidget()
            ),
          ],
        ),
      ),       
          
          
          body: Center(
            child: Text(
              "Weather in $location: $main",
              style: TextStyle(
              fontSize: 40.0
          ),
        ),
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
