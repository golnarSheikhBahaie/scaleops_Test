import 'package:flutter/material.dart';

import '../util/calculate/move_object.dart';
import '../util/object/object_type.dart';
import '../util/object/random_object.dart';

class MainGameScreen extends StatefulWidget {
  const MainGameScreen({Key? key}) : super(key: key);

  @override
  State<MainGameScreen> createState() => _MainGameScreenState();
}

class _MainGameScreenState extends State<MainGameScreen>
    with TickerProviderStateMixin {
  List<RandomObject> randomObj = [];

  final int numOfObjects = 5;
  final double objectSize = 80.0;
  final double objectSpeed = 2.0;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ScaleOps Test Task'),
      ),
      body: Container(
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
                    color: obj.objectType == ObjectType.rock
                        ? Colors.grey[400]
                        : obj.objectType == ObjectType.paper
                            ? Colors.lightBlue
                            : Colors.green,
                    child: Text(
                      obj.objectType.toString().split('.').last,
                      style: const TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                  ))
          ],
        ),
      ),
    );
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
      duration: Duration(minutes: 1),
      // duration: Duration(minutes:   1)
    );

    controller!.addListener(() {
      setState(() {
        moveObjects(context, randomObj);
        // checkCollisions();
      });
    });
    controller!.repeat();
  }
}
