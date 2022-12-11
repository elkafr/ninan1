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

class Personal1Screen extends StatefulWidget {
  @override
  _Personal1ScreenState createState() =>
      _Personal1ScreenState();
}

class _Personal1ScreenState extends State<Personal1Screen> {
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
                  Container(
                    width: _width*.45,
                    color: cOmarColor,
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: _width*.04,right: _width*.04,bottom: _width*.02),
                    child:     CircleAvatar(
                      radius: 45,
                      child: ClipOval(
                        child: Image.network(appState.currentUser.userPhoto),
                      ),
                    ),
                  ),
                  _buildRow(
                    "الاسم بالعربية",
                    appState.currentUser.userName!=null?appState.currentUser.userName:"",
                  ),


                  _buildRow(
                    "الاسم بالانجليزية",
                    appState.currentUser.userNameEn!=null?appState.currentUser.userNameEn:"",
                  ),

                  _buildRow(
                    "رقم الهاتف",
                    appState.currentUser.userPhone!=null?appState.currentUser.userPhone:"",
                  ),


                  _buildRow(
                    " الايميل",
                    appState.currentUser.userEmail!=null?appState.currentUser.userEmail:"",
                  ),

                  _buildRow(
                    "الجنسية",
                    appState.currentUser.userCountry!=null?appState.currentUser.userCountry:"",
                  ),

                  _buildRow(
                    "المدينة",
                    appState.currentUser.userCity!=null?appState.currentUser.userCity:"",
                  ),


                  _buildRow(
                    "رقم الهوية",
                    appState.currentUser.userIdentifyNumber!=null?appState.currentUser.userIdentifyNumber:"",
                  ),


                  _buildRow(
                    " اسم البنك",
                    appState.currentUser.userBank!=null?appState.currentUser.userBank:"",
                  ),

                  _buildRow(
                    " رقم الحساب",
                    appState.currentUser.userAcount!=null?appState.currentUser.userAcount:"",
                  ),

                  _buildRow(
                    " رقم الايبان",
                    appState.currentUser.userIban!=null?appState.currentUser.userIban:"",
                  ),

                  Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(top: _width*.04,right: _width*.04,bottom: _width*.02),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(" صورة الهوية",style: TextStyle(
                            color: Color(0xffABABAB), fontSize: 14, fontWeight: FontWeight.w400),),
                        Padding(padding: EdgeInsets.all(5)),
                        Image.network(appState.currentUser.userIdentifyPhoto,width: _width,height: _width*.3,alignment: Alignment.centerRight,)
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
                  appBarTitle: "معلومات الحساب",
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
