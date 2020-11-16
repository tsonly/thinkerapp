import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

import 'package:http/http.dart' as http;

class Api{

  static const url = "http://10.0.2.1:8084";
  FlutterSecureStorage secure;
 

  Api(){
    secure = new FlutterSecureStorage();
    
  }

  login({email, senha})async {
    return await http.post(url+"/login", body: {'email':email, 'senha':senha});
  }
  registro({email, senha})async {
    return await http.post(url+"/register", body: {'email':email, 'senha':senha});
  }
  Future<Response> newArticle({text, video, images})async{
    
    var data = jsonEncode(images);
    print(data);
    return await http.post(url+"/article", headers: await authorize(), body: {'text':text, 'video':video, 'image':data});
  }

  authorize()async{
    Map<String, String> headers = new Map();
    headers['Authorization'] = await secure.read(key:"token");
    
    return headers;
  }

  timeline()async {
    return await http.get(url+"/timeline", headers: await authorize());
  }

  like(id, like) async {
    print(id);
    return await http.post(url+"/like", headers: await authorize(), body: {'id':id, "unlike":like});
  }

  search(String text) async{
    return await http.get(url+"/search?text=$text", headers: await authorize());
  }
}