import 'package:flutter/material.dart';

import '../object/random_object.dart';

void moveObjects(BuildContext context, List<RandomObject> randomObj) {
  for (RandomObject obj in randomObj) {
    obj.position += obj.direction * obj.objectSpeed;

    if (obj.position.dx <= 0 ||
        obj.position.dx + obj.objectSize >= MediaQuery.of(context).size.width) {
      obj.direction = Offset(-obj.direction.dx, obj.direction.dy);
    }
    if (obj.position.dy <= 0 ||
        obj.position.dy + obj.objectSize >=
            MediaQuery.of(context).size.height) {
      obj.direction = Offset(obj.direction.dx, -obj.direction.dy);
    }
  }
}
