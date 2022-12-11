import 'package:flutter/material.dart';
import 'package:ninan1/components/MainDrawer.dart';
import 'package:ninan1/components/app_repo/store_state.dart';
import 'package:ninan1/screens/orders/components/done_orders.dart';
import 'package:ninan1/screens/orders/components/filter_done_orders.dart';
import 'package:ninan1/screens/orders/components/filter_processing_orders.dart';
import 'package:ninan1/screens/orders/components/mtger_filter_done_orders.dart';
import 'package:ninan1/screens/orders/components/mtger_filter_processing_orders.dart';
import 'package:ninan1/screens/orders/components/processing_orders.dart';
import 'package:provider/provider.dart';
import 'package:ninan1/components/app_repo/app_state.dart';
import 'package:ninan1/components/app_repo/tab_state.dart';
import 'package:ninan1/components/connectivity/network_indicator.dart';
import 'package:ninan1/components/gradient_app_bar/gradient_app_bar1.dart';
import 'package:ninan1/components/not_registered/not_registered.dart';
import 'package:ninan1/components/progress_indicator_component/progress_indicator_component.dart';
import 'package:ninan1/components/safe_area/page_container.dart';
import 'package:ninan1/locale/localization.dart';
import 'package:ninan1/screens/orders/components/mtger_done_orders.dart';
import 'package:ninan1/screens/orders/components/mtger_processing_orders.dart';
import 'package:ninan1/utils/app_colors.dart';
import 'package:ninan1/components/MtgerMainDrawer.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
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
                 ProcessingOrders(),
                 DoneOrders(),
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
                                "الطلبات الحالية"
                            ),
                            Text("الطلبات السابقة"),

                          ],
                        )),
                  ):Text("")

                  ,  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: GradientAppBar1(
                      leading: GestureDetector(
                        onTap: (){
                          _scaffoldKey.currentState.openDrawer();
                        },
                        child: Container(child: Image.asset("assets/images/menu.png"),
                          padding: EdgeInsets.only(top: 15,right: 10),
                        ),
                      ),
                      appBarTitle: AppLocalizations.of(context).orders,

                      trailing: storeState.currentStore!= null?IconButton(
                        icon: Image.asset("assets/images/filter.png"),
                        onPressed: () {

                          if(tabState.initialIndex==0){
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
                                    child: FilterProcessingOrders(),
                                  );
                                });
                          }else{
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
                                    child: FilterDoneOrders(),
                                  );
                                });
                          }

                        },
                      ):Text(""),

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
