import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/articleModel.dart';
import 'package:news_app/models/categoryModel.dart';
import 'package:news_app/views/article_view.dart';

import 'category_news.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CategoryModel> categories=new List<CategoryModel>();
  List<ArticleModel> articles=new List<ArticleModel>();
  bool loading=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories=getCategories();
    getNews();
  }

  getNews() async{
    News news=new News();
    await news.getNews();
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
      body: loading? Container(
        child: Center(child: CircularProgressIndicator()),
      ):Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ///Categories
              Container(
                height: 70.0,
                child: ListView.builder(
                    itemCount: categories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                      return CategoryTile(
                        imageUrl: categories[index].imageAssetUrl,
                        categoryName: categories[index].categoryName,
                      );
                    }),
              ),
              ///Blogs
              Container(
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



class CategoryTile extends StatelessWidget {
  final String imageUrl,categoryName;

  const CategoryTile({Key key, this.imageUrl, this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return CategoryNews(category: categoryName,);
        }));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16.0),
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl:imageUrl,width: 120.0,height: 60.0,fit: BoxFit.cover,)
            ),
            Container(
              width: 120.0,height: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26
              ),
              child: Center(child: Text(categoryName,style: TextStyle(color: Colors.white,fontSize: 14.0,fontWeight: FontWeight.w500),)),
            )
          ],
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

