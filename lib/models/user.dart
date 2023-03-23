import 'package:api_test/models/user_dob.dart';
import 'package:api_test/models/user_name.dart';
import 'package:api_test/models/user_picture.dart';

class user {
  final String gender;
  final String email;
  final userName name;
  final userDob dob;
  final userImage image;
  user(
      {required this.gender,
      required this.email,
      required this.name,
      required this.dob,
      required this.image});
  String get fullname {
    return "${name.title} ${name.first} ${name.last}";
  }
}
