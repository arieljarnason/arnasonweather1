import 'package:arnason_weather/service/weekbuilder.dart';
import "package:flutter/material.dart";
import "package:flutter/foundation.dart";

import "./loading.dart";
import "../service/weather.dart";

class Search extends StatefulWidget {
  Search({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController editingController = TextEditingController();

  final List<String> cityList = citylist;

  //Make all items in list LOWERCASE?
  var items = List<String>();
  
  @override
  void initState() {
    items.addAll(cityList);
    super.initState();
  }

  getWeatherFromHere(name) {
    WorldWeather newInstance =
    WorldWeather(location: name, url: "$name&appid=$apikey");
    newInstance.getWeather();
    return newInstance;
  }

  // search function, filter results and reprint based on them
  void filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(cityList);
    if(query.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if(item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(cityList);
      });
    }

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search for city",
        style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.025,
                fontFamily: 'OpenSans',
                letterSpacing: 1),),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blueGrey[200], Colors.blueGrey[900]],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
      ),


      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                        ),
              ),
            ),
            
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(

                    // sloppy way to push selected city into main screen - need FIX
                    onTap: () async {
                        WorldWeather curInstance =
                          WorldWeather(
                            location: "${items[index]}", 
                            url: "q=${items[index]}&appid=$apikey");
                        await curInstance.getWeather();
                      
                      Weekbuilder curWeekInstance = 
                      Weekbuilder(
                            location: "${items[index]}",
                            url: "q=${items[index]}&appid=$apikey");
                        await curWeekInstance.getWeatherWeek();
  
                      List myInstances = [];
                      myInstances.add(curInstance);
                      myInstances.add(curWeekInstance);

                      Navigator.of(context).pop();
                      Navigator.pushNamed(
                        context, "/today", 
                        arguments: myInstances);
                   },
                    title: Text('${items[index]}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}