import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:ninan1/components/MainDrawer.dart';
import 'package:ninan1/components/app_repo/store_state.dart';
import 'package:ninan1/screens/profile/personal1.dart';
import 'package:ninan1/screens/profile/personal2.dart';
import 'package:provider/provider.dart';
import 'package:ninan1/components/app_repo/app_state.dart';
import 'package:ninan1/components/app_repo/tab_state.dart';
import 'package:ninan1/components/connectivity/network_indicator.dart';
import 'package:ninan1/components/gradient_app_bar/gradient_app_bar.dart';
import 'package:ninan1/components/not_registered/not_registered.dart';
import 'package:ninan1/components/safe_area/page_container.dart';
import 'package:ninan1/utils/app_colors.dart';

class PersonalInformationScreen extends StatefulWidget {
  @override
  _PersonalInformationScreenState createState() => _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  double _height,_width;
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _buildBodyItem() {
    return  Consumer<AppState>(builder: (context, appState, child) {
      return  appState.currentUser != null
          ?  ListView(
        children: <Widget>[
          Container(
            height: _height,
            child: TabBarView(
              children: [
                Personal1Screen(),
                Personal2Screen(),
              ],
            ),
          )
        ],
      ) :  NotRegistered();
    });
  }

  @override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    TabState tabState = Provider.of<TabState>(context);
    AppState appState = Provider.of<AppState>(context);
    StoreState storeState = Provider.of<StoreState>(context);

    return  NetworkIndicator( child:PageContainer(
      child: RefreshIndicator(child: DefaultTabController(
          initialIndex: tabState.initialIndex,
          length: 2,
          child: Scaffold(
              key: _scaffoldKey, //
              drawer: MainDrawer(),
              body: Stack(

                children: <Widget>[
                  _buildBodyItem(),
                  appState.currentUser != null?Positioned(
                    top: 50,
                    child:   Container(
                        margin: EdgeInsets.only(right: _width*.02,left: _width*.02),
                        decoration: BoxDecoration(
                            color: Color(0xffF9F9F9),
                            borderRadius: BorderRadius.circular(
                              6.0,
                            )),
                        width: _width*.95,
                        height: 40,

                        child: TabBar(
                          indicator: BoxDecoration(
                              color: cPrimaryColor), //Ch
                          labelStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              fontFamily: 'segoeui'),
                          unselectedLabelColor: Color(0xffBEBEBE),
                          unselectedLabelStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'segoeui'),
                          labelColor: Colors.white,
                          indicatorColor: Colors.white,
                          onTap: (index){

                            tabState.upadateInitialIndex(index);
                            if(tabState.initialIndex==0){
                              appState.setCurrentFilterOrders(10);
                            }else{
                              appState.setCurrentFilterOrders(11);
                            }

                          },
                          tabs: [
                            Text(
                                "المعلومات الشخصية"
                            ),
                            Text("معلومات المركبة"),

                          ],
                        )),
                  ):Text("")

                  ,  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: GradientAppBar(
            leading: appState.currentLang == 'ar' ? IconButton(
                icon: Image.asset('assets/images/back.png'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ) :Container(),
              trailing: appState.currentLang == 'en' ? IconButton(
                icon: Transform.rotate(
                   angle: -math.pi / 1,
                child: Image.asset('assets/images/back.png'),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ) :Container(),
                      appBarTitle:"معلومت الحساب",




                    ),
                  ),


                ],
              ))),
        onRefresh: () async {
          setState(() {});
        },
      ),
    ));
  }
}
