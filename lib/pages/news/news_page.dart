import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocee_food_recipe/theme.dart';
import 'package:grocee_food_recipe/widgets/item_news.dart';
import 'package:http/http.dart' as http;
import 'package:grocee_food_recipe/model/news_model.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  Future<List<Articles>> fetchDataNews() async {
    List<Articles> data = [];
    String url = 'https://newsapi.org/v2/everything?q=culinary food&apiKey=cc6254a47eb84d08bced16c2348829e3';

    var response = await http.get(url);

    if(response.statusCode == 200){
      Map json = jsonDecode(response.body);
      NewsModel dataNews = NewsModel.fromJson(json);
      dataNews.articles.forEach((element) {
        data.add(element);
      });
      return data;
    } else {
      throw Exception('filed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.primaryColor,
          title: Text('Berita'),
        ),
        body: FutureBuilder(
          future: fetchDataNews(),
          builder: (BuildContext context, AsyncSnapshot<List<Articles>> snapshot) {
            if(snapshot.hasData){
              List<Articles> listNews = snapshot.data;

              return ListView.builder(
                  itemCount: listNews?.length ?? 0,
                  itemBuilder: (BuildContext context, int index){
                    var item = listNews[index];
                    return InkWell(
                      splashColor: MyColors.primaryColor,
                      child: itemNews(
                          item.title,
                          item.urlToImage,
                          item.publishedAt
                      ),
                      // onTap: () {
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) =>
                      //               DetailNewsPage(keyRecipes: itemRecipe.key)));
                      // },
                    );
                  }
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
    );
  }
}


