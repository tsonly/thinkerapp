import 'dart:convert';

import 'package:http/http.dart';
import 'package:thinker/apimax/core/api.dart';
import 'package:thinker/apimax/database/SecureController.dart';
import 'package:thinker/apimax/model/Article.dart';

class ArticleController {

    Api api;
    SecureController secureController;

    ArticleController() {
        api = new Api();
        secureController = SecureController();
    }

    sendArticle({ text, video, images }) async {
      Response result = await api.newArticle(text:text, video:video, images:images);
      if(result.statusCode == 200){
        return true;
      }else return false;
    }

    timeline()async {
      Response result = await api.timeline();
      var json = jsonDecode(result.body);
      var line = [];
      for(var a in json){
        var article = Article().fromJson(a);
        line.add(article);
      }
      return line;
    }

    like(id, like)async {
      Response result = await api.like(id, like);
      var json = jsonDecode(result.body);
      var article = Article().fromJson(json);
      return article;
    }
}