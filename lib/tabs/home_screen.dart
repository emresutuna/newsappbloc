import 'package:flutter/material.dart';
import 'package:newsappbloc/widgets/headline_slider.dart';
import 'package:newsappbloc/widgets/hot_news.dart';
import 'package:newsappbloc/widgets/top_channels.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        HeadlineSliderWidget(),
        Padding(
          padding: const EdgeInsets.only(left:10.0,right: 10,top: 10),
          child: Text("Top Channels",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
        ),
        TopChannels(),
         Padding(
          padding: const EdgeInsets.only(left:10.0,right: 10,top: 10),
          child: Text("Hot News",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
        ),
        HotNews()
      ],
    );
  }
}