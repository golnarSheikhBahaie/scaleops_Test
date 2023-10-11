import 'package:flutter/material.dart';

import '../util/action/check_collision.dart';
import '../util/action/move_object.dart';
import '../util/object/object_type.dart';
import '../util/object/random_object.dart';

//todo add reset btn

class MainGameScreen extends StatefulWidget {
  const MainGameScreen({Key? key}) : super(key: key);

  @override
  State<MainGameScreen> createState() => _MainGameScreenState();
}

class _MainGameScreenState extends State<MainGameScreen>
    with TickerProviderStateMixin {
  List<RandomObject> randomObj = [];

  final int numOfObjects = 15;
  final double objectSize = 80.0;
  final double objectSpeed = 0.3;
  AnimationController? controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeObjects();
    startAnimating();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller!.dispose();
    super.dispose();
  }

  void resetGame() {
    randomObj.clear();
    initializeObjects();
    startAnimating();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: const Text('ScaleOps Test Task'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
          child: Container(
            color: Colors.white,
            child: Stack(
              children: [
                for (RandomObject obj in randomObj)
                  Positioned(
                      left: obj.position.dx,
                      top: obj.position.dy,
                      //todo create custom container
                      child: Container(
                        width: obj.objectSize,
                        height: obj.objectSize,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            color: obj.objectType == ObjectType.rock
                                ? Colors.grey[400]
                                : obj.objectType == ObjectType.paper
                                    ? Colors.lightBlue
                                    : Colors.green),
                        child: Center(
                          child: Text(
                            obj.objectType.toString().split('.').last,
                            style: TextStyle(
                                color: obj.objectType == ObjectType.rock
                                    ? Colors.grey[800]
                                    : obj.objectType == ObjectType.paper
                                        ? Colors.lightBlue[900]
                                        : Colors.green[900],
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ))
              ],
            ),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              backgroundColor: Colors.blue,
              onPressed: () {
                resetGame();
              },
              child: const Icon(Icons.repeat_rounded),
            ),
          ],
        ));
  }

  void initializeObjects() {
    for (int i = 0; i < numOfObjects; i++) {
      randomObj.add(
        RandomObject(
          objectSize: objectSize,
          objectType: ObjectType.rock,
          objectSpeed: objectSpeed,
        ),
      );
    }

    for (int i = 0; i < numOfObjects; i++) {
      randomObj.add(
        RandomObject(
          objectSize: objectSize,
          objectType: ObjectType.paper,
          objectSpeed: objectSpeed,
        ),
      );
    }

    // Create 5 scissors
    for (int i = 0; i < numOfObjects; i++) {
      randomObj.add(
        RandomObject(
          objectSize: objectSize,
          objectType: ObjectType.scissor,
          objectSpeed: objectSpeed,
        ),
      );
    }
  }

  void startAnimating() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(days: 2),
    );

    controller!.addListener(() {
      setState(() {
        moveObjects(context, randomObj);
        checkCollisions(randomObj);
      });
    });
    controller!.repeat();
  }
}
