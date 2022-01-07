class ChatModel
{
  String message , image ,date , receiverId , senderId ;


  ChatModel({
    this.message,
    this.image,
    this.date,
    this.receiverId,
    this.senderId,
  });

  ChatModel.fromJson(Map<String,dynamic>json)
  {
    message = json['message'];
    image = json['image'];
    date = json['date'];
    receiverId = json['receiverId'];
    senderId = json['senderId'];
  }

  Map<String,dynamic> toMap()
  {
    return {
      'message' : message,
      'image' : image,
      'date' : date,
      'receiverId' : receiverId,
      'senderId' : senderId,
    };
  }
}