import 'package:flutter/material.dart';
import 'package:newsappbloc/bloc/get_hot_news_bloc.dart';
import 'package:newsappbloc/model/Article.dart';
import 'package:newsappbloc/screens/news_detail.dart';
import 'package:timeago/timeago.dart' as timeago;

class HotNews extends StatefulWidget {
  @override
  _HotNewsState createState() => _HotNewsState();
}

class _HotNewsState extends State<HotNews> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHotNewsBloc..getHotNews();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Article>(
      stream: getHotNewsBloc.subject.stream,
      builder: (context, AsyncSnapshot<Article> snapshot) {
        if (snapshot.hasData) {
          return _buildHotNews(snapshot.data);
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
    );
  }

  Widget _buildHotNews(Article data) {
    List<ArticleElement> articles = data.articles;
    if (articles.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [Text("Haber yok")],
        ),
      );
    }
    return Container(
      height: articles.length / 2 * 210,
      padding: EdgeInsets.all(10.0),
      child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: articles.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.85),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 10),
              child: GestureDetector(
                onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder:(context)=>NewsDetail(article: articles[index],) ));

                },
                child: Container(
                  width: 220,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[100],
                            blurRadius: 5.0,
                            spreadRadius: 1.0,
                            offset: Offset(1.0, 1.0))
                      ]),
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5.0),
                                topRight: Radius.circular(5.0),
                              ),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    articles[index].urlToImage,
                                  ),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 15, bottom: 15),
                        child: Text(
                          articles[index].title,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(height: 1.3, fontSize: 14),
                        ),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            width: 180,
                            height: 1,
                            color: Colors.black12,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 0.0),
                            child: Container(
                              width: 30.0,
                              height: 3.0,
                              color: Colors.redAccent,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              articles[index].source.name,
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              timeAgo(DateTime.parse(
                                  articles[index].publishedAt.toString())),
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  String timeAgo(DateTime date) {
    return timeago.format(date, allowFromNow: true, locale: 'tr');
  }
}
