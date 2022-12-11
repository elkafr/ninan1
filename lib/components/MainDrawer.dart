import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ninan1/screens/home/components/filter_open.dart';
import 'package:ninan1/screens/notifications/mtger_notifications_screen.dart';
import 'package:ninan1/screens/notifications/notifications_screen.dart';
import 'package:ninan1/screens/wallet/wallet_screen.dart';
import 'package:provider/provider.dart';
import 'package:ninan1/components/app_repo/app_state.dart';
import 'package:ninan1/components/app_repo/store_state.dart';
import 'package:ninan1/components/connectivity/network_indicator.dart';
import 'package:ninan1/components/dialogs/log_out_dialog.dart';
import 'package:ninan1/components/gradient_app_bar/gradient_app_bar.dart';
import 'package:ninan1/components/safe_area/page_container.dart';
import 'package:ninan1/locale/localization.dart';
import 'package:ninan1/screens/account/about_screen.dart';
import 'package:ninan1/screens/account/contact_with_us_screen.dart';
import 'package:ninan1/screens/account/language_screen.dart';
import 'package:ninan1/screens/account/terms_screen.dart';
import 'package:ninan1/utils/app_colors.dart';
import 'dart:math' as math;




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ninan1/models/user.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:ninan1/components/app_repo/app_state.dart';
import 'package:ninan1/components/app_repo/navigation_state.dart';
import 'package:ninan1/components/app_repo/progress_indicator_state.dart';
import 'package:ninan1/components/buttons/custom_button.dart';
import 'package:ninan1/components/connectivity/network_indicator.dart';
import 'package:ninan1/components/gradient_app_bar/gradient_app_bar.dart';
import 'package:ninan1/components/progress_indicator_component/progress_indicator_component.dart';
import 'package:ninan1/components/response_handling/response_handling.dart';
import 'package:ninan1/components/safe_area/page_container.dart';
import 'package:ninan1/locale/localization.dart';
import 'package:ninan1/services/access_api.dart';
import 'package:ninan1/utils/app_colors.dart';
import 'package:ninan1/utils/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ninan1/components/buttons/custom_button.dart';
import 'package:ninan1/components/dialogs/location_dialog.dart';
import 'package:ninan1/models/category.dart';
import 'package:ninan1/models/location.dart';
import 'package:ninan1/utils/app_colors.dart';
import 'package:ninan1/utils/app_colors.dart';
import 'package:ninan1/components/app_repo/progress_indicator_state.dart';
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


class MainDrawer extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return new _MainDrawer();
  }
}

class _MainDrawer extends State<MainDrawer> {
  double _height = 0 , _width = 0;
  bool isSwitched = false;
  StoreState _storeState;
  AppState _appState;
 String cc;

  Services _services = Services();
  Future<List<Location>> _locationList;
  ProgressIndicatorState _progressIndicatorState;
  bool _initialRun = true;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _storeState = Provider.of<StoreState>(context);
    _appState = Provider.of<AppState>(context);
    _progressIndicatorState = Provider.of<ProgressIndicatorState>(context);



