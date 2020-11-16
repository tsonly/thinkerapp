import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:thinker/apimax/core/api.dart';
import 'package:thinker/apimax/database/SecureController.dart';
import 'package:thinker/apimax/response/UserResponse.dart';


class AccountController{

  Api api;
  SecureController secureController;
  
  AccountController(){
    this.api = Api();
    secureController = SecureController();
  }


  login(email, senha)async{
     try{
       Response result = await api.login(email: email, senha:senha);
       var json = jsonDecode(result.body);
       if(json['success'] == true){
         await secureController.save("token", json['token']);
         await secureController.save("email", email);
         await secureController.save("name", json['perfil']['nome']);
         await secureController.save("id", json['id']);
         return true;
       }else{
         return false;
       }
     }catch(err){
       print(err);
     }
  }
  registro(email, senha)async{
     try{
       Response result = await api.registro(email: email, senha:senha);
       var json = jsonDecode(result.body);
       if(json['success'] == true){
         await secureController.save("token", json['token']);
         await secureController.save("email", email);
          await secureController.save("name", json['nome']);
         await secureController.save("id", json['id']);
         return true;
       }else{
         return false;
       }
     }catch(err){
       print(err);
     }
  }

  verifyLogin()async {
    var token = await secureController.read("token");
    if(token != null){
      return true;
    }else return false;
  }

  search(String text)async {
      Response result = await api.search(text);
      var json = jsonDecode(result.body);
      return json;
    
  }
}