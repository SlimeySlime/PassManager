import 'package:flutter/material.dart';
import 'package:passmanager/screen/pass_screen.dart';

Route folderScreen_animation() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return PassScreen();
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1, 0.0);
      const end = Offset.zero; // (0.0, 0.0)
      final tween = Tween(begin: begin, end: end);
      final offsetAnimation = animation.drive(tween);
      // return child;
      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
