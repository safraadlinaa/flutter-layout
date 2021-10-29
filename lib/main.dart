import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Flutter Layout',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _mockData = [];

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/MOCK_DATA.json');
    final data = await json.decode(response);
    setState(() {
      _mockData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: const Text('Details'), 
      ),
      body: FutureBuilder(
        //calling data
        future: readJson(), 
        builder: (context, data) {
          //data appear in list
          return ListView.builder(         
               //will repeat list for the number of data
            itemCount: _mockData.length,
            itemBuilder: (context, id) { 
              // styling for a(1) card
            return Card(
              margin: const EdgeInsets.all(2),
              child: Row(
                children: <Widget>[
                  // first container leftSection
                  Container(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage("${_mockData[id]["avatar"] ?? "https://icon-library.com/images/user-icon-jpg/user-icon-jpg-5.jpg"}"),
                      radius: 42.0,
                      backgroundColor: Colors.grey[200],
                    ),
                ),
                // second container middleSection
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // calling for data from .json file
                        children: <Widget>[     
                          Text(_mockData[id]["first_name"]+ " "+_mockData[id]["last_name"],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0
                          ),
                          ),
                          Text(_mockData[id]["username"],
                          style: TextStyle(
                            fontSize: 18.0
                          ),),
                          Text(_mockData[id]["status"] ?? "...",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 17.0
                          ),
                          ),
                        ],
                      ),
                    )
                  ),
                  // third container rightSection
                  Container(
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(_mockData[id]["last_seen_time"]),
                        CircleAvatar(
                          radius: 20.0,
                          backgroundColor: Colors.grey[200],
                          child: Text(((_mockData[id]["messages"] ?? "0").toString()),                           
                            style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 17.0
                            ),
                        )
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
        },
      ),
    );
  }
}
