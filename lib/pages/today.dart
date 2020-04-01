import 'package:flutter/material.dart';


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
                ListTile()
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
