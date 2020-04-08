import 'package:arnason_weather/pages/today.dart';
import 'package:flutter/material.dart';

import "./pages/loading.dart";
import "./pages/search.dart";

// set up system routes
void main() => runApp(MaterialApp(
  initialRoute: "/",
  routes: {
    "/": (context) => Loading(),
    "/today": (context) => Today(),
    "/search": (context) => Search(),
  },
));
