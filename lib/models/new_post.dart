class CreatePost{
  String? name;
  String? uId;
  String? dateTime;
  String? postImage;
  String? image;
  String? text;

  CreatePost({
    this.name,
    this.uId,
    this.text,
    this.dateTime,
    this.postImage,
    this.image,
});

  CreatePost.fromJson(Map<String,dynamic>json){
    name =json['name'];
    uId =json['uId'];
    text =json['text'];
    dateTime =json['dateTime'];
    postImage =json['postImage'];
    image=json['image'];
  }

  Map<String,dynamic> toMap(){
    return{
      'name':name,
      'uId':uId,
      'text':text,
      'dateTime':dateTime,
      'postImage':postImage,
      'image':image
    };
  }
}