import 'package:flutter/material.dart';

import 'package:ninan1/components/buttons/custom_button.dart';
import 'package:ninan1/components/safe_area/page_container.dart';
import 'package:ninan1/locale/localization.dart';
import 'package:ninan1/screens/intro/components/circle_item.dart';
import 'package:ninan1/utils/app_colors.dart';

class TorfCity extends StatefulWidget {
  @override
  _TorfCityState createState() => _TorfCityState();
}

class _TorfCityState extends State<TorfCity> {
  double _height, _width;

  Widget _buildBodyItem() {
    return ListView(
      children: <Widget>[
        Image.asset(
          'assets/images/flag.png',
          width: _width,
          fit: BoxFit.fitWidth,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: _height * 0.03),
          height: _height * 0.35,
          child: CircleItem(
            imgPath: 'assets/images/baldia.png',
          ),
        ),
        Center(
          child: Text(
          AppLocalizations.of(context).baladiaTuraif,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
          ),
        ),
        Container(
            margin: EdgeInsets.only(
                left: _width * 0.15, right: _width * 0.15, top: _height * 0.04),
            height: 60,
            child: Row(
              children: <Widget>[
                Container(
                  width: _width * 0.35,
                  height: 60,
                  child: CustomButton(
                    prefixIcon: Icon(
                      Icons.arrow_back_ios,
                      color: cWhite,
                    ),
                    btnLbl: AppLocalizations.of(context).finish,
                    onPressedFunction: () {
                         Navigator.of(context).pushNamedAndRemoveUntil(
                      '/login_screen', (Route<dynamic> route) => false);
               
                    },
                  ),
                ),
                Container(
                  width: _width * 0.35,
                  height: 60,
                  child: CustomButton(
                    btnStyle: TextStyle(
                      color: cPrimaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600
                    ),
                    hasGradientColor: false,
                    postfixIcon: Icon(
                      Icons.arrow_forward_ios,
                      color: cPrimaryColor,
                    ),
                    btnLbl: AppLocalizations.of(context).previous,
                    btnColor: cWhite,
                    onPressedFunction: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    return PageContainer(
      child: Scaffold(
        body: _buildBodyItem(),
      ),
    );
  }
}
