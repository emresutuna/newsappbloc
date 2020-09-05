import 'package:flutter/material.dart';
import 'package:newsappbloc/bloc/get_source_news_bloc.dart';
import 'package:newsappbloc/bloc/get_sources_bloc.dart';
import 'package:newsappbloc/model/SourceReponse.dart';
import 'package:newsappbloc/widgets/source_details.dart';

class SourceScreen extends StatefulWidget {
  @override
  _SourceScreenState createState() => _SourceScreenState();
}

class _SourceScreenState extends State<SourceScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSourcesBloc..getSources();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SourceResponse>(
      stream: getSourcesBloc.subject.stream,
      builder: (context, AsyncSnapshot<SourceResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.status != "ok") {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return _buildSources(snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildSources(SourceResponse data) {
    List<Source> sources = data.sources;
    return GridView.builder(
        itemCount: sources.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 0.86),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: 5, right: 5, top: 10),
            child: GestureDetector(
              onTap: () {
              Navigator.push(context, MaterialPageRoute(builder:(context)=>SourceDetail(source: sources[index],) ));

              },
              child: Container(
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[100],
                          blurRadius: 5.0,
                          spreadRadius: 1.0,
                          offset: Offset(1.0, 1.0))
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: sources[index].id,
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                
                                  "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b1/CNN.svg/1200px-CNN.svg.png"),fit: BoxFit.fill),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left:10,right: 10,top:15,bottom:15),
                      child: Text(sources[index].name,style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),textAlign: TextAlign.center,),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
