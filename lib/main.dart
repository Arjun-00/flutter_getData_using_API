import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'jsonlistview.dart';

void main() {
  runApp(MyApp());
}

class Album {
 final String name;
 final String email;
 final String password;

  Album({this.name,this.email,this.password});
 factory Album.fromJson(Map<String, dynamic> json){
   return Album(
     name: json['name'],
     email: json['email'],
     password: json['password'],
   );
 }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: JsonListView(),
      ),
    );
  }
}

class HomePageState extends StatefulWidget {
  @override
  _HomePageStateState createState() => _HomePageStateState();
}

class _HomePageStateState extends State<HomePageState> {
  Future<Album> futureAlbum; 


  Future<Album> fetchAlbum() async {
    final responce = await http.get('https://000webhostsetting.000webhostapp.com/getdata1.php');
    var message1 = jsonDecode(responce.body);
    print(responce.statusCode.toString());
    if(responce.statusCode == 200){
      // return Album.fromJson(jsonDecode(responce.body));
      print(message1.toString());
      //print(Album.fromJson(json.decode(responce.body)).toString());
      return Album.fromJson(message1);
    }
    else{
      //return error
      throw Exception('Faild to Load Album');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureAlbum = fetchAlbum();
   print(fetchAlbum().toString());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HTTTP CONNECTION"),
      ),
      body: Center(

        child: FutureBuilder<Album> (
          future: futureAlbum,
          builder: (context, snapshot){
            if(snapshot.hasData){
              print("hasdata");
              return Text(snapshot.data.name);
            }else{
              return Text("Still loading");
            }
          },
        )
      ),
    );
  }
}

