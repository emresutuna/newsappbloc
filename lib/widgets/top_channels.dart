import 'package:flutter/material.dart';
import 'package:newsappbloc/bloc/get_sources_bloc.dart';
import 'package:newsappbloc/model/SourceReponse.dart';
import 'package:newsappbloc/widgets/source_details.dart';

class TopChannels extends StatefulWidget {
  @override
  _TopChannelsState createState() => _TopChannelsState();
}

class _TopChannelsState extends State<TopChannels> {
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
              child: Text("Error"),
            );
          }
          return _buildTopChannels(snapshot.data);
        } else {
          return Center(
            child: Text("Error"),
          );
        }
      },
    );
  }

  Widget _buildTopChannels(SourceResponse data) {
    List<Source> sources = data.sources;
    if (sources.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [Text("Kaynak yok")],
        ),
      );
    } else {
      return Container(
        height: 150,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: sources.length,
            itemBuilder: (context, index) {
              return Container(
                width: 80,
                padding: EdgeInsets.only(top: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder:(context)=>SourceDetail(source: sources[index],) ));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Hero(
                        tag: sources[index].id,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                    spreadRadius: 1.0,
                                    offset: Offset(1.0, 1.0))
                              ],
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b1/CNN.svg/1200px-CNN.svg.png"))),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        sources[index].name,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            height: 1.4,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 15),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        sources[index].category,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            height: 1.4,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ),
              );
            }),
      );
    }
  }
}
