abstract class BoardEvent {
  const BoardEvent();
}

class Init extends BoardEvent {}

class GetCards extends BoardEvent {
  final int rowNumber;
  const GetCards(this.rowNumber);
}
