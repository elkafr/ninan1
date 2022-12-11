
import 'dart:math' as math;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ninan1/components/app_data/shared_preferences_helper.dart';
import 'package:ninan1/components/app_repo/app_state.dart';
import 'package:ninan1/components/app_repo/progress_indicator_state.dart';
import 'package:ninan1/components/buttons/custom_button.dart';
import 'package:ninan1/components/connectivity/network_indicator.dart';
import 'package:ninan1/components/custom_text_form_field/custom_text_form_field.dart';
import 'package:ninan1/components/gradient_app_bar/gradient_app_bar.dart';
import 'package:ninan1/components/horizontal_divider/horizontal_divider.dart';
import 'package:ninan1/components/progress_indicator_component/progress_indicator_component.dart';
import 'package:ninan1/components/response_handling/response_handling.dart';
import 'package:ninan1/components/safe_area/page_container.dart';
import 'package:ninan1/locale/localization.dart';
import 'package:ninan1/models/user.dart';
import 'package:ninan1/services/access_api.dart';
import 'package:ninan1/utils/app_colors.dart';
import 'package:ninan1/utils/utils.dart';
import 'package:ninan1/screens/auth/password_recovery_bottom_sheet.dart';

import 'package:validators/validators.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double _height;
  double _width;
  final _formKey = GlobalKey<FormState>();
  String _userPhone, _userPassword;
  Services _services = Services();
  ProgressIndicatorState _progressIndicatorState;
  AppState _appState;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  Widget _buildBodyItem() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: _height * 0.2,
            ),
            Container(

              margin: EdgeInsets.symmetric(horizontal: _width * 0.03),
              child: Center(
                child: Image.asset('assets/images/checkAcount.png'),
              ),
            ),
            SizedBox(
              height: _width*.1,
            ),
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: _width * 0.08),
                alignment: Alignment.center,
                child: Text("بالتحقق من رقم جوالك تصبح قادر على الطلب ",
                  maxLines: 1,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            SizedBox(
              height: _width*.03,
            ),
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: _width * 0.08),
                alignment: Alignment.center,
                child: Text("ومراجعة طلباتك السابقة",
                  maxLines: 1,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            SizedBox(
              height: _width*.1,
            ),
            Container(


                child: CustomTextFormField(
              iconIsImage: true,
              imagePath: 'assets/images/call.png',
              hintTxt: AppLocalizations.of(context).phoneNo,
              suffixIcon:  Image.asset("assets/images/sa.png"),
              validationFunc: (value) {
               if (value.trim().length == 0) {
                      return AppLocalizations.of(context).phonoNoValidation;
                    }
                return null;
              },
              inputData: TextInputType.text,
              onChangedFunc: (String text) {
                _userPhone = text.toString();
              },
            )),

            SizedBox(
              height: _width*.4,
            ),
           Align(
             alignment: Alignment.bottomCenter,
             child:  Container(
               height: 60,
               child: CustomButton(
                 btnColor: cPrimaryColor,
                 btnLbl: 'التالي',
                 onPressedFunction: () async {
                   if (_formKey.currentState.validate()) {
                     _firebaseMessaging.getToken().then((token) async {
                       //       print('mobile token $token');
                       _progressIndicatorState.setIsLoading(true);
                       var results = await _services.get(
                         '${Utils.SENDCODE_URL}?user_phone=$_userPhone&token=$token&lang=${_appState.currentLang}',
                       );
                       _progressIndicatorState.setIsLoading(false);
                       if (results['response'] == '1') {
                         _appState.setCurrentPhoneSend(_userPhone);
                         _appState.setCurrentTokenSend(token);
                         showToast(results['message'], context);
                         _appState.setCurrentUser(User(userId:results['driver_id'].toString() ));
                         Navigator.pushNamed(context, '/register_code_activation_screen' );
                       } else {
                         showErrorDialog(results['message'], context);
                       }
                     });
                   }
                 },
               ),
             ),
           ),





          ],
        ),
      ),
    )
    ;
  }

  @override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _progressIndicatorState = Provider.of<ProgressIndicatorState>(context);
    _appState = Provider.of<AppState>(context);
    print('lang : ${_appState.currentLang}');
    return NetworkIndicator(
        child: PageContainer(

      child: Scaffold(
backgroundColor: Colors.white,

          body: SingleChildScrollView(
            reverse: true,
            child: Stack(

              children: <Widget>[
                _buildBodyItem(),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: GradientAppBar(
                      appBarTitle: AppLocalizations.of(context).login,
                        leading: _appState.currentLang == 'ar' ? IconButton(
                icon: Image.asset('assets/images/back.png'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ) :Container(),
              trailing: _appState.currentLang == 'en' ? IconButton(
                icon: Transform.rotate(
                   angle: -math.pi / 1,
                child: Image.asset('assets/images/back.png'),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ) :Container(),
                      
                      ),
                ),
                Center(
                  child: ProgressIndicatorComponent(),
                )
              ],
            ),
          )),
    ));
  }
}
