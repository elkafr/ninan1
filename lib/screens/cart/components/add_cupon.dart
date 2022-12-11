


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ninan1/components/buttons/custom_button.dart';
import 'package:ninan1/components/dialogs/location_dialog.dart';
import 'package:ninan1/models/category.dart';
import 'package:ninan1/models/location.dart';
import 'package:ninan1/utils/app_colors.dart';
import 'package:ninan1/utils/app_colors.dart';
import 'package:ninan1/components/response_handling/response_handling.dart';

import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ninan1/screens/home/components/home_appbar.dart';
import 'package:ninan1/screens/home/home1_screen.dart';
import 'package:ninan1/screens/location/addLocation_screen.dart';
import 'package:provider/provider.dart';
import 'package:ninan1/components/app_data/shared_preferences_helper.dart';
import 'package:ninan1/components/app_repo/app_state.dart';
import 'package:ninan1/components/connectivity/network_indicator.dart';
import 'package:ninan1/components/custom_text_form_field/custom_text_form_field.dart';
import 'package:ninan1/components/gradient_app_bar/gradient_app_bar.dart';
import 'package:ninan1/components/no_data/no_data.dart';
import 'package:ninan1/components/safe_area/page_container.dart';
import 'package:ninan1/locale/localization.dart';
import 'package:ninan1/services/access_api.dart';
import 'package:ninan1/utils/app_colors.dart';
import 'package:ninan1/models/category.dart';
import 'package:ninan1/models/store.dart';
import 'package:ninan1/utils/utils.dart';
import 'package:ninan1/components/app_repo/store_state.dart';
import 'package:ninan1/components/store_card/store_card_item.dart';
import 'package:ninan1/screens/home/components/slider_images.dart';
import 'package:ninan1/screens/home/components/category_item1.dart';
import 'package:ninan1/components/app_repo/progress_indicator_state.dart';
import 'package:ninan1/components/progress_indicator_component/progress_indicator_component.dart';

class AddCupone extends StatefulWidget {
  const AddCupone({Key key}) : super(key: key);
  @override
  _AddCuponeState createState() => _AddCuponeState();
}

class _AddCuponeState extends State<AddCupone> {
  Services _services = Services();
  Future<List<Location>> _locationList;
   AppState _appState;
  bool _initialRun = true;
  String _cupone;





  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _initialRun = false;
      _appState = Provider.of<AppState>(context);


    }
  }



  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
          padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Container(
                height: 30,
                child: Image.asset('assets/images/bottomTop.png'),
              ),

             Container(
               padding: EdgeInsets.only(right: 20),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   Text("اضف كوبون",style: TextStyle(color: cText,fontSize: 16,fontWeight: FontWeight.bold),),
                   Padding(padding: EdgeInsets.all(5)),
                   Text("اضف كوبون الخاص بالخصم لديك",style: TextStyle(color: cHintColor,fontSize: 13),),
                 ],
               ),
             ),
              Padding(padding: EdgeInsets.all(15)),
              Expanded(child: CustomTextFormField(



                hintTxt: " ... اكتب الكود",


                inputData: TextInputType.text,
                onChangedFunc: (String text) {
                  _cupone = text.toString();
                },
              )


              ),

              Container(
                height: 50,
                child: CustomButton(

                  btnLbl: "إضافة ",
                  onPressedFunction: () async{



                    var results = await _services.get(
                        'https://ninanapp.com/app/api/addCupone?user_id=${_appState.currentUser.userId}&cupone_value=$_cupone&lang=${_appState.currentLang}');

                    if (results['response'] == '1') {

                      _appState.setCurrentCupone(_cupone);
                      Navigator.pop(context);
                      print(_appState.cupone);
                      showToast( results['message'], context);
                    } else {

                      showErrorDialog(results['message'], context);
                    }



                  },
                ),
              )


            ],
          ));
    });
  }
}
