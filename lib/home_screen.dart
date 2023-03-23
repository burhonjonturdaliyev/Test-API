import 'dart:convert';

import 'package:api_test/api/user_api.dart';
import 'package:api_test/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'models/user_name.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<user> users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Test api")),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            //  tileColor: user.gender == "female" ? Colors.green : Colors.brown,
            leading: CircleAvatar(
                backgroundImage: NetworkImage(user.image.thumbnail)),
            trailing: Text(DateFormat("yyyy").format(user.dob.time)),
            subtitle: Text(user.email),
            title: Text(user.fullname),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchUsers,
      ),
    );
  }

  @override
  void initState() {
    fetchUsers();
    super.initState();
  }

  void fetchUsers() async {
    final response = await userApi.fetchUsers();
    setState(() {
      users = response;
    });
  }
}
