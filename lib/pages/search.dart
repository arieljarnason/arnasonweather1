import 'package:arnason_weather/service/weekbuilder.dart';
import "package:flutter/material.dart";
import "package:flutter/foundation.dart";


import "./loading.dart";
import "../service/weather.dart";
import "./today.dart";

// import "package:flappy_search_bar/flappy_search_bar.dart";
// 


// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       title: 'Flutter Demo',
//       theme: new ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: new MyHomePage(title: 'ListView with Search'),
//     );
//   }
// }
  // var testInstance;

  // var name = "London";
  // getWeatherFromHere(name) {
  //   WorldWeather superInstance =
  //   WorldWeather(location: name, url: "$name&appid=$apikey");
  //   superInstance.getWeather();
  //   return superInstance;
  // }


class Search extends StatefulWidget {
  Search({Key key, this.title}) : super(key: key);
  final String title;



  @override
  _SearchState createState() => new _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController editingController = TextEditingController();

  // final cityList = List<String>.generate(10000, (i) => "Item $i");
  
  // temp city list
  final List<String> cityList = citylist;
  // [
  // "reykjavik", "london", "akureyri", "paris", "madrid",
  // ];
  //Make all items in list LOWERCASE
  var items = List<String>();
  // void updateTime(index) async {
  //   WorldTime instance = locations[index];
  //   await instance.getTime();
  //   //need to navigate to home screen, pass data to homescreen
  //   Navigator.pop(context, {
  //     "location": instance.location,
  //     "flag": instance.flag,
  //     "time": instance.time,
  //     "isDaytime": instance.isDaytime,
  //   });
  // }

  // void updateLocation(index) async {
  //   WorldWeather instance = 
  // }

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

  void filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(cityList);
    if(query.isNotEmpty) {
      print("search keyrði");
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
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Search for city"),
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
                    // labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    // border: OutlineInputBorder(
                        // borderRadius: BorderRadius.all(Radius.circular(25.0)))
                        ),
              ),
            ),
            
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    
                    onTap: () async {

                      
                      print("tapped item ");
                      print("tapped item number $index");

                      // void setupWorldWeather() async {

                      // print("loading keyrði");
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
                    // }
                      // Navigator.of(context).pop();
                      // // data = getWeatherFromHere("${items[index]}");
                      // // print(data.location);
                      // Navigator.pushNamed(
                      // context, "/today", 
                      // arguments: testInstance);


                      // arguments: getWeatherFromHere("${items[index]}"));
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








// class Search extends StatefulWidget {
//   @override
//   _SearchState createState() => _SearchState();
// }
// class Post {
//   final String title;
//   final String description;

//   Post(this.title, this.description);
// }




// Future<List<Post>> search(String search) async {
//   await Future.delayed(Duration(seconds: 2));
//   return List.generate(search.length, (int index) {
//     return Post(
//       "Title : $search $index",
//       "Description :$search $index",
//     );
//   });
// }

// class _SearchState extends State<Search> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: SearchBar<Post>(
//             onSearch: search,
//             minimumChars: 2,
//             loader: Text("Searching..."),
//             debounceDuration: Duration(milliseconds: 800),
//             onItemFound: (Post post, int index) {
//               return ListTile(
//                 title: Text(post.title),
//                 subtitle: Text(post.description)
//               );
//             },
//           )
//         ),
//       ),
//     );
//   }
// }