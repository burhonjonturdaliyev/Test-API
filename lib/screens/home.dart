import 'dart:convert';

import 'package:api_test/models/chat_models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:intl/intl.dart';

import '../models/models.dart';

class Home_page extends StatefulWidget {
  const Home_page({super.key});

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  List<chat_models> models = [];
  void fetchInfo() async {
    try {
      print("Loading started");
      const uri = "http://185.196.213.43:7088/chat";
      final url = Uri.parse(uri);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final body = response.body;

        final json = jsonDecode(body);
        print(json);
        final result = json["object"] as List<dynamic>;
        final chates = result
            .map(
              (e) => chat_models(
                  id: e["id"] as int,
                  message: e["message"],
                  username: e["username"],
                  userId: e["userId"] as int,
                  edited: e["edited"] as bool),
            )
            .toList();
        setState(() {
          models = chates;
        });
      } else {}
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

Widget items(chat_models models) {
  return Container(
    child: Column(
      children: [Text(models.message)],
    ),
  );
}
