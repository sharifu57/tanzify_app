import 'dart:math';

import 'package:flutter/foundation.dart';

void devLog(value) {
  if (kDebugMode) {
    print(value);
  }
}

String randomId([int? len]) {
  var r = Random();
  return String.fromCharCodes(
      List.generate(len ?? 6, (index) => r.nextInt(33) + 89));
}
