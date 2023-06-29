class PostSupport {
  Dialogs dialogs;
  int userId;

  PostSupport({
    required this.dialogs,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'dialogs': dialogs.toJson(),
      'userId': userId,
    };
  }
}

class Dialogs {
  String message;
  int userId;

  Dialogs({
    required this.message,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'userId': userId,
    };
  }
}
