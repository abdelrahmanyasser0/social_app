class CommentsModel {
  String? postId;
  String? text;
  String? dateTime;


  CommentsModel({
    this.postId,
    this.text,
    this.dateTime,
  });

  CommentsModel.fromJson(Map<String, dynamic>json){
    postId = json['postId'];
    text = json['text'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'postId':postId,
      'text':text,
      'dateTime':dateTime,
    };
  }

}