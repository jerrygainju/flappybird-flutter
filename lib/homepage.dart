import 'dart:async';

import 'package:flappy_bird/barriers.dart';
import 'package:flappy_bird/bird.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialheight = birdYaxis;
  bool gamehasStarted = false;
   static double barrieXone = 1;
  double barrieXtwo = barrieXone + 2;

  void jump() {
    setState(() {
      time = 0;
      initialheight = birdYaxis;
    });
  }

  void startgame() {
    gamehasStarted = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.04;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialheight - height;
      });

      setState(() {
        if (barrieXone < -2)
        {
          barrieXone += 3.5;
        }else{
          barrieXone -= 0.05;
        }
      });

       setState(() {
        if (barrieXtwo < -2)
        {
          barrieXtwo += 3.5;
        }else{
          barrieXtwo -= 0.05;
        }
      });

      if (birdYaxis > 1.1) {
        timer.cancel();
        gamehasStarted = false;
      }

      if (birdYaxis == barrieXone){
        timer.cancel();
        gamehasStarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
              onTap: () {
              if (gamehasStarted) {
                jump();
              } else {
                startgame();
              }
            },
          child: Scaffold(
        body: Column(children: [
          Expanded(
            flex: 2,
            child: Stack(
            children: [
              AnimatedContainer(
                alignment: Alignment(0, birdYaxis),
                duration: Duration(milliseconds: 0),
                color: Colors.blue[400],
                child: MyBird(),
              ),
            Container(
              alignment: Alignment(0, -0.2),
              child: gamehasStarted 
              ? Text('')
              :Text('T A P  T O  P L A Y',style: TextStyle(fontSize: 20),),
            ),
            AnimatedContainer(
              alignment: Alignment(barrieXone, 1.1),
              duration: Duration(milliseconds: 0),
              child: MyBarrier(
                size: 200.0,
              ),
            ),
            AnimatedContainer(
              alignment: Alignment(barrieXone, -1.1),
              duration: Duration(milliseconds: 0),
              child: MyBarrier(
                size: 200.0,
              ),
            ),
            AnimatedContainer(
              alignment: Alignment(barrieXtwo, 1.1),
              duration: Duration(milliseconds: 0),
              child: MyBarrier(
                size: 150.0,
              ),
            ),
            AnimatedContainer(
              alignment: Alignment(barrieXtwo, -1.1),
              duration: Duration(milliseconds: 0),
              child: MyBarrier(
                size: 250.0,
              ),
            ),
            ],
            ),
          ),
          Container(
            height: 15,
            color: Colors.green[400],
          ),
          Expanded(
            child: Container(
              color: Colors.brown[300],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('SCORE', style: TextStyle(color:Colors.white,fontSize: 20),),
                    SizedBox(height:20),
                    Text('0',style: TextStyle(color:Colors.white,fontSize: 35)),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('BEST',style: TextStyle(color:Colors.white,fontSize: 20)),
                    SizedBox(height:20),
                    Text('0',style: TextStyle(color:Colors.white,fontSize: 35)),
                  ],
                ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}
