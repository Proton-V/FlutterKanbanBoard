import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_kanban/bloc/auth/auth.dart';
import 'package:test_kanban/bloc/board/board.dart';
import 'package:test_kanban/screens/login/main.dart';
import 'package:test_kanban/shared/api_auth.dart';
import 'package:test_kanban/shared/models/board_card.dart';

void main() {
  ApiAuth().setup();
  runApp(Application());
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BlocAuth>(
            create: (BuildContext context) => BlocAuth(new UnlogedState())),
        BlocProvider<BlocBoard>(
            create: (BuildContext context) => BlocBoard(new BoardInit()))
      ],
      child: MaterialApp(
        color: Colors.white,
        debugShowCheckedModeBanner: false,
        title: 'Nekidaem Flutter Kanban',
        home: FirstScreen(),
      ),
    );
  }
}

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoginScreen();
  }
}
