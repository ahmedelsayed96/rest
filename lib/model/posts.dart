class Post {

  int userId;
  int id;
  String title;
  String body;

  Post({this.userId, this.id, this.title, this.body});


  factory Post.fromJson(Map<String, dynamic> json){
    return Post(
        id: json['id'],
        userId: json['userId'],
        body:json['body'],
        title: json['title'],
    );
  }


}
