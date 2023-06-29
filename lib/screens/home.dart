import 'dart:convert';

import 'package:api_test/models/support.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();

  putMessage() async {
    try {
      final postSupport = PostSupport(
        dialogs: Dialogs(
          message: controller.text,
          userId: 4,
        ),
        userId: 4,
      );

      final response = await http.post(
        Uri.parse(
            'http://ec2-54-199-249-118.ap-northeast-1.compute.amazonaws.com:7088/sos/api/support-chat'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(postSupport.toJson()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
      } else if (response.statusCode == 403) {
        print("Logout");
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a value";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(33),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await putMessage();
                  controller.text;
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
