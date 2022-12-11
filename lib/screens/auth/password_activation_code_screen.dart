import 'package:flutter/material.dart';
import 'package:ninan1/app_repo/app_state.dart';
import 'package:ninan1/app_repo/auth_state.dart';
import 'package:ninan1/app_repo/progress_indicator_state.dart';
import 'package:ninan1/components/buttons/custom_button.dart';
import 'package:ninan1/components/connectivity/network_indicator.dart';
import 'package:ninan1/components/custom_text_form_field/custom_text_form_field.dart';
import 'package:ninan1/components/progress_indicator_component/progress_indicator_component.dart';
import 'package:ninan1/components/response_handling/response_handling.dart';
import 'package:ninan1/components/safe_area/page_container.dart';
import 'package:ninan1/locale/localization.dart';
import 'package:ninan1/services/access_api.dart';
import 'package:ninan1/utils/app_colors.dart';
import 'package:ninan1/utils/utils.dart';
import 'package:provider/provider.dart';

class PasswordActivationCodeScreen extends StatefulWidget {
  @override
  _PasswordActivationCodeScreenState createState() =>
      _PasswordActivationCodeScreenState();
}

class _PasswordActivationCodeScreenState extends State<PasswordActivationCodeScreen> {
  double _height = 0, _width = 0;

  String _activationCode = '';
  Services _services = Services();
  ProgressIndicatorState _progressIndicatorState;
  AppState _appState;
  AuthState _authState;

  bool _checkValidation(BuildContext context, {String codeActivation}) {
    if (codeActivation.trim().length == 0) {
      showToast(AppLocalizations.of(context).codeActivationValidation, context,
          color: cRed);
      return false;
    }
    // else if (password.trim().length < 4) {
    //   showToast(AppLocalizations.of(context).passwordValidation, context,
    //       color: cRed);
    //   return false;
    // }
    return true;
  }

  Widget _buildBodyItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        Image.asset(
          'assets/images/full_edit.png',
          height: 70,
          width: _width,
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(
            AppLocalizations.of(context).restorePassword,
            style: TextStyle(
                color: cBlack, fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
        Container(
          // margin: EdgeInsets.only(top: 10),
          child: Text(
            AppLocalizations.of(context).enterCodeToRestorePassword,
            style: TextStyle(
                color: cHintColor, fontSize: 13, fontWeight: FontWeight.w400),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: CustomTextFormField(
            prefixIconIsImage: true,
            prefixIconImagePath: 'assets/images/edit.png',
            hintTxt: AppLocalizations.of(context).writeCodeHere,
            inputData: TextInputType.text,
            onChangedFunc: (String text) {
              _activationCode = text.toString();
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: CustomButton(
            btnLbl: AppLocalizations.of(context).restorePassword,
            onPressedFunction: () async {
              if (_checkValidation(context, codeActivation: _activationCode))
               {
                 
                _progressIndicatorState.setIsLoading(true);
                var results = await _services.get(
                 
                    'https://works.rawa8.com/apps/bqala/api/active_code?user_code=$_activationCode&lang=${_appState.currentLang}');
                _progressIndicatorState.setIsLoading(false);
                if (results['response'] == '1') {
                  showToast(results['message'], context);
                  _authState.setUserId(results['user_id']);
                  Navigator.pushNamed(context, '/password_recovery_screen');
                } else {
                  showErrorDialog(results['message'], context);
                }
              }
            },
          ),
        ),
        
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
        backgroundColor: cPrimaryColor,
        centerTitle: true,
        title: Text(AppLocalizations.of(context).codeToRestorePassword,
            style: Theme.of(context).textTheme.display1),
        leading: IconButton(
          icon: Consumer<AppState>(
            builder: (context,appState,child){
              return appState.currentLang == 'ar' ? Image.asset('assets/images/back_ar.png'):
              Image.asset('assets/images/back_en.png');

            }
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ));
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _progressIndicatorState = Provider.of<ProgressIndicatorState>(context);
    _appState = Provider.of<AppState>(context);
    _authState = Provider.of<AuthState>(context);

    return NetworkIndicator(
        child: PageContainer(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: appBar,
        body: Stack(
          children: <Widget>[
            _buildBodyItem(),
            Center(
              child: ProgressIndicatorComponent(),
            )
          ],
        ),
      ),
    ));
  }
}
