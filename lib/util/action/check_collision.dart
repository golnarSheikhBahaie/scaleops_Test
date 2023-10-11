import '../object/object_type.dart';
import '../object/random_object.dart';
import 'package:flutter/material.dart';

void checkCollisions(List<RandomObject> randomObj) {
  for (int i = 0; i < randomObj.length; i++) {
    for (int j = i + 1; j < randomObj.length; j++) {
      RandomObject objA = randomObj[i];
      RandomObject objB = randomObj[j];

      if (objA.position.dx < objB.position.dx + objB.objectSize &&
          objA.position.dx + objA.objectSize > objB.position.dx &&
          objA.position.dy < objB.position.dy + objB.objectSize &&
          objA.position.dy + objA.objectSize > objB.position.dy) {
        if (objA.objectType == objB.objectType) {
          objA.direction = Offset(-objA.direction.dx, -objA.direction.dy);
          objB.direction = Offset(-objB.direction.dx, -objB.direction.dy);
        } else {
          if (objA.objectType == ObjectType.rock &&
                  objB.objectType == ObjectType.scissor ||
              objA.objectType == ObjectType.paper &&
                  objB.objectType == ObjectType.rock ||
              objA.objectType == ObjectType.scissor &&
                  objB.objectType == ObjectType.paper) {
            randomObj.remove(objB);
            objA.direction = Offset(-objA.direction.dx, -objA.direction.dy);
          } else {
            randomObj.remove(objA);
            objB.direction = Offset(-objB.direction.dx, -objB.direction.dy);
          }
        }
      }
    }
  }
}
