import 'package:flutter/material.dart';


class CustomBook extends StatelessWidget {

  final Widget child;
  final Color bookLeftColor;
  final Color bookDownColor;


  CustomBook({this.child, this.bookLeftColor = Colors.green, this.bookDownColor = Colors.lightGreen});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        child: child,
        painter: MyPainter(bookLeftColor, bookDownColor),
      ),
    );
  }
}


class MyPainter extends CustomPainter {

  final Color bookLeftColor;
  final Color bookDownColor;

  MyPainter(this.bookLeftColor, this.bookDownColor);


  @override
  void paint(Canvas canvas, Size size) {
    
    double distanceX = size.width / 15;
    double distanceY = size.height / 15;
    
    //书本最左侧
    var paint = Paint()
      ..color = bookLeftColor
      ..strokeWidth = 3
      ..style = PaintingStyle.fill;

    Path pathLeft = Path()
      ..moveTo(0, 0)
      ..lineTo(-distanceX, distanceY)
      ..lineTo(-distanceX, size.height + distanceY)
      ..lineTo(0, size.height);
    canvas.drawPath(pathLeft, paint);


    //书本下侧
    paint.color = bookDownColor;

    Path pathDown = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width - distanceX, size.height + distanceY)
      ..lineTo(-distanceX, size.height + distanceY);



    canvas.drawPath(pathDown, paint);


//    canvas.drawLine(Offset(0, 0), Offset(100, 100), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

}
