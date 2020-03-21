import 'package:flutter/material.dart';
import "package:flutter_spinkit/flutter_spinkit.dart";
import 'package:weather/weather.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}



class _LoadingState extends State<Loading> {

  void setupWeather() async {

  }

  @override

  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        body: Column(
          children: <Widget>[
                Image(image: AssetImage("assets/logo1.png"), height: 200),
                SizedBox(height: 140.0),
                Text(
                    "Loading...",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.blueGrey[700],
                    )
                ),
                SizedBox(height: 10.0),
                SpinKitPulse(
                color: Colors.blueGrey[200]
                )
              ]
        )
      ),
    );
  }
}
    //     return Card(
    //   margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
    //   child: Padding(
    //     padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
    //     child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.stretch,
    //         children: <Widget>[
    //           Text(
    //               "Loading",
    //               style: TextStyle(
    //                 fontSize: 18.0,
    //                 color: Colors.blueGrey[700],
    //               )
    //           ),
    //           SpinKitPulse(
    //           color: Colors.blueGrey[200]
    //           )
    //         ]
    //     ),
    //   ),
    // );
    // return Card(
    //   child: Column(
    //     children <Widget>[
    //       Text(
    //         "Loading..."
    //       ),
    //       SpinKitPulse(
    //       color: Colors.blueGrey[200]
    //       )
    //     ]
    //   )
    // );

      // child: Text(

      // )      
      // body: Center(
      