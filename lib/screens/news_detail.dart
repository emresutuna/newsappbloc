import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:newsappbloc/model/Article.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetail extends StatefulWidget {
  final ArticleElement article;
  NewsDetail({Key key, @required this.article}) : super(key: key);
  @override
  _NewsDetailState createState() => _NewsDetailState(article);
}

class _NewsDetailState extends State<NewsDetail> {
  final ArticleElement article;
  _NewsDetailState(this.article);
  @override
  void initState() {
    super.initState();
    print(article.content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: () {
          launch(article.url);
        },
        child: Container(
          height: 48,
          color: Colors.redAccent,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Read More",style: TextStyle(color: Colors.white,fontSize: 15),)
            ],
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.redAccent,
        title: Text(
          article.title,
          style: TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          AspectRatio(
              aspectRatio: 16 / 9,
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/placeholder.jpg',
                image: article.urlToImage==null?"https://via.placeholder.com/350x150":article.urlToImage,
                fit: BoxFit.cover,
              )),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(height: 10),
                Text(article.publishedAt.toString().substring(0, 10),
                    style: TextStyle(
                        color: Colors.redAccent, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                Text(
                  article.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                Html(data: article.content==null?"":article.content),
              ],
            ),
          )
        ],
      ),
    );
  }
}
