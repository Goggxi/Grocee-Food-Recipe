import 'package:flutter/material.dart';
import 'package:grocee_food_recipe/pages/splash/splash_page.dart';
import 'package:grocee_food_recipe/stores/login_store.dart';
import 'package:provider/provider.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LoginStore>(
          create: (_) => LoginStore(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
      ),
    );
  }
}