import 'dart:math';
import 'dart:ui';

import 'object_type.dart';

class RandomObject {
  double objectSize;
  ObjectType objectType;
  double objectSpeed;
  Offset position;
  Offset direction;

  RandomObject({
    required this.objectSize,
    required this.objectType,
    required this.objectSpeed,
  })  : position = Offset(Random().nextInt(600).toDouble(),
            Random().nextInt(1000).toDouble()),
        direction = Offset(
          Random().nextBool() ? -1.0 : 1.0,
          Random().nextBool() ? -1.0 : 1.0,
        );
}
