import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  final Duration delay;
  VoidCallback? _action;
  Timer? _timer;

  Debouncer({required this.delay});

  void run(VoidCallback action) {
    _action = action;
    _timer?.cancel();
    _timer = Timer(delay, _execute);
  }

  void _execute() {
    _action?.call();
  }

  void cancel() {
    _timer?.cancel();
  }
}
