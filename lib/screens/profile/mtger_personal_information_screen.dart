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
import 'package:ninan1/screens/profile/mtger_modify_password_screen.dart';
import 'package:ninan1/screens/profile/mtger_modify_personal_info_screen.dart';
import 'package:ninan1/utils/app_colors.dart';

class MtgerPersonalInformationScreen extends StatefulWidget {
  @override
  _MtgerPersonalInformationScreenState createState() =>
      _MtgerPersonalInformationScreenState();
}

class _MtgerPersonalInformationScreenState extends State<MtgerPersonalInformationScreen> {
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
    return Consumer<StoreState>(builder: (buildContext, storeState, child) {
      return Column(
        children: <Widget>[

        Container(
          height: _height*.88,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
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
                      child: Image.network(storeState.currentStore.mtgerPhoto),
                    ),
                  ),
                ),
                _buildRow(
                  "اسم المتجر بالعربية",
                  storeState.currentStore.mtgerName!=null?storeState.currentStore.mtgerName:"",
                ),


                _buildRow(
                  "اسم المتجر بالانجليزية",
                  storeState.currentStore.mtgerNameEn!=null?storeState.currentStore.mtgerNameEn:"",
                ),

                _buildRow(
                  "وصف المتجر",
                  storeState.currentStore.mtgerCatName!=null?storeState.currentStore.mtgerCatName:"",
                ),


                _buildRow(
                  "رقم الهاتف",
                  storeState.currentStore.mtgerPhone!=null?storeState.currentStore.mtgerPhone:"",
                ),

                _buildRow(
                  "البريد الالكتروني",
                  storeState.currentStore.mtgerEmail!=null?storeState.currentStore.mtgerEmail:"",
                ),

                _buildRow(
                  "العنوان بالعربية",
                  storeState.currentStore.mtgerAdress!=null?storeState.currentStore.mtgerAdress:"",
                ),


                _buildRow(
                  "العنوان بالانجليزية",
                  storeState.currentStore.mtgerAdressEn!=null?storeState.currentStore.mtgerAdressEn:"",
                ),


                _buildRow(
                  " رقم السجل التجاري",
                  storeState.currentStore.mtgerSgl!=null?storeState.currentStore.mtgerSgl:"",
                ),

                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(top: _width*.04,right: _width*.04,bottom: _width*.02),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("صورة السجل",style: TextStyle(
                          color: Color(0xffABABAB), fontSize: 14, fontWeight: FontWeight.w400),),
                      Padding(padding: EdgeInsets.all(5)),
                      Image.network(storeState.currentStore.mtgerSglPhoto,width: _width,height: _width*.3,alignment: Alignment.centerRight,)
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
                      Text("صورة الغلاف",style: TextStyle(
                          color: Color(0xffABABAB), fontSize: 14, fontWeight: FontWeight.w400),),
                      Padding(padding: EdgeInsets.all(5)),
                      Image.network(storeState.currentStore.mtgerPhoto1,width: _width,height: _width*.3,alignment: Alignment.centerRight,)
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
                                    MtgerModifyPersonalInformationScreen()));
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
