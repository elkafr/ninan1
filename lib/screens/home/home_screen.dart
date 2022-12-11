
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ninan1/components/app_repo/location_state.dart';
import 'package:ninan1/screens/home/components/home_appbar.dart';
import 'package:ninan1/screens/home/components/select_location.dart';
import 'package:ninan1/screens/home/home1_screen.dart';
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

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  double _height;
  double _width;
  Future<List<Category>> _categoriesList;
  Future<List<Store>> _storeList;
  Services _services = Services();
  bool _enableSearch = false;
  String _categoryId = '1';
  StoreState _storeState;
  AppState _appState;
  LocationState _locationState;
  bool _initialRun = true;
    FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
       FlutterLocalNotificationsPlugin();

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
    _firebaseMessaging.onTokenRefresh.listen((newToken) async {
      print('newToken: $newToken');
                await _services.get(
                                  'https://ninanapp.com/app/api/push?user_id=${_appState.currentUser.userId}&token=$newToken');
    });
    if (Platform.isIOS) _iOSPermission();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
        _showNotification(message);
      
      },

      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');

        Navigator.pushNamed(context, '/notifications_screen');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');

        Navigator.pushNamed(context, '/notifications_screen');
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

  Future<List<Category>> _getCategories() async {
    String language =  await SharedPreferencesHelper.getUserLang();
    Map<String, dynamic> results = await _services.get(Utils.CATEGORIES_URL+ language);
    List categoryList = List<Category>();
    if (results['response'] == '1') {
      Iterable iterable = results['cats'];
      categoryList = iterable.map((model) => Category.fromJson(model)).toList();
      categoryList[0].isSelected = true;
    } else {
      print('error');
    }
    return categoryList;
  }

  Future<List<Store>> _getStores(String specificCategory) async {
    Map<String, dynamic> results =
        await _services.get(Utils.BASE_URL + specificCategory);
    List<Store> storeList = List<Store>();
    if (results['response'] == '1') {
      Iterable iterable = results['results'];
      storeList = iterable.map((model) => Store.fromJson(model)).toList();
      if (_appState.currentUser != null) {
// app favourite list on consume on it
        for (int i = 0; i < storeList.length; i++) {
          print('id: ${storeList[i].mtgerId} : favourite ${storeList[i].isAddToFav}');
          _storeState.setIsFavourite(
              storeList[i].mtgerId, storeList[i].isAddToFav);
        }
      }
    } else {
      print('error');
    }
    return storeList;
  }

  Widget _buildCategoriesList() {
    return LayoutBuilder(builder: (context, constraints) {
      return FutureBuilder<List<Category>>(
        future: _categoriesList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              itemCount: snapshot.data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: (6 / 5),
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
              ),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: (){

                      _appState.setSelectedCat(snapshot.data[index]);
                      _appState.setCurrentFilter(1);
                      _appState.setSelectedCatName(snapshot.data[index].mtgerCatName);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Home1Screen(

                            )));
                  },
                  child: CategoryItem1(
                    category: snapshot.data[index],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return Center(
              child: SpinKitSquareCircle(color: cPrimaryColor, size: 25));
        },
      );
    });
  }




  Widget _buildBodyItem() {
    return ListView(
      children: <Widget>[
       SizedBox(
         height: _width*.29,
       ),
    Container(

    margin: EdgeInsets.only(right: _width*.01,left:  _width*.01),
      child: SliderImages(),
    ),

        SizedBox(
          height: _width*.05,
        ),

        Container(

            margin: EdgeInsets.only(right: _width*.04,left:  _width*.04),
            color: cWhite,
            width: _width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("إيش طلبك ؟",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                Padding(padding: EdgeInsets.all(5)),
                Text("إختر القسم المراد الطلب منه",style: TextStyle(fontSize: 13,color: Color(0xffBEBEBE)),),
              ],
            )
        ),
        
        SizedBox(
          height: _width*.04,
        ),
        Container(
           margin: EdgeInsets.only(right: _width*.02,left:  _width*.02),
            color: cWhite,
            width: _width,
            height: _height-400,
            child: _buildCategoriesList()
        ),


      ],
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _initialRun = false;
      _appState = Provider.of<AppState>(context);
      _locationState = Provider.of<LocationState>(context);

      if (_appState.currentUser != null) {
           _firebaseCloudMessagingListeners();
            
        _storeList = _getStores(
            'show_mtager_cat?page=1&lang=${_appState.currentLang}&user_id=${_appState.currentUser.userId}');
      } else {
        _storeList = _getStores('show_mtager_cat?page=1&lang=${_appState.currentLang}');
      }
    }
  }

  @override
  void initState() {
    super.initState();
     _categoriesList = _getCategories();

  }

  @override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _storeState = Provider.of<StoreState>(context);

    return  NetworkIndicator( child:PageContainer(

      child: Scaffold(
          key: _scaffoldKey, // ADD THIS LINE

          drawer: Drawer(
            elevation: 0,
            child: Text("data"),
          ),
          backgroundColor: Colors.white,
          body: Stack(
            children: <Widget>[
              _buildBodyItem(),


              Positioned(top: 0, left: 0, right: 0, child: HomeAppBar()),
              Positioned(
                  top: 50,
                  right: _width*.03,

                  child:
                  Consumer<StoreState>(builder: (context, storeState, child) {

                    return
                      GestureDetector(
                        onTap: (){
                          showModalBottomSheet<dynamic>(
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              context: context,
                              builder: (builder) {
                                return _appState.currentUser!=null?Container(
                                  height: _height*.5,
                                  child: SelectLocation(),
                                ):Container(
                                  height: _height*.2,
                                  child: SelectLocation(),
                                );
                              });

                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: _width*.94,
                          height: 50,

                          decoration: new BoxDecoration(

                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: cHintColor,
                                offset: Offset(0.0, .5),
                                blurRadius: 0,
                              ),
                            ],

                            borderRadius: BorderRadius.all(
                                Radius.circular(6.00)
                            ),

                          ),

                          child: ListTile(

                            leading: Image.asset('assets/images/topmap.png'),
                            title: Transform(
                              transform: Matrix4.translationValues(25, 0.0, 0.0),
                              child:Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text("التوصيل ل",style: TextStyle(color: cHintColor,fontSize: 15),),
                                  Padding(padding: EdgeInsets.all(2)),
                                  Container(
                                    width: _width*.43,
                                    child: Text(_locationState.address!=null?_locationState.address:""
                                        ,style: TextStyle(color: cText,fontSize: 15),
                                        maxLines: 1,
                                        softWrap: true,

                                  )),
                                ],
                              ),
                            ),
                            trailing:Image.asset('assets/images/topselect.png'),

                          ),


                        ),
                      );

                  })),
              Center(
                child: ProgressIndicatorComponent(),
              )

            ],
          )),
    ));
  }
}
