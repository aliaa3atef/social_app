class SocialUserModel
{
  String name , email , phone ,cover , image ,bio, uid;


  SocialUserModel({
    this.name,
    this.email,
    this.phone,
    this.cover,
    this.image,
    this.bio,
    this.uid,
});

  SocialUserModel.fromJson(Map<String,dynamic>json)
  {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    cover = json['cover'];
    image = json['image'];
    bio = json['bio'];
    uid = json['uid'];
  }

  Map<String,dynamic> toMap()
  {
    return {
      'name' : name,
      'email' : email,
      'phone' : phone,
      'cover' : cover,
      'image' : image,
      'bio' : bio,
      'uid' : uid,
    };
  }
}