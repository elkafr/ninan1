import 'package:flutter/material.dart';
import 'package:ninan1/utils/app_colors.dart';

class CircleItem extends StatelessWidget {

  final String imgPath;

  const CircleItem({Key key, this.imgPath}) : super(key: key);

  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return  Container(
          height: constraints.maxHeight,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[300],
                  blurRadius: 25.0, // has the effect of softening the shadow
                  spreadRadius: 5.0, // has the effect of extending the shadow
                  offset: Offset(
                    10.0, // horizontal, move right 10
                    10.0, // vertical, move down 10
                  ),
                )
              ],
              color: cWhite,
              border: Border.all(color: Color(0xff1F61301A), width: 1.0),
              shape: BoxShape.circle),
              child: Image.asset(imgPath),
        );
    });
  }
}