import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
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
import 'package:validators/validators.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  double _height;
  double _width;
  final _formKey = GlobalKey<FormState>();
  String _userName = '', _userEmail = '', _userPhone = '', _userPassword = '';
  Services _services = Services();
  ProgressIndicatorState _progressIndicatorState;
  AppState _appState;

  Widget _buildBodyItem() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: _height * 0.1,
            ),
            Container(
              height: _height * 0.25,
              margin: EdgeInsets.symmetric(horizontal: _width * 0.03),
              child: Center(
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
            HorizontalDivider(),
            Container(
                margin: EdgeInsets.only(
                  top: _height * 0.03,
                ),
                child: CustomTextFormField(
                
                  prefixIcon:  Icon(
                      Icons.person,
                      size: 24,
                    ),
                  
                  hintTxt: AppLocalizations.of(context).name,
                  validationFunc: (value) {
                    if (value.trim().length == 0) {
                      return AppLocalizations.of(context).nameValidation;
                    }
                    return null;
                  },
                  inputData: TextInputType.text,
                  onChangedFunc: (String text) {
                    _userName = text.toString();
                  },
                )),
            Container(
                
                child: CustomTextFormField(
              iconIsImage: true,
              imagePath: 'assets/images/call.png', 
              hintTxt: AppLocalizations.of(context).phoneNo,
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
            Container(
               
                child: CustomTextFormField(
                 prefixIcon:  Icon(Icons.mail),
                  hintTxt: AppLocalizations.of(context).email,
                  validationFunc: (value) {
                    if (!isEmail(value)) {
                      return AppLocalizations.of(context).emailValidation;
                    }
                    return null;
                  },
                  inputData: TextInputType.text,
                  onChangedFunc: (String text) {
                    _userEmail = text.toString();
                  },
                )),
            Container(
                margin: EdgeInsets.only(
                  top: _height * 0.005,
                ),
                child: CustomTextFormField(
                       isPassword: true,
                    imagePath:'assets/images/key.png' ,
                 iconIsImage: true,
                    hintTxt: AppLocalizations.of(context).password,
                    inputData: TextInputType.text,
                    onChangedFunc: (String text) {
                      _userPassword = text.toString();
                    },
                    validationFunc: (value) {
                      if (value.trim().length < 4) {
                        return AppLocalizations.of(context).passwordValidation;
                      }
                      return null;
                    })),
            Container(
                margin: EdgeInsets.only(
                  top: _height * 0.005,
                ),
                child: CustomTextFormField(
                   
                    isPassword: true,
                    imagePath:'assets/images/key.png' ,
                 iconIsImage: true,
                    hintTxt: AppLocalizations.of(context).passwordVerify,
                    inputData: TextInputType.text,
                 
                    validationFunc: (value) {
                    if (value.trim().length < 4) {
                        return AppLocalizations.of(context).passwordValidation;
                  
                      } else if (value != _userPassword) {
                        return AppLocalizations.of(context).passwordNotIdentical;
                      }
                      return null;
                    })),
            Container(
              margin: EdgeInsets.only(
                left: _width * 0.05,
                right: _width * 0.05,
              ),
              alignment: Alignment.topRight,
              height: _height * 0.05,
              child: Row(
                children: <Widget>[
                   Consumer<AppState>(builder: (context, appState, child) {
                    return GestureDetector(
                      onTap: () =>
                          appState.setAcceptTerms(!appState.acceptTerms),
                      child: Container(
                        width: 20,
                        height: 20,
                        margin: EdgeInsets.only(
                            left: _width * 0.02, right: _width * 0.02),
                        child: appState.acceptTerms
                            ? Icon(
                                Icons.check,
                                color: cWhite,
                                size: 17,
                              )
                            : Container(),
                        decoration: BoxDecoration(
                          color:  appState.acceptTerms ? cPrimaryColor : cWhite,
                          border: Border.all(
                            color:  appState.acceptTerms
                                ? cPrimaryColor
                                : cHintColor,
                          ),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    );
                  }),
                  
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: _width * 0.02),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'segoeui',
                              color: Colors.black),
                          children: <TextSpan>[
                            new TextSpan(text: AppLocalizations.of(context).iAccept),
                            new TextSpan(
                                text: AppLocalizations.of(context).terms,
                                style: new TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    fontFamily: 'segoeui',
                                    color: cLightLemon)),
                          ],
                        ),
                      ))
                ],
              ),
            ),
            Container(
              height: 60,
              child: CustomButton(
                btnLbl: AppLocalizations.of(context).register,
                onPressedFunction: () async {
                  if (_formKey.currentState.validate()) {
                    if (_appState.acceptTerms) {
                      _progressIndicatorState.setIsLoading(true);
                      print('$_userEmail');
                      print('$_userPassword');
                      var results = await _services.get(
                          'https://ninanapp.com/app/api/register/?user_name=$_userName&user_phone=$_userPhone&user_email=$_userEmail&user_pass=$_userPassword&lang=${_appState.currentLang}');
                      _progressIndicatorState.setIsLoading(false);
                      if (results['response'] == '1') {
                        showToast(results['message'], context);
                        _appState.setCurrentUser(User(userId:results['user_id'].toString() ));
                        Navigator.pushNamed(context, '/register_code_activation_screen' );
                      } else {
                        showErrorDialog(results['message'], context);
                      }
                    } else {
                      showErrorDialog(AppLocalizations.of(context).acceptTerms, context);
                    }
                  }
                },
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: _height * 0.02),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context).hasAccount,
                    style:
                        TextStyle(color: cBlack, fontWeight: FontWeight.w400),
                  ),
                )),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              height: 60,
              child: CustomButton(
                btnStyle: TextStyle(color: cPrimaryColor, fontWeight: FontWeight.w600, fontSize: 17.0),
                hasGradientColor: false,
                btnLbl: AppLocalizations.of(context).login,
                btnColor: cWhite,
                onPressedFunction: () {
                  Navigator.pushNamed(context, '/login_screen');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _progressIndicatorState = Provider.of<ProgressIndicatorState>(context);
    _appState = Provider.of<AppState>(context);
    return  NetworkIndicator( child:PageContainer(
      child: Scaffold(
          body: Stack(
        children: <Widget>[
          _buildBodyItem(),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: GradientAppBar(
                appBarTitle: AppLocalizations.of(context).register,
                leading: _appState.currentLang == 'ar'? IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: cWhite,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ) : Container(),
                trailing: _appState.currentLang == 'en' ? IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: cWhite,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ) : Container()
                ),
          ),
          Center(
            child: ProgressIndicatorComponent(),
          )
        ],
      )),
    ));
  }
}
