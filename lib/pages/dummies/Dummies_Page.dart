// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import '../../classes/Config.dart';
import '../../classes/Utils.dart';

class Dummies_Page extends StatelessWidget {
  const Dummies_Page({super.key});

  //  (this page) variables
  static const String filename = 'Dummies_Page.dart';  

  // (this page) methods
  void _buildTriggered() {
    Utils.log( filename, '_buildTriggered()');
  }  

  Padding _makeRow( BuildContext context, label, String desc, String page) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15,15,0,0),
      child: Row(
        children: [
          Expanded(flex: 2, child: ElevatedButton(
            child: Text( label ),
              onPressed: () async { Navigator.of(context).pushNamed( page ); },
            )),
          Expanded(flex: 5, child: Padding(
            padding: const EdgeInsets.fromLTRB(25,0,0,0),
            child: Text( desc ),
          )),
        ],
      ),     
    );
  }

  @override
  Widget build(BuildContext context) {

    _buildTriggered();

    return WillPopScope(
      onWillPop: () async {
        //  is back button allowed? (true means yes!)       
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,  
          //  backgroundColor: Config.main_background_color,
          appBar: AppBar(
            title: const Text( 'Dummy Page Index' ),
            centerTitle: true,
          ), 
          //  drawer: Drawer_Widget(),
          body: Container(
              color: Colors.transparent,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _makeRow( context, 'Start_Page', '~ the App ~', 'Start_Page' ),
                    _makeRow( context, 'Dummy1', 'stateless page example', 'Dummy1_Page' ),
                    _makeRow( context, 'Dummy2', 'statefull page example', 'Dummy2_Page' ),
                    const SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ),
            ),
        ),
      ),
    );
  }
}