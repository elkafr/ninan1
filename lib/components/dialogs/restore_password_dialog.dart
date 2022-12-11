import 'package:flutter/material.dart';
import 'package:ninan1/app_repo/app_state.dart';
import 'package:ninan1/app_repo/progress_indicator_state.dart';
import 'package:ninan1/app_repo/tab_state.dart';
import 'package:ninan1/components/buttons/custom_button.dart';
import 'package:ninan1/components/custom_text_form_field/custom_text_form_field.dart';
import 'package:ninan1/components/response_handling/response_handling.dart';
import 'package:ninan1/locale/localization.dart';
import 'package:ninan1/services/access_api.dart';
import 'package:ninan1/utils/app_colors.dart';
import 'package:ninan1/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RestorePasswordDialog extends StatefulWidget {
  @override
  _RestorePasswordDialogState createState() => _RestorePasswordDialogState();
}

class _RestorePasswordDialogState extends State<RestorePasswordDialog> {

  Services _services = Services();
  String _userPhone = '';

   bool _checkValidation(BuildContext context, {String phone}) {
    if (phone.trim().length == 0) {
      showToast(AppLocalizations.of(context).phonoNoValidation, context,
          color: cRed);
      return false;
    } 

    return true;
  }
  @override
  Widget build(BuildContext context) {
    final progressIndicatorState = Provider.of<ProgressIndicatorState>(context);
    final appState = Provider.of<AppState>(context);

    return LayoutBuilder(builder: (context, constraints) {
      return AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          content: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: SingleChildScrollView(
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
                  AppLocalizations.of(context).restorePassword,
                  style: TextStyle(
                      color: cBlack, fontWeight: FontWeight.w700, fontSize: 14),
                ),
               Text(AppLocalizations.of(context).enterPhoneNumberToSendPasswordRecoveryCode,
               style: TextStyle(
                 fontSize: 13,color: cHintColor
               ),),
            
                Container(
                  margin: EdgeInsets.all(10),
                  child: CustomTextFormField(
                    buttonOnTextForm: true,
                    prefixIconIsImage: true,
                    prefixIconImagePath: 'assets/images/phone.png',
                    hintTxt: AppLocalizations.of(context).phoneNo,
                    inputData: TextInputType.text,
                    onChangedFunc: (String text) {
                       _userPhone = text.toString();
                    },
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only( bottom: 20, right: 10, left: 10),
                  child: CustomButton(
                      height: 35,
                      buttonOnDialog: true,
                      btnLbl: AppLocalizations.of(context).sendRetrievalCode,
                      onPressedFunction: () async {
                             FocusScope.of(context).requestFocus( FocusNode());
                        if(_checkValidation(context,phone: _userPhone)){



                          progressIndicatorState.setIsLoading(true);
                          var results = await _services.get(
                           'https://works.rawa8.com/apps/bqala/api/send_code?user_phone=$_userPhone&lang=${appState.currentLang}');
                    progressIndicatorState.setIsLoading(false);
                        if (results['response'] == '1') {
                          showToast(results['message'], context);
                          Navigator.pushNamed(context,  '/password_activation_code_screen');
                        } else {
                          showErrorDialog(results['message'], context);
                        }

 
                         }
                       
                      }),
                )
              ],
            )),
          ));
    });
  }
}
