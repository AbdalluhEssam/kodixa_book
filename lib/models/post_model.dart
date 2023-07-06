class PostModel {
  String? uId;
  String? dateTime;
  String? text;
  String? postImage;

  PostModel({
    this.uId,
    this.dateTime,
    this.text,
    this.postImage,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImage = json['postImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'dateTime': dateTime,
      'text': text,
      'postImage': postImage,
    };
  }
}
