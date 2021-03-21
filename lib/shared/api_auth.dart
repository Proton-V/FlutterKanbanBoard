import 'dart:convert';

import 'package:test_kanban/bloc/auth/auth.dart';
import 'package:http/http.dart' as http;
import 'package:test_kanban/shared/models/user.dart';

import 'models/board_card.dart';

class ApiAuth {
  static ApiAuth _this;
  static ApiAuth get instance => _this;
  User user;
  final String apiUrl = 'https://trello.backend.tests.nekidaem.ru/api/v1/';

  void setup() {
    if (_this == null) _this = this;
  }

  // implement your workflow for authentication with your server

  Future login(LoginEvent event) async {
    final response = await http.post(
      '${apiUrl}users/login/',
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
      body: jsonEncode(event.user.toJson()),
    );
    print(response.statusCode);
    var json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      event.user.token = json['token'].toString();
      user = event.user;
      return LogedState();
    } else {
      print(json['non_field_errors']);
      return LoginFailState(json['non_field_errors'].toString());
    }
  }

  Future<List<BoardCard>> getCards(int row) async {
    print("${user.token}");

    final response = await http.get('${apiUrl}cards?row=$row', headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'JWT ${user.token}'
    });
    print("GetCard${response.statusCode}/$row");
    if (response.statusCode == 200) {
      final List<dynamic> jsonList =
          json.decode(utf8.decode(response.body.toString().codeUnits));
      return jsonList.map((json) => BoardCard.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching posts');
    }
  }

  Future logout() async {
    await Future.delayed(Duration(seconds: 1));
  }

  Future changePassword() async {
    await Future.delayed(Duration(seconds: 1));
  }

  Future signUp() async {
    await Future.delayed(Duration(seconds: 1));
  }

  Future resendCode({email}) async {
    await Future.delayed(Duration(seconds: 2));
  }
}
