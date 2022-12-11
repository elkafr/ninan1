import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:ninan1/components/app_repo/app_state.dart';
import 'package:ninan1/components/connectivity/network_indicator.dart';
import 'package:ninan1/components/gradient_app_bar/gradient_app_bar.dart';
import 'package:ninan1/components/no_data/no_data.dart';
import 'package:ninan1/components/not_registered/not_registered.dart';
import 'package:ninan1/components/response_handling/response_handling.dart';
import 'package:ninan1/components/safe_area/page_container.dart';
import 'package:ninan1/locale/localization.dart';
import 'package:ninan1/models/notification_item.dart';
import 'package:ninan1/services/access_api.dart';
import 'package:ninan1/utils/app_colors.dart';
import 'package:ninan1/utils/utils.dart';
import 'dart:math' as math;


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ninan1/components/app_repo/location_state.dart';

import 'package:ninan1/components/buttons//custom_button.dart';
import 'package:ninan1/components/response_handling/response_handling.dart';
import 'package:ninan1/screens/home/home_screen.dart';


import 'package:ninan1/components/safe_area/page_container.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';



class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  var _height, _width;
  Services _services = Services();
 Future<List<NotificationItem>> _notificationList;
  AppState _appState;
  bool _initialRun = true;

  Future<List<NotificationItem>> _getNotifications() async {
    Map<String, dynamic> results =
        await _services.get('https://ninanapp.com/app/api/getNotify?page=1&user_id=${_appState.currentUser.userId}&user_type=driver&view=1&lang=${_appState.currentLang}');
    List notificationsList = List<NotificationItem>();

    if (results['response'] == '1') {
      Iterable iterable = results['results'];
      notificationsList = iterable.map((model) => NotificationItem.fromJson(model)).toList();
    } else {
      print('error');
    }
    return notificationsList;
  }

  // Future<Null> _getUnreadNotificationNum() async {
  //   Map<String, dynamic> results =
  //       await _services.get(Utils.NOTIFICATION_UNREAD_URL, header: {
  //     'Accept': 'application/json',
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer ${_appState.currentUser.token}'
  //   });

  //   if (results['status']) {
  //     print(results['data']);

  //     _appState.updateNotification(results['data']['count']);
  //   } else if (!results['status'] && results['statusCode'] == 401) {
  //     handleUnauthenticated(context);
  //   } else {
  //     showErrorDialog(results['msg'], context);
  //   }
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _appState = Provider.of<AppState>(context);
      if (_appState.currentUser != null) {
       _notificationList = _getNotifications();
        // _getUnreadNotificationNum();
      }
      _initialRun = false;
    }
  }

  Widget _buildBodyItem() {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    return Consumer<AppState>(builder: (context, appState, child) {
      return _appState.currentUser != null
          ? FutureBuilder<List<NotificationItem>>(
              future: _notificationList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.length > 0) {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {

                               return Dismissible(
                                  // Each Dismissible must contain a Key. Keys allow Flutter to
                                  // uniquely identify widgets.
                                    key: Key(snapshot.data[index].id),
                                    // Provide a function that tells the app
                                    // what to do after an item has been swiped away.

                                    onDismissed: (direction) async {

                                      // Remove the item from the data source.
                                      await _services.get("https://ninanapp.com/app/api/delete_notify?user_id=${_appState.currentUser.userId}&notify_id=${snapshot.data[index].id}");
                                      setState(() {
                                        snapshot.data.removeAt(index);
                                      });
                                    },
                                    // Show a red background as the item is swiped away.
                                    direction: DismissDirection.startToEnd,

                                    background: Container(
                                      color: Colors.red,
                                      child: Row(
                                        children: <Widget>[
                                          Padding(padding: EdgeInsets.all(10)),
                                          Image.asset(
                                            "assets/images/close.png",color: Colors.white,alignment: Alignment.centerRight,
                                          ),
                                          Padding(padding: EdgeInsets.all(3)),
                                          Text("حذف",style: TextStyle(color: Colors.white),)
                                        ],
                                      ),
                                    ),
                                    child: Container(
                      
                                      decoration: BoxDecoration(
                                   color: snapshot.data[index].view=="0"?(0xffF9F9F9):Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(6.00),
                                ),
                                border: Border.all(color:Color(0xff707070).withOpacity(0.10) )
                                ),

                             margin: EdgeInsets.only(bottom: _width*.02,right: _width*.03,left: _width*.03),
                             padding: EdgeInsets.all(10),
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(
                                      Icons.notifications_active,
                                      color: cLightLemon,
                                    ),
                                    SizedBox(
                                      width: _width * 0.03,
                                    ),
                                    Flexible(
                                      child: RichText(

                                        text: TextSpan(
                                            text: snapshot
                                                .data[index].title,
                                            style: TextStyle(
                                                color: cText,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.0),
                                            children: <TextSpan>[

                                            ]),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: _width *0.12
                            ),
                            child:  Text(snapshot
                                .data[index].body,
                          style: TextStyle(
                            color: Color(0xffA7A7A7),
                            fontSize: 14,fontWeight: FontWeight.w400
                          ),),
                          ),
                    
                            ],
                          ),
                          ));

                    
                        });
                  } else {
                    return NoData(
                      message: AppLocalizations.of(context).noNotifications,
                    );
                  }
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return Center(
                    child: SpinKitThreeBounce(
                  color: cPrimaryColor,
                  size: 40,
                ));
              },
            )
          :  NotRegistered();
    });
  }

  @override
  Widget build(BuildContext context) {
       _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
      return  NetworkIndicator( child:PageContainer(
      child: Scaffold(
        backgroundColor: cWhite,
          body: Stack(
            children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(height: 50,),
                 Container(
                   height: _height  - 50,
                   width: _width,
                   child:  _buildBodyItem(),
                 )
              ],
            ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: GradientAppBar(
                  appBarTitle: AppLocalizations.of(context).notifications,

         leading: _appState.currentLang == 'ar' ? IconButton(
                icon: Image.asset('assets/images/back.png'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ) :Container(),
              trailing: _appState.currentLang == 'en' ? IconButton(
                icon: Transform.rotate(
                   angle: -math.pi / 1,
                child: Image.asset('assets/images/back.png'),
                ),
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
