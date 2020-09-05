import 'package:flutter/material.dart';
import 'package:newsappbloc/bloc/bottom_navbar_bloc.dart';
import 'package:newsappbloc/screens/SearchScreen.dart';
import 'package:newsappbloc/screens/sources_screen.dart';
import 'package:newsappbloc/tabs/home_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  BottomNavBarBloc _bottomNavBarBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bottomNavBarBloc = BottomNavBarBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News App"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: StreamBuilder<NavBarItem>(
        stream: _bottomNavBarBloc.itemStream,
        initialData: _bottomNavBarBloc.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          switch (snapshot.data) {
            case NavBarItem.HOME:
              return HomeScreen();
            case NavBarItem.SEARCH:
              return SearchScreen();
            case NavBarItem.SOURCES:
              return SourceScreen();
          }
        },
      )),
      bottomNavigationBar:StreamBuilder(
        stream: _bottomNavBarBloc.itemStream,
        initialData: _bottomNavBarBloc.defaultItem,
        builder: (BuildContext context, AsyncSnapshot snapshot ){
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),topLeft:Radius.circular(30)
              ),
              boxShadow: [BoxShadow(
                color: Colors.grey
              )]
            ),
            child: ClipRRect(
              borderRadius:BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                iconSize: 20,
                unselectedItemColor: Colors.black54,
                unselectedFontSize: 9.5,
                selectedFontSize: 9.5,
                type: BottomNavigationBarType.fixed,
                fixedColor: Colors.redAccent,
                currentIndex: snapshot.data.index,
                onTap:_bottomNavBarBloc.pickItem ,
                items: [
                  BottomNavigationBarItem(icon: Icon(Icons.home),title: Padding(
                    padding: const EdgeInsets.only(top:5.0),
                    child: Text("Home"),
                  ),),
                  BottomNavigationBarItem(icon: Icon(Icons.search),title: Padding(
                    padding: const EdgeInsets.only(top:5.0),
                    child: Text("Search"),
                  ),),
                  BottomNavigationBarItem(icon: Icon(Icons.airline_seat_legroom_reduced),title: Padding(
                    padding: const EdgeInsets.only(top:5.0),
                    child: Text("Sources"),
                  ),),
                ],
              ),
            ),
          );
        },
      ) ,
    );
  }
  Widget testScreen(){
    return Container(color: Colors.white,width: MediaQuery.of(context).size.width,child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
      Text("TestScreen"),
    ],),);
  }
}
