
import '../notifiers/themeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'loginHomePage.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>ThemeNotifier()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E-Commerce',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
       // home:CarouselDemo(),
        home: LoginHomePage(),
      //  home: ViewProductDetails(),
      ),
    );
  }
}


