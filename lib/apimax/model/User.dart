class User{
  var email;
  var senha;

  fromJson(Map<String, dynamic> json){
    this.email = json['email'];
    this.senha = json['senha'];
  }
}