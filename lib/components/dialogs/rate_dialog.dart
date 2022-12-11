import 'package:flutter/material.dart';
import 'package:ninan1/components/app_repo/app_state.dart';
import 'package:ninan1/components/app_repo/progress_indicator_state.dart';
import 'package:ninan1/components/app_repo/tab_state.dart';
import 'package:ninan1/components/components/buttons/custom_button.dart';
import 'package:ninan1/components/response_handling/response_handling.dart';
import 'package:ninan1/locale/localization.dart';
import 'package:ninan1/services/access_api.dart';
import 'package:ninan1/utils/app_colors.dart';
import 'package:ninan1/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RateDialog extends StatefulWidget {
  final String cartFatora;

 RateDialog({Key key, this.cartFatora}) : super(key: key);
  
  @override
  _RateDialogState createState() => _RateDialogState();
}

class _RateDialogState extends State<RateDialog> {
  double _rating = 0.0;
  Services _services = Services();
  @override
  Widget build(BuildContext context) {
      final progressIndicatorState = Provider.of<ProgressIndicatorState>(context);
    final appState = Provider.of<AppState>(context);
    final tabState = Provider.of<TabState>(context);
    return LayoutBuilder(builder: (context, constraints) {
      return AlertDialog(
        contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        content: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Image.asset(
              'assets/images/poprate.png',
              height: 70,
              width: 70,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              AppLocalizations.of(context).addYourRateNow,
              style: TextStyle(
                  color: cBlack, fontWeight: FontWeight.w700, fontSize: 14),
            ),
            SizedBox(
              height: 10,
            ),
            SmoothStarRating(
                allowHalfRating: true,
                onRated: (v) {
                  _rating = v;
                  setState(() {});
                },
                starCount: 5,
                rating: _rating,
                size: 30.0,
                color: Color(0xffFFCE42),
                borderColor: Color(0xffA5A1A1),
                spacing: 0.0),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 20, right: 15, left: 15),
              child: CustomButton(
                  height: 35,
                  buttonOnDialog: true,
                  btnLbl: AppLocalizations.of(context).rateNow,
                  onPressedFunction: () async {
     progressIndicatorState.setIsLoading(true);
                                    var results = await _services.get(
                               '${Utils.RATE_ORDER_URL}user_id=${appState.currentUser.userId}&lang=${appState.currentLang}&rate_cart=${widget.cartFatora}&rate_value=${_rating.toString()}');
                                    progressIndicatorState.setIsLoading(false);
                                    if (results['response'] == '1') {
                                      showToast(results['message'], context);
                                      Navigator.pop(context);
                                          Navigator.pop(context);
                                          tabState.upadateInitialIndex(1);
                                      Navigator.pushReplacementNamed(
                                          context, '/navigation');
                                   
                                    } else {
                                      showErrorDialog(
                                          results['message'], context);
                                    }
                  }),
            )
          ],
        )),
      );
    });
  }
}
