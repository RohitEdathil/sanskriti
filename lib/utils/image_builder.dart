import 'package:flutter/material.dart';

Widget imageBuilder(BuildContext context, Widget child, int? frame,
    bool wasSynchronouslyLoaded) {
  if (wasSynchronouslyLoaded) {
    return child;
  }
  return AnimatedOpacity(
    opacity: frame == null ? 0 : 1,
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeOut,
    child: child,
  );
}