    return Drawer(

        elevation: 0,

        child: ListView(
          children: <Widget>[



            Consumer<AppState>(builder: (context, appState, child) {

              return Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(


                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[500],
                                offset: Offset(0.0, 1.5),
                                blurRadius: 1.5,
                              ),
                            ]),

                        child: FittedBox(
                            fit: BoxFit.cover,
                            child: Image.asset("assets/images/topDrawer1.png")),

                      ),

                      Container(
                        color: Colors.white,
                        height: 60,
                      )
                    ],
                  ),
                  AnimatedPositioned(
                      duration: Duration(microseconds: 500),
                      top: 37,
                      left: MediaQuery.of(context).size.width * 0.25,
                      child:
                      Consumer<AppState>(builder: (context, appState, child) {

                        return
                          Container(

                            padding: EdgeInsets.all(15),

                            decoration: new BoxDecoration(
                              color: Colors.white,
                              border:
                              Border.all(color: Color(0xff1F61301A), width: 1.0),
                            ),

                            child:  Container(
                                width: 80,
                                height: 80,
                                alignment: Alignment.center,
                                decoration: new BoxDecoration(
                                    border:
                                    Border.all(color: Color(0xff1F61301A), width: 1.0),
                                    shape: BoxShape.circle,
                                    image:  DecorationImage(
                                        fit: BoxFit.fill,
                                        image: new NetworkImage(
                                          appState.currentUser.userPhoto,
                                        )))),
                          );

                      })),
                ],
              );
            }),



    Consumer<AppState>(builder: (context, appState, child) {


             return Container(
               decoration: BoxDecoration(
                 color: Colors.grey[100],
                 borderRadius: BorderRadius.all(
                   const Radius.circular(6.00),
                 ),

               ),
               padding: EdgeInsets.only(right: 5,left: 5),
               margin: EdgeInsets.only(right: _width*.04,left:_width*.04),

               child: Row(
                 children: <Widget>[
                   Text("استقبال الطلبات",style: TextStyle(color: Color(0xffABABAB),fontSize: 15),),
                   Spacer(),
                   Center(
                       child: Switch(

                         value: appState.currentUser.userReceveRequests=="1"?true:false,
                         onChanged: (value) async{
                           setState(() {
                             isSwitched = value;

                             if(value==true){
                               cc="1";
                             }else{
                               cc="0";
                             }
                             print(cc.toString()+"sss");
                           });

                           _progressIndicatorState.setIsLoading(true);
                           var results = await _services.get(
                               'https://ninanapp.com/app/api/driver_receveRequests?user_id=${appState.currentUser.userId}&state=$cc&lang=${appState.currentLang}');
                           _progressIndicatorState.setIsLoading(false);
                           if (results['response'] == '1') {
                             _appState.updateUserReceveRequests(cc);

                             SharedPreferencesHelper.save(
                                 "user", appState.currentUser);
                             showToast( results['message'], context);


                            // showToast(results['message'], context);

                             setState(() {

                             });


                           } else {
                             showErrorDialog(
                                 results['message'], context);
                           }

                         },
                         activeTrackColor: Colors.yellow,
                         activeColor: Colors.orangeAccent,
                       )
                   )
                 ],
               ),
             );
         }),

            Padding(padding: EdgeInsets.all(7)),



            ListTile(
              leading:Image.asset("assets/images/about.png"),
              title: Text(AppLocalizations.of(context).about,
                style: TextStyle(
                    color: Color(0xff404040),fontSize: 15
                ), ),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AboutScreen()));
              },
            ),


            Consumer<AppState>(builder: (context, appState, child) {
              return  appState.currentUser != null
                  ?  ListTile(
                onTap: (){
                  Navigator.pushNamed(context, '/personal_information_screen');
                },
                leading: Image.asset("assets/images/edit1.png"),
                title: Text( "معلومات الحساب",style: TextStyle(
                    color: Color(0xff404040),fontSize: 15
                ), ),
              ): Container();
            }),






            ListTile(
              leading: Image.asset("assets/images/walletIcon.png"),
              title: Text("المحفظة",style: TextStyle(
                  color: Color(0xff404040),fontSize: 15
              ), ),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WalletScreen()));
              },
            ),

            ListTile(
              leading: Icon(Icons.warning ,color: cPrimaryColor,),
              title: Text( AppLocalizations.of(context).terms,style: TextStyle(
                  color: Color(0xff404040),fontSize: 15
              ), ),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TermsScreen()));
              },
            ),


            ListTile(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationsScreen()));
              },
              leading:Image.asset("assets/images/lang.png"),
              title: Text( "الاشعارات"
                ,style: TextStyle(
                    color: Color(0xff404040),fontSize: 15
                ), ),
              trailing: Container(
                padding: const EdgeInsets.all(1.0),
              child: FutureBuilder<String>(
                  future: Provider.of<AppState>(context,
                      listen: false)
                      .getUnreadNotify() ,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Center(
                          child: SpinKitFadingCircle(color: cPrimaryColor),
                        );
                      case ConnectionState.active:
                        return Text('');
                      case ConnectionState.waiting:
                        return Center(
                          child: SpinKitFadingCircle(color: cPrimaryColor),
                        );
                      case ConnectionState.done:
                        if (snapshot.hasError) {
                          return Text(snapshot.error.toString(),);
                        } else {
                          return  Container(
                            alignment: Alignment.center,
                            width: 15,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red),

                            child: Text( snapshot.data.toString(),style: TextStyle(
                                color: Colors.white,fontSize: 15,height: 1.6
                            ),),
                          );
                        }
                    }
                    return Center(
                      child: SpinKitFadingCircle(color: cPrimaryColor),
                    );
                  }),
              ),
            ),


            ListTile(
              leading:Icon(Icons.phone_in_talk ,color: cPrimaryColor,),
              title: Text( AppLocalizations.of(context).contactUs,style: TextStyle(
                  color: Color(0xff404040),fontSize: 15
              ), ),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ContactWithUsScreen()));
              },
            ),
            ListTile(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LanguageScreen()));
              },
              leading:Image.asset("assets/images/lang.png"),
              title: Text( AppLocalizations.of(context).language
                ,style: TextStyle(
                    color: Color(0xff404040),fontSize: 15
                ), ),
              trailing: Text(_appState.currentLang=="ar"?"العربية":"English",style: TextStyle(color: cPrimaryColor),),
            ),
            Consumer<AppState>(builder: (context, appState, child) {
              return  appState.currentUser != null
                  ? ListTile(
                leading: Image.asset("assets/images/logout.png"),
                title: Text(
                  AppLocalizations.of(context).logOut,
                  style: TextStyle(
                      color: Color(0xff404040),fontSize: 15
                  ),
                ),
                onTap: () {
                  showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (_) {
                        return LogoutDialog(
                          alertMessage: AppLocalizations.of(context).wantToLogout,
                        );
                      });
                },
              )
                  : ListTile(
                leading: Transform.rotate(
                  angle: 180 * math.pi / 180,
                  child: Icon(
                    FontAwesomeIcons.signInAlt,
                    color: cPrimaryColor,
                    size: 22,
                  ),
                ),
                title: Text(
                    AppLocalizations.of(context).enter,
                    style: TextStyle(
                        color: cBlack,fontSize: 15
                    )
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/login_screen');
                },
              );
            })
          ],
        ));



  }
}
