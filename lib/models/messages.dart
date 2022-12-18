class ChatModel {
  String? reciverId;
  String? sederId;
  String? text;
  String? dateTime;


  ChatModel({
    this.reciverId,
    this.sederId,
    this.text,
    this.dateTime,
  });

  ChatModel.fromJson(Map<String, dynamic>json){
    reciverId = json['reciverId'];
    sederId = json['sederId'];
    text = json['text'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'reciverId':reciverId,
      'sederId':sederId,
      'text':text,
      'dateTime':dateTime,
    };
  }

}