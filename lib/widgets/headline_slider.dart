import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:newsappbloc/bloc/get_top_headlines_bloc.dart';
import 'package:newsappbloc/model/Article.dart';
import 'package:newsappbloc/screens/news_detail.dart';
import 'package:timeago/timeago.dart' as timeago;

class HeadlineSliderWidget extends StatefulWidget {
  @override
  _HeadlineSliderWidgetState createState() => _HeadlineSliderWidgetState();
}

class _HeadlineSliderWidgetState extends State<HeadlineSliderWidget> {
  @override
  void initState() {
    super.initState();
    getTopHeadlinesBloc..getHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Article>(
      stream: getTopHeadlinesBloc.subject.stream,
      builder: (context, AsyncSnapshot<Article> snapshot) {
        if (snapshot.hasData) {
          return _buildHeadLineSlider(snapshot.data);
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

  Widget _buildHeadLineSlider(Article data) {
    List<ArticleElement> articles = data.articles;
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          enlargeCenterPage: false,
          height: 200,
          viewportFraction: 0.9,
        ),
        items: getExpenseSliders(articles),
      ),
    );
  }

  getExpenseSliders(List<ArticleElement> articles) {
    return articles
        .map((article) => GestureDetector(
              onTap: () {
          Navigator.push(context, MaterialPageRoute(builder:(context)=>NewsDetail(article: article,) ));

              },
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 5, right: 5, bottom: 5),
                child: Container(
                  padding:
                      EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                          image: NetworkImage(article.urlToImage == null
                              ? ""
                              : article.urlToImage),
                          fit: BoxFit.cover)),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(article.urlToImage == null
                                  ? ""
                                  : article.urlToImage),
                            )),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                stops: [
                                  0.1,
                                  0.9
                                ],
                                colors: [
                                  Colors.black.withOpacity(0.9),
                                  Colors.white.withOpacity(0.0)
                                ])),
                      ),
                      Positioned(
                        bottom: 30,
                        child: Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          width: 250,
                          child: Column(
                            children: [
                              Text(
                                article.title,
                                style: TextStyle(
                                    height: 1.5,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        left: 10,
                        child: Text(
                          article.source.name,
                          style: TextStyle(
                              color: Colors.white60,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        right: 10,
                        child: Text(
                          timeAgo(
                              DateTime.parse(article.publishedAt.toString())),
                          style: TextStyle(color: Colors.white54, fontSize: 14),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ))
        .toList();
  }

  String timeAgo(DateTime date) {
    return timeago.format(date, allowFromNow: true, locale: 'tr');
  }
}
