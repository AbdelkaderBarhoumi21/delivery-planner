import 'package:flutter/material.dart';

class AppCustomRoundedEgdes extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    // 1) on part du coin haut-gauche (0,0) implicitement
    // 2) on descend quasi en bas à gauche (bord vertical)
    //lineTo(x,y) trace un segment depuis la position courante jusqu’à (x,y).
    path..lineTo(0, size.height - 40); //Top to bottom line
    //first Curve
    // quadraticBezierTo(cx, cy, x, y)trace une courbe vers (x,y) en utilisant (cx,cy) comme point de contrôle
    Offset firstPointCurve = Offset(40, size.height);
    Offset secondPointCurve = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(
      firstPointCurve.dx,
      firstPointCurve.dy,
      secondPointCurve.dx,
      secondPointCurve.dy,
    );
    final firstPointCurve2 = Offset(size.width - 40, size.height);
    final secondPointCurve2 = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(
      firstPointCurve2.dx,
      firstPointCurve2.dy,
      secondPointCurve2.dx,
      secondPointCurve2.dy,
    );
    // Remonter au coin haut-droit et fermer la forme
    //Bottom to top line
    path
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  //Si ta forme ne dépend pas d’animations ou de données qui changent, mets false pour éviter du travail inutile
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
