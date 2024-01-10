import 'package:flutter/material.dart';
import './pages/_AllPages.dart';
import '../classes/Config.dart';
import '../classes/Utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //  (this page) variables
  static const String filename = 'main.dart';   

  @override
  Widget build(BuildContext context) {
    //  Show main page loaded in log
    Utils.log( filename, '== init "${ Config.app_name }" version ${ Config.app_version } ==' );

    return MaterialApp(
      title: 'flutt_clouds',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'Start_Page',
      //  initialRoute: 'Dummies_Page',
      routes: {
        //  start and end pages
        'Start_Page': (context) => const Start_Page(),
        'End_Page': (context) => const End_Page(),
        //  dummy pages (remove from production)
        'Dummies_Page': (context) => const Dummies_Page(),
        'Dummy1_Page': (context) => const Dummy1_Page(),
        'Dummy2_Page': (context) => const Dummy2_Page(),
        //  other pages (none yet)        
      },
    );
  }
}