import 'package:flutter/material.dart';

class LoginPageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.addOval(Rect.fromCircle(
        center: Offset(size.width * 0.4, size.width * 0.1),
        radius: size.width * 0.8));

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class PageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.addOval(Rect.fromCenter(
        center: Offset(size.width * 0.5, size.width * 0.149),
        height:size.width * 0.8,
        width: size.width * 1.7));

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}


class LoginPageAlternativeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.addOval(Rect.fromCircle(
        center: Offset(size.width * 0.24, size.width * 0.005),
        radius: size.width * 0.42));

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class LoginPageSmallClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.addOval(Rect.fromCenter(
        center: Offset(size.width * 0.156, size.width * 0.194),
        width: size.width * 0.999,
        height: size.width * 1.109));

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class LoginPageSmallAlternativeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.addOval(Rect.fromCenter(
        center: Offset(size.width * 0.056, size.width * 0.104),
        width: size.width * 0.399,
        height: size.width * 0.409));

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
