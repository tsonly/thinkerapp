class UserResponse{
  var sucess;
  var message;
  var token;

  fromJson(Map<dynamic, dynamic> json){
    this.sucess = json['success'];
    this.message = json['message'];
    this.token = json['token'];

    return this;
  }

  toJson(){
    Map<String, dynamic> json = new Map<dynamic, dynamic>();
    json['token'] = this.token;

    return json;
  }
}