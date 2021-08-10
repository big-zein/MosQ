class User {
  final String uid;
  String? email;
  String? password;

  User(this.uid);

  static attributeName(String attribute) {
    var lang = {
      'email': 'Email',
      'password': 'Password',
    };
    return lang[attribute];
  }
}
