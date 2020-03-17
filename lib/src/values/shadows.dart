/*
*  shadows.dart
*  cortadosuper
*
*  Created by [Author].
*  Copyright © 2018 [Company]. All rights reserved.
    */

import 'package:flutter/rendering.dart';


class Shadows {
  static const BoxShadow primaryShadow = BoxShadow(
    color: Color.fromARGB(51, 0, 0, 0),
    offset: Offset(0, 20),
    blurRadius: 50,
  );
  static const BoxShadow secondaryShadow = BoxShadow(
    color: Color.fromARGB(20, 0, 0, 0),
    offset: Offset(0, 20),
    blurRadius: 50,
  );
}