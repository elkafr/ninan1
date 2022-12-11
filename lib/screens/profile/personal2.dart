import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ninan1/components/app_repo/store_state.dart';
import 'package:provider/provider.dart';
import 'package:ninan1/utils/app_colors.dart';
import 'package:ninan1/components/app_repo/app_state.dart';
import 'package:ninan1/components/buttons/custom_button.dart';
import 'package:ninan1/components/connectivity/network_indicator.dart';
import 'package:ninan1/components/gradient_app_bar/gradient_app_bar.dart';
import 'package:ninan1/components/horizontal_divider/horizontal_divider.dart';
import 'package:ninan1/components/safe_area/page_container.dart';
import 'package:ninan1/locale/localization.dart';
import 'package:ninan1/screens/profile/modify_password_screen.dart';
import 'package:ninan1/screens/profile/modify_personal_info_screen.dart';
import 'package:ninan1/utils/app_colors.dart';

class Personal2Screen extends StatefulWidget {
  @override
  _Personal2ScreenState createState() =>
      _Personal2ScreenState();
}

class _Personal2ScreenState extends State<Personal2Screen> {
  double _height, _width;
  AppState _appState;
  StoreState _storeState;


  Widget _buildRow(String title, String value) {
    return Column(
      children: <Widget>[
        ListTile(
          title :    Text(
            title,
            style: TextStyle(
                color: Color(0xffABABAB), fontSize: 14, fontWeight: FontWeight.w400),
          ),
          subtitle:       Text(
            value,
            style: TextStyle(
                color: cText, fontSize: 15, fontWeight: FontWeight.w400),
          ),

        ),
        Container(
            margin: EdgeInsets.only(right: _width*.04,left: _width*.04),
            height: 1,color: Colors.grey[200]
        )
      ],
    );
  }

  Widget _buildBodyItem() {
    return Consumer<AppState>(builder: (buildContext, appState, child) {
      return Column(
        children: <Widget>[

          Container(
            height: _height*.85,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),


                  _buildRow(
                    "نوع المركية",
                    appState.currentUser.carType!=null?appState.currentUser.carType:"",
                  ),


                  _buildRow(
                    "رقم اللوحة",
                    appState.currentUser.carNumber!=null?appState.currentUser.carNumber:"",
                  ),

                  _buildRow(
                    " رقم رخصة السيارة",
                    appState.currentUser.carLicenceNumber!=null?appState.currentUser.carLicenceNumber:"",
                  ),


                  _buildRow(
                    " رقم رخصة القيادة",
                    appState.currentUser.carLicence1Number!=null?appState.currentUser.carLicence1Number:"",
                  ),

                  _buildRow(
                    "رقم تأمين المركية",
                    appState.currentUser.carInsurance!=null?appState.currentUser.carInsurance:"",
                  ),














                  Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(top: _width*.04,right: _width*.04,bottom: _width*.02),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(" صورة رخصة السيارة",style: TextStyle(
                            color: Color(0xffABABAB), fontSize: 14, fontWeight: FontWeight.w400),),
                        Padding(padding: EdgeInsets.all(5)),
                        Image.network(appState.currentUser.carLicencePhoto,width: _width,height: _width*.3,alignment: Alignment.centerRight,)
                      ],
                    ),
                  ),





                  Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(top: _width*.04,right: _width*.04,bottom: _width*.02),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(" صورة رخصة القيادة",style: TextStyle(
                            color: Color(0xffABABAB), fontSize: 14, fontWeight: FontWeight.w400),),
                        Padding(padding: EdgeInsets.all(5)),
                        Image.network(appState.currentUser.carLicence1Photo,width: _width,height: _width*.3,alignment: Alignment.centerRight,)
                      ],
                    ),
                  ),






                ],
              ),
            ),
          ),




          Spacer(),
          Divider(),
          Row(
            children: <Widget>[

              Container(
                  margin: EdgeInsets.only(bottom: _height * 0.01),
                  height: 60,
                  width: _width,
                  child: CustomButton(

                      btnLbl:"طلب تحديث معلومات",
                      onPressedFunction: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ModifyPersonalInformationScreen()));
                      })),


            ],
          )
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _appState = Provider.of<AppState>(context);
    _storeState = Provider.of<StoreState>(context);

    return NetworkIndicator( child: PageContainer(
      child: Scaffold(

          body: Stack(
            children: <Widget>[
              _buildBodyItem(),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: GradientAppBar(
                  appBarTitle: "معلومت الحساب",
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
            ],
          )),
    ));
  }
}
