import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:news_app/models/articleModel.dart';


class News{
  List<ArticleModel> news =[];
  Future<void> getNews() async{
    String url= "http://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=apikey";
    http.Response response=await http.get(url);

    var jsonData= jsonDecode(response.body);

    if(jsonData["status"]=="ok"){
      jsonData["articles"].forEach((element){
        if(element["urlToImage"]!=null && element["description"]!=null){
          ArticleModel articleModel=new ArticleModel(
            title: element["title"],
            description: element["description"],
            urlToImage: element["urlToImage"],
            url: element["url"],
            content: element["content"],
            author: element["author"],
          );
          news.add(articleModel);
        }
      });
    }
  }
}

class CategoryNewsClass{
  List<ArticleModel> news =[];
  Future<void> getNews(String category) async{
    String url= "https://newsapi.org/v2/top-headlines?category=${category}&country=in&apiKey=apikey";
    http.Response response=await http.get(url);

    var jsonData= jsonDecode(response.body);

    if(jsonData["status"]=="ok"){
      jsonData["articles"].forEach((element){
        if(element["urlToImage"]!=null && element["description"]!=null){
          ArticleModel articleModel=new ArticleModel(
            title: element["title"],
            description: element["description"],
            urlToImage: element["urlToImage"],
            url: element["url"],
            content: element["content"],
            author: element["author"],
          );
          news.add(articleModel);
        }
      });
    }
  }
}