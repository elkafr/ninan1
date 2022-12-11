import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ninan1/screens/home/components/filter_open.dart';
import 'package:ninan1/screens/mtger_wallet/wallet_screen.dart';
import 'package:ninan1/screens/notifications/mtger_notifications_screen.dart';
import 'package:ninan1/screens/notifications/notifications_screen.dart';
import 'package:provider/provider.dart';
import 'package:ninan1/components/app_repo/app_state.dart';
import 'package:ninan1/components/app_repo/store_state.dart';
import 'package:ninan1/components/connectivity/network_indicator.dart';
import 'package:ninan1/components/dialogs/log_out_dialog1.dart';
import 'package:ninan1/components/gradient_app_bar/gradient_app_bar.dart';
import 'package:ninan1/components/safe_area/page_container.dart';
import 'package:ninan1/locale/localization.dart';
import 'package:ninan1/screens/account/about_screen.dart';
import 'package:ninan1/screens/account/contact_with_us_screen.dart';
import 'package:ninan1/screens/account/language_screen.dart';
import 'package:ninan1/screens/account/terms_screen.dart';
import 'package:ninan1/utils/app_colors.dart';
import 'dart:math' as math;

class MtgerMainDrawer extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return new _MtgerMainDrawer();
  }
}

class _MtgerMainDrawer extends State<MtgerMainDrawer> {
  double _height = 0 , _width = 0;
  bool isSwitched = false;
 StoreState _storeState;
 AppState _appState;


  @override
  Widget build(BuildContext context) {

    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _storeState = Provider.of<StoreState>(context);
    _appState = Provider.of<AppState>(context);

      return Drawer(

          elevation: 0,

          child: ListView(
            children: <Widget>[



              Consumer<StoreState>(builder: (context, storeState, child) {
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
                        Consumer<StoreState>(builder: (context, storeState, child) {

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
                                            storeState.currentStore.mtgerPhoto,
                                          )))),
                            );

                        })),
                  ],
                );
              }),




            /*  Container(
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

                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                        print(isSwitched);
                      });
                    },
                    activeTrackColor: Colors.yellow,
                    activeColor: Colors.orangeAccent,
                  )
                )
                 ],
               ),
              ),   */


            Padding(padding: EdgeInsets.all(7)),

         Consumer<StoreState>(builder: (context, storeState, child) {
           return Container(
             decoration: BoxDecoration(
               color: Colors.grey[100],
               borderRadius: BorderRadius.all(
                 const Radius.circular(6.00),
               ),

             ),
             padding: EdgeInsets.only(right: 5,left: 5,top: 10,bottom: 10),
             margin: EdgeInsets.only(right: _width*.04,left:_width*.04),

             child: GestureDetector(
               onTap: (){
                 Navigator.pop(context);
                 showModalBottomSheet<dynamic>(
                     isScrollControlled: true,
                     shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.only(
                             topLeft: Radius.circular(20),
                             topRight: Radius.circular(20))),
                     context: context,
                     builder: (builder) {
                       return Container(
                         height: _height*.50,
                         child: FilterOpen(),
                       );
                     });
               },
               child: Row(
                 children: <Widget>[
                   Text("حالة المتجر",style: TextStyle(color: Color(0xffABABAB),fontSize: 15),),
                   Spacer(),

                   Container(
                     alignment: Alignment.center,
                     padding: EdgeInsets.all(6),
                     decoration: BoxDecoration(
                         color: cWhite,
                         borderRadius: BorderRadius.only(
                           topLeft: Radius.circular(4.00),
                           topRight: Radius.circular(4.00),
                           bottomLeft: Radius.circular(4.00),
                           bottomRight: Radius.circular(4.00),
                         ),
                         border: Border.all(color: cPrimaryColor)),
                     child: Text(storeState.currentStore != null?storeState.currentStore.mtgerState:""),
                   )
                 ],
               ),
             ),
           );
          }),

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


              Consumer<StoreState>(builder: (context, storeState, child) {
                return  storeState.currentStore != null
                    ?  ListTile(
                  onTap: (){
                    Navigator.pushNamed(context, '/mtger_personal_information_screen');
                  },
                  leading: Image.asset("assets/images/edit1.png"),
                  title: Text( "معلومات الحساب",style: TextStyle(
                      color: Color(0xff404040),fontSize: 15
                  ), ),
                ): Container();
              }),


              Consumer<StoreState>(builder: (context, storeState, child) {
                return  storeState.currentStore != null
                    ?  ListTile(
                  onTap: (){
                    _storeState.setCurrentStore(storeState.currentStore);
                    Navigator.pushNamed(context, '/store_screen');
                  },
                  leading: Image.asset("assets/images/store1.png"),
                  title: Text("إدارة المتجر",style: TextStyle(
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
                          builder: (context) => MtgerNotificationsScreen()));
                },
                leading:Image.asset("assets/images/lang.png"),
                title: Text( "الاشعارات"
                  ,style: TextStyle(
                      color: Color(0xff404040),fontSize: 15
                  ), ),
                trailing: Text(_appState.currentLang=="ar"?"العربية":"English",style: TextStyle(color: cPrimaryColor),),
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
              Consumer<StoreState>(builder: (context, storeState, child) {
                return  storeState.currentStore != null
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
                          return LogoutDialog1(
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
