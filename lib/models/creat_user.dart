class SocialCreateUser {
  String? name;
  String? email;
  String? uId;
  String? phone;
  String? image;
  String? cover;
  String? bio;

  SocialCreateUser({
    this.name,
    this.email,
    this.uId,
    this.phone,
    this.image,
    this.cover,
    this.bio
  });

  SocialCreateUser.fromJson(Map<String, dynamic>json){
    name = json['name'];
    email = json['email'];
    uId = json['uId'];
    phone = json['phone'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name':name,
      'email':email,
      'uId':uId,
      'phone':phone,
      'image':image,
      'cover':cover,
      'bio':bio,
    };
  }

}