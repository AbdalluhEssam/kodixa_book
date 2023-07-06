class CommentModel {
  String? senderId;
  String? postId;
  String? dateTime;
  String? text;


  CommentModel({
    this.senderId,
    this.postId,
    this.dateTime,
    this.text,
  });

  CommentModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    postId = json['postId'];
    dateTime = json['dateTime'];
    text = json['text'];

  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'postId': postId,
      'dateTime': dateTime,
      'text': text,
    };
  }
}
