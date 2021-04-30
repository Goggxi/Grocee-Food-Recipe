import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocee_food_recipe/stores/login_store.dart';
import 'package:provider/provider.dart';

import '../../theme.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key key}) : super(key: key);
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginStore>(
      builder: (_, loginStore, __) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: MyColors.primaryColor,
            title: Text('Tentang'),
          ),
          backgroundColor: Colors.white,
          body: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: RaisedButton(
                onPressed: () {
                  loginStore.signOut(context);
                },
                color: MyColors.primaryColor,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14))
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Sign Out', style: TextStyle(color: Colors.white),),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          color: MyColors.primaryColorLight,
                        ),
                        child: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16,),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
