import 'package:flutter/material.dart';
import "package:arnason_weather/pages/loading.dart";

void main() => runApp(MaterialApp(
  initialRoute: "/",
  routes: {
    "/": (context) => Loading(),
    // "/today": (context) => today(),
    // "/week": (context) => Week(),
  },
));
