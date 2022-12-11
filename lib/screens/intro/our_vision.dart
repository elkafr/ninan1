import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ninan1/components/buttons/custom_button.dart';
import 'package:ninan1/components/progress_indicator_component/progress_indicator_component.dart';
import 'package:ninan1/components/safe_area/page_container.dart';
import 'package:ninan1/locale/localization.dart';
import 'package:ninan1/screens/intro/components/circle_item.dart';
import 'package:ninan1/utils/app_colors.dart';

class OurVision extends StatefulWidget {
  @override
  _OurVisionState createState() => _OurVisionState();
}

class _OurVisionState extends State<OurVision> {
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
            imgPath: 'assets/images/vision.png',
          ),
        ),
        Center(
          child: Text(
            AppLocalizations.of(context).ourVision,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: _width * 0.12, right: _width * 0.12,
               top: _height * 0.02),
          height: 60,
          child: CustomButton(
            prefixIcon: Icon(
              Icons.arrow_back_ios,
              color: cWhite,
            ),
            btnLbl: AppLocalizations.of(context).next,
            onPressedFunction: () {
              Navigator.pushNamed(context, '/torf_city');
            },
          ),
        )
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
