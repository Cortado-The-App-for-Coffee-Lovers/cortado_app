/*
*  gradients.dart
*  cortadosuper
*
*  Created by [Author].
*  Copyright © 2018 [Company]. All rights reserved.
    */

import 'package:flutter/rendering.dart';


class Gradients {
  static const Gradient primaryGradient = LinearGradient(
    begin: Alignment(0, 1),
    end: Alignment(1, 0),
    stops: [
      0,
      1,
    ],
    colors: [
      Color.fromARGB(255, 247, 132, 98),
      Color.fromARGB(255, 139, 27, 140),
    ],
  );
}