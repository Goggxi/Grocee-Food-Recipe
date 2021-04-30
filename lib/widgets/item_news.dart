import 'package:flutter/material.dart';

Widget itemNews(String title, String urlToImage, String publishedAt) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Hero(
            child: Image.network(
              urlToImage,
              height: 220.0,
              width: double.maxFinite,
              fit: BoxFit.fill,
              // width: double.infinity,
            ),
            tag: title
          ),
        ),
        Positioned(
          width: 320,
          left: 10.0,
          bottom: 40.0,
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
                shadows: [
                  Shadow(
                    offset: Offset(2.0, 2.0),
                    blurRadius: 2.0,
                    color: Colors.black,
                  ),
                ]),
          ),
        ),
        Positioned(
          left: 10.0,
          bottom: 15.0,
          child: Text(
            'Published : ',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                shadows: [
                  Shadow(
                    offset: Offset(2.0, 2.0),
                    blurRadius: 2.0,
                    color: Colors.black,
                  ),
                ]),
          ),
        ),
        Positioned(
          left: 80.0,
          bottom: 15.0,
          child: Text(
            publishedAt,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                shadows: [
                  Shadow(
                    offset: Offset(2.0, 2.0),
                    blurRadius: 2.0,
                    color: Colors.black,
                  ),
                ]),
          ),
        ),
      ],
    ),
  );
}