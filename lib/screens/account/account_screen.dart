import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ninan1/components/app_repo/app_state.dart';
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

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {


double _height,_width;

Widget _buildBodyItem(){
  return ListView(
    children: <Widget>[
      SizedBox(
        height: 50,
      ),
       Consumer<AppState>(builder: (context, appState, child) {
       return  appState.currentUser != null
            ?  Container(
         height: _height *0.1,
         child: ListTile(
           onTap: (){
             Navigator.pushNamed(context, '/personal_information_screen');
           },
           leading: Icon(Icons.edit ,color: cPrimaryColor,),
           title: Text( AppLocalizations.of(context).personalInfo,style: TextStyle(
             color: cBlack,fontSize: 15
           ), ),
         ),
       ): Container();
       }),
       Container(
         color: Color(0xffFBF6F6),
         height: _height *0.1,
         child: ListTile(
           leading:Icon(Icons.help ,color: cPrimaryColor,),
           title: Text(AppLocalizations.of(context).about,
           style: TextStyle(
             color: cBlack,fontSize: 15
           ), ),
           onTap: (){
               Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AboutScreen()));
           },
         ),
       ),
        Container(
         height: _height *0.1,
         child: ListTile(
           leading: Icon(Icons.warning ,color: cPrimaryColor,),
           title: Text( AppLocalizations.of(context).terms,style: TextStyle(
             color: cBlack,fontSize: 15
           ), ),
            onTap: (){
               Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TermsScreen()));
           },
         ),
       ),
        Container(
         color: Color(0xffFBF6F6),
         height: _height *0.1,
         child: ListTile(
           leading:Icon(Icons.phone_in_talk ,color: cPrimaryColor,),
           title: Text( AppLocalizations.of(context).contactUs,style: TextStyle(
             color: cBlack,fontSize: 15
           ), ),
            onTap: (){
               Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ContactWithUsScreen()));
           },
         ),
       ),
        Container(
         height: _height *0.1,
         child: ListTile(
             onTap: (){
               Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LanguageScreen()));
           },
           leading: Icon(FontAwesomeIcons.language,color: cPrimaryColor,),
           title: Text( AppLocalizations.of(context).language
           ,style: TextStyle(
             color: cBlack,fontSize: 15
           ), ),
         ),
       ),
        Container(
         color: Color(0xffFBF6F6),
         height: _height *0.1,
         child: Consumer<AppState>(builder: (context, appState, child) {
       return  appState.currentUser != null
            ? ListTile(
                leading: Icon(
                  FontAwesomeIcons.signInAlt,
                  color: cPrimaryColor,
                  size: 22,
                ),
                title: Text(
                AppLocalizations.of(context).logOut,
                style: TextStyle(
             color: cBlack,fontSize: 15
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
              }))
    ],
  );
}

 @override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;

    return  NetworkIndicator( child:PageContainer(
      child: Scaffold(
          backgroundColor: cWhite
,          body: Stack(
            children: <Widget>[
         _buildBodyItem() ,
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: GradientAppBar(
                  appBarTitle:  AppLocalizations.of(context).account,


                ),
              ),

            ],
          )),
    ));
  }
}