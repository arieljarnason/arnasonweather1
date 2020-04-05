import "package:flutter/material.dart";
import "package:flutter/foundation.dart";


import "../service/weather.dart";

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

class Search extends StatefulWidget {
  Search({Key key, this.title}) : super(key: key);
  final String title;



  @override
  _SearchState createState() => new _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController editingController = TextEditingController();

  // final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  
  final List<String> duplicateItems = [
  "reykjavik", "london", "akureyri", "paris", "madrid"
  ];
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

  void updateLocation(index) async {
    
  }
  
  @override
  void initState() {
    items.addAll(duplicateItems);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(duplicateItems);
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
        items.addAll(duplicateItems);
      });
    }

  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Search for city"),
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
                    
                    onTap: (){
                      print("tapped item ${items[index]}");
                      Navigator.of(context).pop();
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