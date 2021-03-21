import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:test_kanban/bloc/board/board.dart';
import 'package:test_kanban/shared/api_auth.dart';
import 'package:test_kanban/shared/models/board_card.dart';
import 'package:http/http.dart' as http;

class BlocBoard extends Bloc<BoardEvent, BoardState> {
  BlocBoard(BoardState initialState) : super(initialState);
  List<BoardCard> cards;
  @override
  get initialState => BoardInit();

  @override
  Stream<BoardState> mapEventToState(BoardEvent event) async* {
    try {
      if (event is Init) {
        yield BoardInit();
      } else if (event is GetCards) {
        yield BoardLoading();

        var row = 0;
        final response = await http
            .get('${ApiAuth.instance.apiUrl}cards?row=$row', headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'JWT ${ApiAuth.instance.user.token}'
        });
        if (response.statusCode == 200) {
          cards = await ApiAuth.instance.getCards(event.rowNumber);
        } else {
          throw Exception('Error fetching posts');
        }
        yield cards != null ? BoardLoaded(cards) : BoardFailed();
        print('CARDS:${cards.length}');
      }
    } catch (e) {
      yield BoardFailed();
    }
  }
}
