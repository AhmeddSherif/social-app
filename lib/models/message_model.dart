class MessageModel {
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? message;

  MessageModel({
    this.senderId,
    this.receiverId,
    this.dateTime,
    this.message,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    message = json['message'];
  }
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'senderId': senderId,
      'receiverId': receiverId,
      'dateTime': dateTime,
      'message': message,
    };
    return map;
  }
}
