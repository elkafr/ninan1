import 'package:flutter/material.dart';
import 'package:ninan1/utils/app_colors.dart';


class DefaultShapeOfDropDown extends StatelessWidget {
  final bool elementHasDefaultMargin;
  final String hint;

  const DefaultShapeOfDropDown(
      {Key key, this.elementHasDefaultMargin: true, this.hint})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.03),
        margin: elementHasDefaultMargin
            ? EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.04)
            : EdgeInsets.symmetric(horizontal: 0),
        decoration: BoxDecoration(
          color:   cHintColor.withOpacity(0.20),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: cHintColor),
        ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            hint,
            style: TextStyle(
                   color: cPrimaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                fontFamily: 'HelveticaNeueW23forSKY'),
          ),
          Icon(Icons.arrow_drop_down,
              
           color: cHintColor
            ),
        
        ],
      ),
    );
  }
}
