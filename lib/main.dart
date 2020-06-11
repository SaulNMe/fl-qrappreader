import 'package:flutter/material.dart';
import 'package:qrappreader/src/pages/home_page.dart';
import 'package:qrappreader/src/pages/mapa_detail_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QRReader',
      initialRoute: 'home',
      routes: {
        'mapa' : (BuildContext context) => MapaDetailPage(),
        'home' : (BuildContext context) => HomePage(),
      },
      theme: ThemeData(
        primaryColor: Colors.red[400]
      ),
    );
    
  }
}