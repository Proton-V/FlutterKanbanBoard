import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_kanban/bloc/board/board.dart';
import 'package:test_kanban/screens/login/main.dart';
import 'package:test_kanban/shared/models/board_card.dart';

class BoardPage extends StatefulWidget {
  BoardPage({Key key}) : super(key: key);

  @override
  _BoardPageState createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final List<Widget> tabList = [
    Tab(text: 'On hold'),
    Tab(text: 'In progress'),
    Tab(text: 'Needs review'),
    Tab(text: 'Approved'),
  ];

  BlocBoard _blocBoard;
  TabController _tabController;

  _logOut() {
    if (!_isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          ModalRoute.withName('/'),
        );
      });
    }
  }

  _firstLoad() {
    _tabController =
        TabController(length: tabList.length, initialIndex: 0, vsync: this);
    _blocBoard = BlocProvider.of<BlocBoard>(context);

    _tabController.animation.addListener(() {
      if (_tabController.indexIsChanging) {
        _isLoading = true;
        _blocBoard.add(GetCards(_tabController.index));
      }
    });
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _isLoading = true;
        _blocBoard.add(GetCards(_tabController.index));
      }
    });

    _blocBoard.add(new GetCards(0));
  }

  @override
  void initState() {
    super.initState();
    _firstLoad();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () => _logOut(),
        ),
        backgroundColor: Colors.blue[800],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: tabList,
        ),
      ),
      body: _formBoard(),
    );
  }

  Widget _formBoard() {
    return BlocBuilder<BlocBoard, BoardState>(buildWhen: (previous, current) {
      if (current is BoardLoaded) {
        _isLoading = false;
      }
      return;
    }, builder: (context, state) {
      if (state is BoardLoaded && !_isLoading) {
        return TabBarView(
            key: _formKey,
            // ignore: unused_local_variable
            children: [
              for (var i in tabList) cardList(state.cards),
            ],
            controller: _tabController);
      } else
        return Center(
          child: CircularProgressIndicator(),
        );
    });
  }

  Widget cardList(List<BoardCard> cards) {
    return ListView.builder(
      itemCount: cards.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.blue,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ID: ${cards[index].id}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.0,
                    ),
                  ),
                  SizedBox(height: 3.0),
                  Text(
                    cards[index].text,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
