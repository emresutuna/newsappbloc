import 'package:flutter/material.dart';
import 'package:newsappbloc/bloc/get_source_news_bloc.dart';
import 'package:newsappbloc/model/Article.dart';
import 'package:newsappbloc/model/SourceReponse.dart';
import 'package:newsappbloc/screens/news_detail.dart';
import 'package:timeago/timeago.dart' as timeago;

class SourceDetail extends StatefulWidget {
  final Source source;
  SourceDetail({Key key, @required this.source}) : super(key: key);
  @override
  _SourceDetailState createState() => _SourceDetailState(this.source);
}

class _SourceDetailState extends State<SourceDetail> {
  final Source source;
  _SourceDetailState(this.source);
  @override
  void initState() {
    super.initState();
    getSourceNewsBloc..GetSourceNews(source.id);
  }

  @override
  void dispose() {
    super.dispose();
    getSourceNewsBloc..drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text(""),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
            color: Colors.redAccent,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Hero(
                    tag: source.id,
                    child: SizedBox(
                      height: 80,
                      width: 80,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 2.0, color: Colors.white),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b1/CNN.svg/1200px-CNN.svg.png"))),
                      ),
                    )),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  source.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5.0),
                Text(
                  source.description,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<Article>(
              stream: getSourceNewsBloc.subject.stream,
              builder: (context, AsyncSnapshot<Article> snapshot) {
                if (snapshot.hasData) {
                  return _buildSourceNews(snapshot.data);
                } else if (snapshot.hasError) {
                  return Container(
                    child: Text("Error"),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSourceNews(Article data) {
    List<ArticleElement> articles = data.articles;
    if (articles.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text("Haber yok.")],
        ),
      );
    } else {
      return ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder:(context)=>NewsDetail(article: articles[index],) ));

              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        top: BorderSide(color: Colors.grey[200], width: 1.0))),
                height: 150,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 3 / 5,
                      child: Column(
                        children: [
                          Text(
                            articles[index].title,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          Expanded(
                              child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Row(
                              children: [
                                Text(
                                    timeAgo(DateTime.parse(articles[index]
                                        .publishedAt
                                        .toString())),
                                    style: TextStyle(
                                        color: Colors.black26,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10)),
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      width: MediaQuery.of(context).size.width * 2 / 5,
                      height: 130,
                      child:  FadeInImage.assetNetwork(
                        placeholder: "assets/placeholder.jpg",
                        image: articles[index].urlToImage==null?"https://via.placeholder.com/350x150":articles[index].urlToImage,
                        fit: BoxFit.cover,
                        width: double.maxFinite,
                        height: MediaQuery.of(context).size.height*1/3,
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    }
  }

  String timeAgo(DateTime date) {
    return timeago.format(date, allowFromNow: true, locale: 'tr');
  }
}
