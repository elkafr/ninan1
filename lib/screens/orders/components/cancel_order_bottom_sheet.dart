import 'package:flutter/material.dart';
import 'package:ninan1/components/buttons/custom_button.dart';
import 'package:ninan1/locale/localization.dart';
import 'package:ninan1/utils/app_colors.dart';

class CancelOrderBottomSheet extends StatefulWidget {
  final Function onPressedConfirmation;

  const CancelOrderBottomSheet({Key key, this.onPressedConfirmation})
      : super(key: key);
  @override
  _CancelOrderBottomSheetState createState() => _CancelOrderBottomSheetState();
}

class _CancelOrderBottomSheetState extends State<CancelOrderBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: constraints.maxHeight * 0.05),
              child: Icon(
                Icons.not_interested,
                size: constraints.maxHeight * 0.4,
                color: cLightRed,
              )),
          Container(
            margin:
                EdgeInsets.symmetric(vertical: constraints.maxHeight * 0.05),
            child: Text(
              AppLocalizations.of(context).wantToCancelOrder,
              style: TextStyle(
                  color: cBlack, fontSize: 17, fontWeight: FontWeight.w600),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Spacer(
                flex: 2,
              ),
              Container(
                width: constraints.maxWidth * 0.3,
                height: 60,
                child: CustomButton(
                    btnStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: cWhite),
                    btnLbl: AppLocalizations.of(context).ok,
                    onPressedFunction: () async {
                      widget.onPressedConfirmation();
                    }),
              ),
              Spacer(
                flex: 1,
              ),
              Container(
                  width: constraints.maxWidth * 0.3,
                  height: 60,
                  child: CustomButton(
                      btnStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: cPrimaryColor),
                      hasGradientColor: false,
                      btnLbl: AppLocalizations.of(context).cancel,
                      btnColor: cWhite,
                      onPressedFunction: () {
                        Navigator.pop(context);
                      })),
              Spacer(
                flex: 2,
              ),
            ],
          )
        ],
      );
    });
  }
}
