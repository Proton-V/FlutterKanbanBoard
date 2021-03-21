class BoardCard {
  int id;
  String row;
  int seqNum;
  String text;

  BoardCard.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        row = json['row'],
        seqNum = json['seq_num'],
        text = json['text'];

  Map<String, dynamic> toJson() =>
      {'id': id, 'row': row, 'seq_num': seqNum, 'text': text};
}
