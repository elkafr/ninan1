import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ninan1/components/app_repo/store_state.dart';
import 'package:provider/provider.dart';
import 'package:ninan1/components/app_data/shared_preferences_helper.dart';
import 'package:ninan1/components/app_repo/app_state.dart';
import 'package:ninan1/components/app_repo/progress_indicator_state.dart';
import 'package:ninan1/components/buttons/custom_button.dart';
import 'package:ninan1/components/connectivity/network_indicator.dart';
import 'package:ninan1/components/custom_text_form_field/custom_text_form_field.dart';
import 'package:ninan1/components/gradient_app_bar/gradient_app_bar.dart';
import 'package:ninan1/components/progress_indicator_component/progress_indicator_component.dart';
import 'package:ninan1/components/response_handling/response_handling.dart';
import 'package:ninan1/components/safe_area/page_container.dart';
import 'package:ninan1/locale/localization.dart';
import 'package:ninan1/services/access_api.dart';
import 'package:ninan1/utils/app_colors.dart';
import 'package:validators/validators.dart';

class MtgerModifyPasswordScreen extends StatefulWidget {
  @override
  _MtgerModifyPasswordScreenState createState() => _MtgerModifyPasswordScreenState();
}

class _MtgerModifyPasswordScreenState extends State<MtgerModifyPasswordScreen> {
  var _height, _width;
  final _formKey = GlobalKey<FormState>();
  ProgressIndicatorState _progressIndicatorState;
  Services _services = Services();
  String _newUserPassword, _oldUserPassword;
  AppState _appState;
  StoreState _storeState;


  Widget _buildBodyItem() {
    return Consumer<StoreState>(builder: (buildContext, storeState, child) {
      return SingleChildScrollView(
        child: Container(
          height: _height,
          width: _width,
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Container(
                    margin: EdgeInsets.only(
                        top: _height * 0.03,
                        left: _width * 0.025,
                        right: _width * 0.025),
                    child: CustomTextFormField(
                        isPassword: true,
                      
                    imagePath: 'assets/images/key.png',
                    iconIsImage: true,
                        hintTxt: AppLocalizations.of(context).oldPassword,
                        inputData: TextInputType.text,
                        onChangedFunc: (String text) {
                          _oldUserPassword = text.toString();
                        },
                        validationFunc: (value) {
                         if (value.trim().length < 4) {
                            return AppLocalizations.of(context).passwordValidation;
                          }
                          return null;
                        })),
                Container(
                    margin: EdgeInsets.only(
                        left: _width * 0.025, right: _width * 0.025),
                    child: CustomTextFormField(
                          isPassword: true,
                    imagePath: 'assets/images/key.png',
                    iconIsImage: true,
                        hintTxt: AppLocalizations.of(context).newPassword,
                        inputData: TextInputType.text,
                        onChangedFunc: (String text) {
                          _newUserPassword = text.toString();
                        },
                        validationFunc: (value) {
                          if (value.trim().length < 4) {
                            return AppLocalizations.of(context).passwordValidation;
                          }
                          return null;
                        })),
                Container(
                    margin: EdgeInsets.only(
                        left: _width * 0.025, right: _width * 0.025),
                    child: CustomTextFormField(
                        isPassword: true,
                    imagePath: 'assets/images/key.png',
                    iconIsImage: true,
                        hintTxt: AppLocalizations.of(context).confirmNewPassword,
                        inputData: TextInputType.text,
                        onChangedFunc: (String text) {},
                        validationFunc: (value) {
                          if (value.trim().length < 4) {
                            return AppLocalizations.of(context).passwordValidation;
                          } else if (value != _newUserPassword) {
                            return  AppLocalizations.of(context).passwordNotIdentical;
                          }
                          return null;
                        })),
                Spacer(),
                Divider(),
                Container(
                  margin: EdgeInsets.only(
                      left: _width * 0.025, right: _width * 0.025),
                  height: 60,
                  child: CustomButton(
                    btnLbl: AppLocalizations.of(context).save,
                    onPressedFunction: () async {
                      if (_formKey.currentState.validate()) {
                        _progressIndicatorState.setIsLoading(true);

                        var results = await _services.get(
                          'https://ninanapp.com/app/api/mtger_profile?user_pass2=$_oldUserPassword&user_pass=$_newUserPassword&user_pass1=$_newUserPassword&user_id=${storeState.currentStore.mtgerId}&lang=${_appState.currentLang}',
                        );
                        _progressIndicatorState.setIsLoading(false);
                        if (results['response'] == '1') {
                          showToast(results['message'], context);
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(
                              context, '/mtger_personal_information_screen');
                        } else {
                          showErrorDialog(results['message'], context);
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _progressIndicatorState = Provider.of<ProgressIndicatorState>(context);
   _appState = Provider.of<AppState>(context);
   _storeState = Provider.of<StoreState>(context);

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
              appBarTitle: AppLocalizations.of(context).editPassword,
              leading: _appState.currentLang == 'ar' ? IconButton(
                icon: Image.asset('assets/images/back.png'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ) :Container(),
              trailing: _appState.currentLang == 'en' ? IconButton(
                icon: Image.asset('assets/images/back.png'),
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
      )),
    ));
  }
}
