import 'package:flutter/material.dart';
import 'package:newsappbloc/bloc/search_bloc.dart';
import 'package:newsappbloc/model/Article.dart';
import 'package:newsappbloc/screens/news_detail.dart';
import 'package:timeago/timeago.dart' as timeago;

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    searchBloc..search("");
  }

  var isSearch = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
            onChanged: (changed) {
              searchBloc..search(_searchController.text);
             
            },
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              fillColor: Colors.grey[100],
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.grey[100].withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(30)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.grey[100].withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(30)),
              contentPadding: EdgeInsets.only(
                left: 15,
                right: 10,
              ),
              labelText: "Search...",
              labelStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500),
              hintStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.black38,
                  fontWeight: FontWeight.w500),
              suffix: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(
                        Icons.backspace,
                      ),
                      onPressed: () {
                        setState(() {
                          FocusScope.of(context).requestFocus(FocusNode());
                          _searchController.clear();
                          searchBloc..search(_searchController.text);
                        });
                      },
                    )
                  : Icon(
                      Icons.search,
                      color: Colors.grey[500],
                      size: 16,
                    ),
            ),
            autocorrect: false,
            style: TextStyle(fontSize: 14.0, color: Colors.black),
            controller: _searchController,
            autovalidate: true,
          ),
        ),
        Expanded(
          child: StreamBuilder<Article>(
            stream: searchBloc.subject.stream,
            builder: (context, AsyncSnapshot<Article> snapshot) {
              if (snapshot.hasData) {
                return _buildSearchedNews(snapshot.data);
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
        ),
      ],
    );
  }

  Widget _buildSearchedNews(Article data) {
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewsDetail(
                              article: articles[index],
                            )));
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
                      child: FadeInImage.assetNetwork(
                        placeholder: "assets/placeholder.jpg",
                        image: articles[index].urlToImage == null
                            ? "https://via.placeholder.com/350x150"
                            : articles[index].urlToImage,
                        fit: BoxFit.cover,
                        width: double.maxFinite,
                        height: MediaQuery.of(context).size.height * 1 / 3,
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
