
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class JsonList extends StatelessWidget {
  final String name;
  JsonList(this.name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HOME"),
      ),
      body: Center(
        child: Text("HAi YOur name is $name",style: TextStyle(
          fontSize: 32,color: Colors.blueAccent
        ),),
      ),
    );
  }
}
