import 'dart:convert';

import 'package:api_test/models/user_dob.dart';
import 'package:api_test/models/user_picture.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';
import '../models/user_name.dart';

class userApi {
  static Future<List<user>> fetchUsers() async {
    const uri = "https://randomuser.me/api/?results=25";
    final url = Uri.parse(uri);

    print("Yuklash boshlandi");
    final response = await http.get(url);
    final body = response.body;
    final json = jsonDecode(body);
    final result = json["results"] as List<dynamic>;
    final users = result.map((e) {
      final Name = userName(
        first: e["name"]["first"],
        last: e["name"]["last"],
        title: e["name"]["title"],
      );
      final date = e["dob"]["date"];
      final image = userImage(
          large: e["picture"]["large"],
          medium: e["picture"]["medium"],
          thumbnail: e["picture"]["thumbnail"]);

      final Dop = userDob(time: DateTime.parse(date), age: e["dob"]["age"]);
      return user(
          gender: e["gender"],
          email: e["email"],
          name: Name,
          dob: Dop,
          image: image);
    }).toList();

    print("Yuklash tugatildi");
    return users;
  }
}
