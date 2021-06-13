
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:https_connection_get/jsonlist.dart';

class JsonListView extends StatefulWidget {
  @override
  _JsonListViewState createState() => _JsonListViewState();
}

class _JsonListViewState extends State<JsonListView> {

  final String uri = 'https://000webhostsetting.000webhostapp.com/getdata1.php';

  Future<List<Fruitdata>> fetchFruits() async {
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<Fruitdata> listOfFruits = items.map<Fruitdata>((json) {
        return Fruitdata.fromJson(json);
      }).toList();

      return listOfFruits;
    }
    else {
      throw Exception('Failed to load data.');
    }
  }

  @override
  Widget build(BuildContext context) {

     return Scaffold(
      appBar: AppBar(
        title: Text("HttP ListView"),
      ),
      body: FutureBuilder<List<Fruitdata>>(
        future: fetchFruits(),
        builder: (context, snapshot){
          if (!snapshot.hasData) return Center(
              child: CircularProgressIndicator()
          );

        return ListView(
            children: snapshot.data
                .map((data) => Card(
              child: ListTile(
                title: Text(data.name),
                subtitle: Text(data.email),
                leading: CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: Text(data.name[0],style: TextStyle(color: Colors.white,fontSize: 20),),
                ),
                onTap: (){
                  print(data.name);
                },
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_sharp),
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>JsonList(data.name)));
                  },
                ),
              ),
            )
          )
          .toList(),
          );
        },
      ),
    );



  /*  return FutureBuilder<List<Fruitdata>>(
      future: fetchFruits(),
      builder: (context, snapshot) {

        if (!snapshot.hasData) return Center(
            child: CircularProgressIndicator()
        );
      return ListView(
          children:  snapshot.data
              .map((data) => Card(
          child: ListTile(
            title: Text(data.name),
            onTap: (){print(data.name);},
          )
          ),
        )
              .toList(),
        );



      },
    );
*/
  }
}


  class Fruitdata {
  String name;
  String email;
  String password;

  Fruitdata({
    this.name,
    this.email,
    this.password,
  });

  factory Fruitdata.fromJson(Map<String, dynamic> json) {
    return Fruitdata(
      name: json['name'],
      email: json['email'],
      password: json['password'],

    );
  }
}