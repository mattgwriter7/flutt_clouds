// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import '../classes/Config.dart';
import '../classes/Meadow.dart';
import '../classes/Utils.dart';

class Meadow_Page extends StatefulWidget {
  const Meadow_Page({ super.key });

  @override
  State createState() => _Meadow_PageState();
}

class _Meadow_PageState extends State<Meadow_Page> with TickerProviderStateMixin {

  _Meadow_PageState() {
    Utils.log( 'Meadow_Page.dart', 'init' );
  }

  // (this page) variables
  static const String filename = 'Meadow_Page.dart';
  //  set up first cloud set
  late AnimationController cloudset_1_controller;     //  it needs an animation controller
  final double  cloudset_1_left_max = 1000;           //  the maximum size of the loop (which is half of the width of the cloud image)
  double        cloudset_1_left_current = 1000;       //  the current position of the loop
  final int cloudset_1_loop_duration  = 20000;        //  how long in ms is animaion loop? 

  //  set up second cloud set
  late AnimationController cloudset_2_controller;     //   
  final double  cloudset_2_left_max = 1000;           //   
  double        cloudset_2_left_current = 1000;       //   
  final int cloudset_2_loop_duration  = 30000;        //   

  // (this page) init and dispose
  @override
  void initState() {
    super.initState();
    Utils.log( filename, 'initState()' );
    WidgetsBinding.instance.addPostFrameCallback((_) => _addPostFrameCallbackTriggered(context));

    //  START: FIRST CLOUDSET LOGIC
    cloudset_1_controller = AnimationController(
      duration: Duration( milliseconds: cloudset_1_loop_duration ), // 
      vsync: this, 
    );
    cloudset_1_controller.forward();     //  this sets the clouds into motion

    cloudset_1_controller.addListener(() {
      //  it needs a listener to update the cloud position based on
      //  the ticker value
      setState(() {
        cloudset_1_left_current = 0 - (cloudset_1_left_max * cloudset_1_controller.value);
      });
      //  Utils.log( filename, cloudset_1_controller.value.toString() );
    });

    cloudset_1_controller.addStatusListener((status) {
      //  it needs a status listener to repeat after complete  
      if (status == AnimationStatus.completed) { cloudset_1_controller.repeat(); }
    });    
    //  END: FIRST CLOUDSET LOGIC

    //  START: SECOND CLOUDSET LOGIC
    cloudset_2_controller = AnimationController(
      duration: Duration( milliseconds: cloudset_2_loop_duration ), // 
      vsync: this, 
    );
    cloudset_2_controller.forward();     //  this sets the clouds into motion

    cloudset_2_controller.addListener(() {
      //  it needs a listener to update the cloud position based on
      //  the ticker value
      setState(() {
        cloudset_2_left_current = 0 - (cloudset_2_left_max * cloudset_2_controller.value);
      });
      //  Utils.log( filename, cloudset_1_controller.value.toString() );
    });

    cloudset_2_controller.addStatusListener((status) {
      //  it needs a status listener to repeat after complete  
      if (status == AnimationStatus.completed) { cloudset_2_controller.repeat(); }
    });    
    //  END: FIRST CLOUDSET LOGIC    

  }

  @override
  void dispose() {
    Utils.log( filename, ' dispose()');
    cloudset_1_controller.dispose();
    super.dispose();
  }

  // (this page) methods
  void _buildTriggered() {
    //  Utils.log( filename, ' _buildTriggered()');
  }

Positioned kittyCat( int num ) {

    double sizer = 1;
    if( Config.window_height < 999) sizer = .55;
    //  Lenovo  Tablet: 800 x 1272
    //  Nexus 6:        411 x 683
    //  Galaxy S22      360 x 732

    //  WILLFIX:  these need to be DIFFERENT cats
    //            right now, only Cat 3 is used (0.22x0.19)
    //                           0      1     2     3     4   
    List<double> x =      [    0.8,  0.60, 0.5, 0.20, 0.08 ];
    List<double> y =      [   0.15,  0.21, 0.26, 0.17, 0.06 ];
    List<String> sprite = [    '02', '01', '02', '01', '03' ];
    
    return Positioned(
      right: MediaQuery.of(context).size.width * x[num],
      bottom: MediaQuery.of(context).size.height * y[num],
      child: Tooltip(
        message: 'Itty-Bitty',
        child: Container(
          width: 90*sizer,
          height: 90*sizer,
          // height: double.infinity,
          decoration: BoxDecoration(
          image: DecorationImage(
            image:
              AssetImage( Meadow.cat[ num ] ),
              fit: BoxFit.cover,
              //alignment: Alignment.center,
            ),
          ),   
        ),
      ),
    );
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
            extendBodyBehindAppBar: true,
            
            appBar: AppBar(
              title: const Text( '' ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.black,
            ),
            body: Stack(
              children: [


                // ****************************
                // SKY
                // ****************************          
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                      colors: [Colors.lightBlueAccent, Colors.blue],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      ),
                  ),   
                ),  



                // **************************************
                // CLOUDSSET 2 (Whitest, Top most clouds)
                // **************************************          
                Positioned(
                  left: cloudset_2_left_current,
                  top: 0,
                  child: Image.asset('./assets/images/meadow/cloudset_medium.png'),
                ),

                // **************************************
                // CLOUDSSET 1 (Whitest, Top most clouds)
                // **************************************          
                Positioned(
                  left: cloudset_1_left_current,
                  top: 0,
                  child: Image.asset('./assets/images/meadow/cloudset_top.png'),
                ),
                    






                // ****************************
                // RAINBOW
                // ****************************          
                Visibility(
                  visible: true,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                        AssetImage('./assets/images/meadow/rainbow_01.png'),
                        fit: BoxFit.cover,
                        //alignment: Alignment.center,
                      ),
                    ),   
                  ),
                ),  




                // ****************************
                // GRASS
                // ****************************          
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                      AssetImage('./assets/images/meadow/grass_01.png'),
                      fit: BoxFit.fitHeight,
                      //alignment: Alignment.center,
                    ),
                  ),   
                ),  



                // ****************************
                // TREE
                // ****************************          
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                      AssetImage('./assets/images/meadow/tree_01.png'),
                      fit: BoxFit.cover,
                      //alignment: Alignment.center,
                    ),
                  ),   
                ),  



                // ****************************
                // APPLES
                // ****************************          
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                      AssetImage( './assets/images/meadow/fruits_none.png' ),
                      fit: BoxFit.cover,
                      //alignment: Alignment.center,
                    ),
                  ),   
                ),  




                // ****************************
                // GIRL
                // ****************************          
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                      AssetImage('./assets/images/meadow/clem_01.png'),
                      fit: BoxFit.cover,
                      //alignment: Alignment.center,
                    ),
                  ),   
                ),  



                // ****************************
                // CAT
                // ****************************      
                /*    
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                      AssetImage('./assets/images/meadow/cat_01.png'),
                      fit: BoxFit.cover,
                      //alignment: Alignment.center,
                    ),
                  ),   
                ), 
                */


                // ****************************
                // TITLE
                // ****************************          
                Visibility(
                  visible: false,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                        AssetImage('./assets/images/meadow/title_01.png'),
                        fit: BoxFit.cover,
                        //alignment: Alignment.center,
                      ),
                    ),   
                  ),
                ), 


                //  WILLFIX: Title Was Here!





                // ****************************
                // CAT SPRITES
                // ****************************          
                kittyCat(0), 
                kittyCat(1), 
                kittyCat(2), 
                kittyCat(3), 
                kittyCat(4),



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