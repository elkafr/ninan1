import 'package:flutter/material.dart';
import 'package:ninan1/utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  final Color btnColor;
  final String btnLbl;
  final Function onPressedFunction;
  final TextStyle btnStyle;
  final Widget prefixIcon;
  final Widget postfixIcon;
  final bool hasGradientColor;

  const CustomButton(
      {Key key,
      this.btnLbl,
      this.onPressedFunction,
      this.btnColor,
      this.btnStyle,
      this.prefixIcon,
      this.hasGradientColor = true,
      this.postfixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
          decoration: BoxDecoration(

              border: Border.all(color: cPrimaryColor),
            borderRadius: BorderRadius.circular(5.0),
          ),
          height: constraints.maxHeight,
          margin: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth * 0.04,
              vertical: constraints.maxHeight * 0.1),
          child: GestureDetector(
            onTap: () {
              onPressedFunction();
            },
            child: Container(

                color: btnColor != null
                    ? btnColor
                    : cPrimaryColor,
                alignment: Alignment.center,
                child: prefixIcon != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          prefixIcon,
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                '$btnLbl',
                                style: btnStyle == null
                                    ? Theme.of(context).textTheme.button
                                    : btnStyle,
                              ))
                        ],
                      )
                    : postfixIcon != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                    '$btnLbl',
                                    style: btnStyle == null
                                        ? Theme.of(context).textTheme.button
                                        : btnStyle,
                                  )),
                              postfixIcon
                            ],
                          )
                        : Text(
                            '$btnLbl',
                            style: btnStyle == null
                                ? Theme.of(context).textTheme.button
                                : btnStyle,
                          )),
          ));
    });
  }
}
