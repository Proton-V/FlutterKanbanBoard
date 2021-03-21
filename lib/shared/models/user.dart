class User {
  String username;
  String password;
  String token;

  User(this.username, this.password);
  User.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        password = json['password'],
        token = json['token'];

  Map<String, dynamic> toJson() =>
      {'username': username, 'password': password, 'token': token};
}
