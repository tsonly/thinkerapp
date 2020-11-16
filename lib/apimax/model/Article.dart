class Article {
  var id;
  var account;
  var text;
  var video;
  var image;
  var like;
  var comment;
  var author;
  var timestamp;
  var position;

  fromJson(Map<String, dynamic> map){
    this.id = map['_id'];
    this.account = map['account'];
    this.text = map['text'];
    this.video = map['video'];
    this.image = map['image'];
    this.like = map['like'];
    this.comment = map['comment'];
    this.timestamp = map['timestamp'];
    this.author = map['author'];

    return this;
  }
}
