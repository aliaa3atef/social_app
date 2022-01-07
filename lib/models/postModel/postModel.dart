class PostModel
{
  String name , image , date , uid , post , postImage;


  PostModel({
    this.name,
    this.image,
    this.date,
    this.post,
    this.postImage,
    this.uid,
  });

  PostModel.fromJson(Map<String,dynamic>json)
  {
    name = json['name'];
    image = json['image'];
    date = json['date'];
    post = json['post'];
    postImage = json['postImage'];
    uid = json['uid'];
  }

  Map<String,dynamic> toMap()
  {
    return {
      'name' : name,
      'image' : image,
      'date' : date,
      'post' : post,
      'postImage' : postImage,
      'uid' : uid,
    };
  }
}