import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocee_food_recipe/pages/about/about_page.dart';
import 'package:grocee_food_recipe/pages/home/home_page.dart';
import 'package:grocee_food_recipe/pages/news/news_page.dart';
import 'package:grocee_food_recipe/theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //State class
  int pageIndex = 0;

  //All the Pages
  final HomePage _homePage = HomePage();
  final NewsPage _newsPage = NewsPage();
  final AboutPage _aboutPage = new AboutPage();

  Widget _showPage = new HomePage();

  Widget _pageChooser(int page){
    switch(page){
      case 0 :
        return _homePage;
        break;
      case 1 :
        return _newsPage;
        break;
      case 2 :
        return _aboutPage;
        break;
      default:
        return new Container(
          child: new Center(
            child: Text('Page Not Found'),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // extendBody: true,
        body: Container(
          child: Center(
            child: _showPage,
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          items: <Widget>[
            Icon(CupertinoIcons.home, size: 30, color: Colors.white),
            Icon(CupertinoIcons.news, size: 30, color: Colors.white),
            Icon(CupertinoIcons.exclamationmark_square, size: 30, color: Colors.white),
          ],
          animationDuration: Duration(milliseconds: 120),
          color: MyColors.primaryColor,
          height: 50,
          backgroundColor: Colors.transparent,
          onTap: (int tap) {
            setState(() {
              _showPage = _pageChooser(tap);
            });
          },
        ),
    );
  }
}
