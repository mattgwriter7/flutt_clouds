// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import '../classes/Config.dart';
import '../classes/Utils.dart';

class Start_Page extends StatefulWidget {
  const Start_Page({ super.key });

  @override
  State createState() => _Start_PageState();
}

class _Start_PageState extends State<Start_Page> {

  _Start_PageState() {
    Utils.log( 'Start_Page.dart', 'init' );
  }

  // (this page) variables
  static const String filename = 'Start_Page.dart';
  
  // (this page) init and dispose
  @override
  void initState() {
    super.initState();
    Utils.log( filename, 'initState()' );
    WidgetsBinding.instance.addPostFrameCallback((_) => _addPostFrameCallbackTriggered(context));
  }

  @override
  void dispose() {
    Utils.log( filename, ' dispose()');
    super.dispose();
  }

  // (this page) methods
  void _buildTriggered() {
    Utils.log( filename, ' _buildTriggered()');
  }
  
  void _addPostFrameCallbackTriggered( context ) {
    Utils.log( filename, ' _addPostFrameCallbackTriggered()');
  }

  // (this page) build
  @override
  Widget build(BuildContext context) {

    _buildTriggered();

    return WillPopScope(
      onWillPop: () async {
        return true;  //  this allows the back button to work
      },
      child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,  
            appBar: AppBar(
              title: const Text( filename ),
              centerTitle: true,
            ), //AppBar
            // drawer: Drawer_Widget(),
            body: Stack(
              children: [
                Container(
                  color: Colors.transparent,
                  child: Center(
                    child: ElevatedButton(
                      child: Text( 'End_Page() >>' ),
                      onPressed: () {
                        Utils.log( filename, 'go to End_Page()');
                        Future.delayed( Duration(milliseconds: Config.short_delay ), () async {
                          Navigator.of(context).pushNamed('End_Page');         
                          return;
                        }); 
                      },
                    ),  
                  ),
                ),

                //  version number
                Positioned(
                  left: 10,
                  bottom: 10,
                  child: GestureDetector(
                    child: Text( Config.app_version ),
                    onLongPress: () {
                      Utils.log( filename, 'go to Dummies_Page()');
                      Future.delayed( Duration(milliseconds: Config.short_delay ), () async {
                        Navigator.of(context).pushNamed('Dummies_Page');         
                        return;
                      }); 
                    },
                  ),
                ),


              ],  
            ),
          ),
        ),
    );
  }
}