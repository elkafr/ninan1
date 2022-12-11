import 'package:flutter/material.dart';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ninan1/components/app_data/shared_preferences_helper.dart';
import 'package:ninan1/components/app_repo/app_state.dart';
import 'package:ninan1/components/app_repo/navigation_state.dart';
import 'package:ninan1/components/connectivity/network_indicator.dart';
import 'package:ninan1/locale/localization.dart';
import 'package:ninan1/models/user.dart';
import 'package:ninan1/utils/app_colors.dart';
import 'package:ninan1/components/app_repo/location_state.dart';
import 'package:ninan1/components/MainDrawer.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';


class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  bool _initialRun = true;
  AppState _appState;
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  NavigationState _navigationState;
  LocationData _locData;
  LocationState _locationState;

  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  new FlutterLocalNotificationsPlugin();

  void _iOSPermission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  void _firebaseCloudMessagingListeners() {
    var android = new AndroidInitializationSettings('mipmap/ic_launcher');
    var ios = new IOSInitializationSettings();
    var platform = new InitializationSettings(android: android, iOS: ios);
    _flutterLocalNotificationsPlugin.initialize(platform);

    if (Platform.isIOS) _iOSPermission();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
        _showNotification(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');

        Navigator.pushNamed(context, '/notification_screen');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');

        Navigator.pushNamed(context, '/notification_screen');
      },
    );
  }

  _showNotification(Map<String, dynamic> message) async {
    var android = new AndroidNotificationDetails(
      'channel id',
      "CHANNLE NAME",
      "channelDescription",
    );
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);
    await _flutterLocalNotificationsPlugin.show(
        0,
        message['notification']['title'],
        message['notification']['body'],
        platform);
  }

  Future<Null> _checkIsLogin() async {
    var userData = await SharedPreferencesHelper.read("user");

    if (userData != null) {
      _appState.setCurrentUser(User.fromJson(userData));
      _firebaseCloudMessagingListeners();
    }
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
  //   }
  //     else if (!results['status'] &&
  //                       results['statusCode'] == 401) {
  //                     handleUnauthenticated(context);
  //                   } else {
  //                        showErrorDialog(results['msg'], context);
  //                   }
  // }




  Future<void> _getCurrentUserLocation() async {

    _locData = await Location().getLocation();
    print(_locData.latitude);
    print(_locData.longitude);
      _locationState.setLocationLatitude(_locData.latitude);
      _locationState.setLocationlongitude(_locData.longitude);
      List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(
          _locationState.locationLatitude, _locationState
          .locationlongitude);
      _locationState.setCurrentAddress(placemark[0].name + '  ' + placemark[0].administrativeArea + ' '
          + placemark[0].country);
      //  final coordinates = new Coordinates(_locationState.locationLatitude, _locationState
      //  .locationlongitude);
      // var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      // var first = addresses.first;

      // _locationState.setCurrentAddress(first.addressLine);


      // print("${first.featureName} : ${first.addressLine}");




  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _initialRun = false;
      _appState = Provider.of<AppState>(context);
      _locationState = Provider.of<LocationState>(context);
      _checkIsLogin();
      _getCurrentUserLocation();
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    _navigationState = Provider.of<NavigationState>(context);
    return NetworkIndicator(
        child: Scaffold(
          key: _scaffoldKey, //

          drawer: MainDrawer(),
      body: _navigationState.selectedContent,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _navigationState.navigationIndex==0?Image.asset("assets/images/home.png"):Image.asset("assets/images/home.png",color: Color(0xffBEBEBE),),
            title: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  AppLocalizations.of(context).home,
                  style: TextStyle(fontSize: 14.0),
                )),
          ),
           BottomNavigationBarItem(
            icon: _navigationState.navigationIndex==1?Image.asset("assets/images/orders.png",color: cPrimaryColor,):Image.asset("assets/images/orders.png"),
            title: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
               AppLocalizations.of(context).orders,
                  style: TextStyle(fontSize: 14.0),
                )),
          ),

          BottomNavigationBarItem(
            icon: _navigationState.navigationIndex==2?Image.asset("assets/images/offers.png",color: cPrimaryColor,):Image.asset("assets/images/offers.png"),
            title: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  "العروض",
                  style: TextStyle(fontSize: 14.0),
                )),
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            
            title: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  AppLocalizations.of(context).favourite,
                  style: TextStyle(fontSize: 14.0),
                )),
          ),

            BottomNavigationBarItem(
           icon:_navigationState.navigationIndex==4?Image.asset("assets/images/more.png",color: cPrimaryColor,):Image.asset("assets/images/more.png"),
            title: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  "المزيد",
                  style: TextStyle(fontSize: 14.0),
                )),
          )
        ],
        currentIndex: _navigationState.navigationIndex,
        selectedItemColor: cPrimaryColor,
        unselectedItemColor: Color(0xFFC4C4C4),
        onTap: (int index) {
          if(index==4){
            _navigationState.upadateNavigationIndex(index);
            _scaffoldKey.currentState.openDrawer();
          }else{
            _navigationState.upadateNavigationIndex(index);
          }


        },
        elevation: 5,
        backgroundColor: cWhite,
        type: BottomNavigationBarType.fixed,
      ),
    ));
  }
}
