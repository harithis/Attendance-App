import 'package:attendance_list_app/home.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
//import on board me dependency 

class onBoardingPage extends StatefulWidget{
  const onBoardingPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _onBoardingPage();
  }

}

class _onBoardingPage extends State<onBoardingPage>{

  @override
  Widget build(BuildContext context) {

    //this is a page decoration for intro screen
    PageDecoration pageDecoration = const PageDecoration(
          titleTextStyle: TextStyle(fontSize: 28.0, 
                    fontWeight: FontWeight.w700, 
                    color:Colors.white 
                  ), //tile font size, weight and color
          bodyTextStyle:TextStyle(fontSize: 19.0, color:Colors.white), 
          //body text size and color
          //decription padding
          imagePadding: EdgeInsets.all(20), //image padding
          boxDecoration:BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0.1, 0.5, 0.7, 0.9],
                  colors: [
                    Colors.white,
                    Colors.lightBlue,
                    Colors.lightBlueAccent,
                    Colors.blue,
                  ],
            ),
          ), //show linear gradient background of page  
    );

    return IntroductionScreen(
          globalBackgroundColor: Colors.deepPurple,
          //main background of screen
          pages: [ 
            PageViewModel(
              title: "View",
              body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
              image: introImage('assets/onboard1bg.png'),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Share",
              body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
              image: introImage('assets/onboard2bg.png'),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Many more!",
              body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
              image: introImage('assets/onboard3bg.png'),
              decoration: pageDecoration,
            ),

          ],

          onDone: () => goHomepage(context), //go to home page on done
          onSkip: () => goHomepage(context), // You can override on skip 
          showSkipButton: true,
          skipOrBackFlex: 0,
          nextFlex: 0,
          skip: const Text('Skip', style: TextStyle(color: Colors.white),),
          next: const Icon(Icons.arrow_forward, color: Colors.white,),
          done: const Text('Getting Started', style: TextStyle(
               fontWeight: FontWeight.w600, color:Colors.white
              ),),
          dotsDecorator: const DotsDecorator(
            size: Size(10.0, 10.0), //size of dots
            color: Colors.white, //color of dots
            activeSize: Size(22.0, 10.0),
            //activeColor: Colors.white, //color of active dot
            activeShape: RoundedRectangleBorder( //shave of active dot
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
        );
  }

  void goHomepage(context){
     Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context){ 
           return const HomePage();
        }
    ), (Route<dynamic> route) => false);
    //Navigate to home page and remove the intro screen history
    //so that "Back" button wont work.
  }

  Widget introImage(String assetName) {
  //widget to show intro image
    return Align(
      alignment: Alignment.bottomCenter,
      child: Image.asset(assetName, width: 350.0),
    );
  }
}