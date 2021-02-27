import 'package:flutter/material.dart';
import 'package:news_app/models/articleModel.dart';
import 'package:news_app/helper/news.dart';

import 'article_view.dart';
class CategoryNews extends StatefulWidget {
  final String category;

  const CategoryNews({Key key, this.category}) : super(key: key);
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> articles=new List<ArticleModel>();
  bool loading=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews();
  }

  getNews() async{
    CategoryNewsClass news=new CategoryNewsClass();
    await news.getNews(widget.category);
    articles=news.news;
    setState(() {
      loading=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Flutter"),
            Text("News",style: TextStyle(color: Colors.blue),)
          ],
        ),
        elevation: 0.0,
      ),
      body: loading?Container(child: Center(child: CircularProgressIndicator()),):Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.only(top: 16.0),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: articles.length,
                    itemBuilder: (context,index){
                      return BlogTile(imageUrl: articles[index].urlToImage,description: articles[index].description,
                        title: articles[index].title,url: articles[index].url,);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl,title,description,url;

  const BlogTile({Key key, this.imageUrl, this.title, this.description, this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (c){
          return ArticleView(url: url);
        }));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.0),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(imageUrl)),
            SizedBox(height: 8,),
            Text(title,style: TextStyle(
                fontSize: 18.0,
                color: Colors.black87,
                fontWeight: FontWeight.w500
            ),),
            SizedBox(height: 8,),
            Text(description,style: TextStyle(
                color: Colors.black54
            ),),
          ],
        ),
      ),
    );
  }
}