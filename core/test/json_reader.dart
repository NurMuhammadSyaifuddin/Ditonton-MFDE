import 'dart:io';

import 'package:flutter/foundation.dart';

String readJson(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('/test')) {
    dir = dir.replaceAll('/test', '');
  }
  if (!kDebugMode) {
    dir += '/core';
  }
  return File('$dir/test/$name').readAsStringSync();
}
