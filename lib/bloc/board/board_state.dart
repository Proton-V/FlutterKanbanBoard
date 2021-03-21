import 'package:test_kanban/shared/models/board_card.dart';

abstract class BoardState {}

class BoardInit extends BoardState {}

class BoardLoading extends BoardState {}

class BoardLoaded extends BoardState {
  final List<BoardCard> cards;
  BoardLoaded(this.cards);
}

class BoardFailed extends BoardState {}
