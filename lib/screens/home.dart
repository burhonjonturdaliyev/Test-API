import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../models/models.dart';

class Home_page extends StatefulWidget {
  const Home_page({super.key});

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  List<model> models = [];
  void fetchInfo() async {
    try {
      print("Loading started");
      const uri = "http://185.196.213.43:7088/api/air/ticket/info";
      final url = Uri.parse(uri);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final body = response.body;
        final json = jsonDecode(body);
        final result = json["object"] as List<dynamic>;
        final postes = result
            .map(
              (e) => model(
                  id: e["id"] as int,
                  createdAt: DateTime.parse(e["createdAt"]),
                  updatedAt: DateTime.parse(e["updatedAt"]),
                  fromTo: e["fromTo"],
                  whereTo: e["whereTo"],
                  toGoDate: DateTime.parse(e["toGoDate"]),
                  returnDate: DateTime.parse(e["returnDate"]),
                  airClass: e["airClass"],
                  passenger: e["passenger"] as int,
                  userId: e["userId"] as int),
            )
            .toList();
        setState(() {
          models = postes;
        });
        print(body);
      } else {
        print("Error");
      }
    } catch (e) {
      print("Error occurred => $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: fetchInfo),
        backgroundColor: Colors.deepOrange,
        // ignore: prefer_const_constructors
        body: ListView.builder(
          itemCount: models.length,
          itemBuilder: (context, index) => items(models[index]),
        ));
  }
}

Widget items(model models) {
  return Container(
    child: Column(
      children: [
        Text(DateFormat("HH:mm, MMMM, yyyy").format(models.toGoDate)),
        Text("${models.id}"),
      ],
    ),
  );
}
