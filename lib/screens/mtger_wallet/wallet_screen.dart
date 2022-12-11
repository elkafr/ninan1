



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ninan1/components/app_repo/location_state.dart';
import 'package:ninan1/components/gradient_app_bar/gradient_app_bar.dart';
import 'package:ninan1/models/cart_details.dart';
import 'package:ninan1/models/request.dart';
import 'package:ninan1/screens/mtger_wallet/add_convert.dart';
import 'package:ninan1/screens/mtger_wallet/add_request.dart';
import 'package:ninan1/screens/store/add_product_screen.dart';
import 'package:ninan1/screens/store/cats_screen.dart';
import 'package:ninan1/screens/store/edit_product_screen.dart';
import 'package:ninan1/screens/store/store_screen.dart';
import 'package:provider/provider.dart';
import 'package:ninan1/components/app_repo/app_state.dart';
import 'package:ninan1/components/app_repo/navigation_state.dart';
import 'package:ninan1/components/app_repo/product_state.dart';
import 'package:ninan1/components/app_repo/store_state.dart';
import 'package:ninan1/components/app_repo/progress_indicator_state.dart';
import 'package:ninan1/components/buttons/custom_button.dart';
import 'package:ninan1/components/connectivity/network_indicator.dart';
import 'package:ninan1/components/no_data/no_data.dart';
import 'package:ninan1/components/progress_indicator_component/progress_indicator_component.dart';
import 'package:ninan1/components/response_handling/response_handling.dart';
import 'package:ninan1/locale/localization.dart';
import 'package:ninan1/models/category.dart';
import 'package:ninan1/models/product.dart';
import 'package:ninan1/screens/store/components/store_appbar.dart';
import 'package:ninan1/components/safe_area/page_container.dart';
import 'package:ninan1/components/app_repo/store_state.dart';
import 'package:ninan1/services/access_api.dart';
import 'package:ninan1/utils/app_colors.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool _initialRun = true;
  double _height, _width;
  StoreState _storeState;
  AppState _appState;
  LocationState _locationState;
  ProductState _productState;
  Services _services = Services();
  Future<List<Category>> _categoriesList;
  Future<List<Request>> _requestsList;
  Future<List<Request>> _detailsList;
  ProgressIndicatorState _progressIndicatorState;
  NavigationState _navigationState;
  Future<List<CartDetails>> _cartDetails;

  int _xx;




  Future<List<Request>> _getRequests() async {
    Map<String, dynamic> results = await _services.get(
        'https://ninanapp.com/app/api/mtger_portfolio?lang=${_appState.currentLang}&page=1&mtger_id=${_storeState.currentStore.mtgerId}');
    List<Request> requestsList = List<Request>();
    if (results['response'] == '1') {
      Iterable iterable = results['results'];
      requestsList = iterable.map((model) => Request.fromJson(model)).toList();
    } else {
      print('error');
    }
    return requestsList;
  }













  @override
  void initState() {
    super.initState();


    FutureBuilder<String>(
        future: Provider.of<StoreState>(context,
            listen: false)
            .getStoreCharge() ,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(
                child: SpinKitFadingCircle(color: cPrimaryColor),
              );
            case ConnectionState.active:
              return Text('');
            case ConnectionState.waiting:
              return Center(
                child: SpinKitFadingCircle(color: cPrimaryColor),
              );
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Text("Error");
              } else {
                _xx=int.parse(snapshot.data);
                return Text(snapshot.data,style: TextStyle(color: cText,fontSize: 25),);
              }
          }
          return Center(
            child: SpinKitFadingCircle(color: cPrimaryColor),
          );
        });
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _storeState = Provider.of<StoreState>(context);
      _appState = Provider.of<AppState>(context);
      _productState = Provider.of<ProductState>(context);
      _locationState = Provider.of<LocationState>(context);
      _requestsList = _getRequests();



      _initialRun = false;
    }
  }



  Widget _buildProducts() {
    return LayoutBuilder(builder: (context, constraints) {
      return FutureBuilder<List<Request>>(
        future: _requestsList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(



                      padding: EdgeInsets.only(top: 20,right: 10,left: 10),
                      margin: EdgeInsets.only(
                          top: 10,
                          left: 12,
                          right: 12,
                          bottom:
                          index == snapshot.data.length - 1 ? 20 : 0),
                      decoration: BoxDecoration(

                          color: Color(0xffF9F9F9),
                          borderRadius: BorderRadius.circular(
                            10.0,
                          )),
                      child: GestureDetector(
                        child: ListTile(
                          leading: snapshot.data[index].requestType=="request"?Image.asset("assets/images/request.png"):Image.asset("assets/images/convert.png"),
                          title: Row(
                            children: <Widget>[
                              Container(
                                width: _width*.40,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding:
                                      EdgeInsets.only(bottom: 10, right: 10 ,left: 10),
                                      child: Text(
                                        snapshot.data[index].requestType=="request"?"سحب رصيد":"تحويل رصيد",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: cText

                                        ),
                                      ),
                                    ),

                                    Container(

                                      padding:
                                      EdgeInsets.only(bottom: 10, right: 10 ,left: 10),
                                      child: Text(
                                        snapshot.data[index].requestDate,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Color(0xffBEBEBE)

                                        ),
                                      ),
                                    ),


                                    Container(

                                      padding:
                                      EdgeInsets.only(bottom: 10, right: 10 ,left: 10),
                                      child: Row(
                                        children: <Widget>[
                                          Image.asset("assets/images/arrow.png"),
                                          Text(
                                            snapshot.data[index].requestActive=="0"?"فى الانتظار":"تم التنفيذ",
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: cPrimaryColor

                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),


                              Spacer(),
                              Container(

                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[

                                    Container(
                                        margin: EdgeInsets.only(
                                            right: 5, left: 5,
                                            top: 5
                                        ),
                                        child: Text(
                                          snapshot.data[index].requestValue,
                                          style: TextStyle(
                                              color: cText,
                                              fontSize: 13

                                          ),
                                        )),

                                    Container(

                                      child: Text(
                                        AppLocalizations.of(context).sr,
                                        style: TextStyle(
                                            color: cPrimaryColor,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),



                                  ],
                                ),
                              )
                            ],
                          ),


                        ),
                        onTap: (){
                          showModalBottomSheet<dynamic>(
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              context: context,
                              builder: (builder) {
                                return Container(
                                  height: _height*.85,
                                  child: Padding(
                                      padding:
                                      EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[

                                          Container(
                                            height: 30,
                                            child: Image.asset('assets/images/bottomTop.png'),
                                          ),

                                          Container(
                                            padding: EdgeInsets.only(right: 20),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text("تفاصيل العملية",style: TextStyle(color: cText,fontSize: 16,fontWeight: FontWeight.bold),),
                                                Padding(padding: EdgeInsets.all(5)),
                                                Text("تفاصيل عن العملية التي تمت",style: TextStyle(color: cHintColor,fontSize: 13),),
                                              ],
                                            ),
                                          ),
                                          Padding(padding: EdgeInsets.all(8)),
                                          Expanded(child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[

                                              ListTile(
                                                title:Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text("تاريخ العملية",style: TextStyle(color: Color(0xffABABAB),fontSize: 15),),
                                                    Padding(padding: EdgeInsets.all(5)),
                                                    Text(snapshot.data[index].requestDate,style: TextStyle(color: cText,fontSize: 15),)
                                                  ],
                                                ),
                                              ),

                                              Container(
                                                height: 1,
                                                color:  Colors.grey[300],
                                                margin: EdgeInsets.only(top: 10,bottom: 10,right: _width*.04,left: _width*.04),
                                              ),


                                              ListTile(
                                                title:Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text("نوع العملية",style: TextStyle(color: Color(0xffABABAB),fontSize: 15),),
                                                    Padding(padding: EdgeInsets.all(5)),
                                                    Text(snapshot.data[index].requestType=="request"?"سحب رصيد":"تحويل رصيد",style: TextStyle(color: cText,fontSize: 15),)
                                                  ],
                                                ),
                                              ),



                                              Container(
                                                height: 1,
                                                color:  Colors.grey[300],
                                                margin: EdgeInsets.only(top: 10,bottom: 10,right: _width*.04,left: _width*.04),
                                              ),


                                              ListTile(
                                                title:Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text("المبلغ",style: TextStyle(color: Color(0xffABABAB),fontSize: 15),),
                                                    Padding(padding: EdgeInsets.all(5)),
                                                    Container(

                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[

                                                          Container(
                                                              margin: EdgeInsets.only(
                                                                  right: 5, left: 5,
                                                                  top: 5
                                                              ),
                                                              child: Text(
                                                                snapshot.data[index].requestValue,
                                                                style: TextStyle(
                                                                    color: cText,
                                                                    fontSize: 15

                                                                ),
                                                              )),

                                                          Container(

                                                            child: Text(
                                                              AppLocalizations.of(context).sr,
                                                              style: TextStyle(
                                                                  color: cPrimaryColor,
                                                                  fontSize: 13,
                                                                  fontWeight: FontWeight.w400),
                                                            ),
                                                          ),

                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),





                                              Container(
                                                height: 1,
                                                color:  Colors.grey[300],
                                                margin: EdgeInsets.only(top: 10,bottom: 10,right: _width*.04,left: _width*.04),
                                              ),


                                              ListTile(
                                                title:Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text("صاحب الحساب",style: TextStyle(color: Color(0xffABABAB),fontSize: 15),),
                                                    Padding(padding: EdgeInsets.all(5)),
                                                    Text(snapshot.data[index].requestName,style: TextStyle(color: cText,fontSize: 15),)
                                                  ],
                                                ),
                                              ),




                                              Container(
                                                height: 1,
                                                color:  Colors.grey[300],
                                                margin: EdgeInsets.only(top: 10,bottom: 10,right: _width*.04,left: _width*.04),
                                              ),


                                              ListTile(
                                                title:Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text("رقم الحساب",style: TextStyle(color: Color(0xffABABAB),fontSize: 15),),
                                                    Padding(padding: EdgeInsets.all(5)),
                                                    Text(snapshot.data[index].requestNumber,style: TextStyle(color: cText,fontSize: 15),)
                                                  ],
                                                ),
                                              ),






                                              Container(
                                                height: 1,
                                                color:  Colors.grey[300],
                                                margin: EdgeInsets.only(top: 10,bottom: 10,right: _width*.04,left: _width*.04),
                                              ),


                                              ListTile(
                                                title:Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text("البنك",style: TextStyle(color: Color(0xffABABAB),fontSize: 15),),
                                                    Padding(padding: EdgeInsets.all(5)),
                                                    Text(snapshot.data[index].requestBankName,style: TextStyle(color: cText,fontSize: 15),)
                                                  ],
                                                ),
                                              ),




                                              Container(
                                                height: 1,
                                                color:  Colors.grey[300],
                                                margin: EdgeInsets.only(top: 10,bottom: 10,right: _width*.04,left: _width*.04),
                                              ),


                                              ListTile(
                                                title:Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text("الحالة",style: TextStyle(color: Color(0xffABABAB),fontSize: 15),),
                                                    Padding(padding: EdgeInsets.all(5)),
                                                    Text(snapshot.data[index].requestActive=="0"?"فى الانتظار":"تم التنفيذ",style: TextStyle(color: cText,fontSize: 15),)
                                                  ],
                                                ),
                                              ),



                                            ],
                                          )

                                          ),




                                        ],
                                      )),
                                );
                              });
                        },
                      ),
                    );
                  });
            } else {
              return NoData(
                  message: AppLocalizations.of(context).noResults
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
      );
    });
  }




  Widget _buildBodyItem() {
    return ListView(
      children: <Widget>[



        SizedBox(
          height: _height * 0.06,
        ),
        
        Container(



          padding: EdgeInsets.only(top: 20,right: 10,left: 10,bottom: 20),
          margin: EdgeInsets.only(
              top: 10,
              left: 12,
              right: 12,
              bottom:10,),


         decoration: BoxDecoration(

        color: Color(0xffF9F9F9),
        borderRadius: BorderRadius.circular(
        10.0,
        )),
          child: ListTile(
            leading: Image.asset("assets/images/wallet.png"),
             title: Column(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
                  Text("رصيد محفظتك الحالي",  style: TextStyle(
                      color: Color(0xff848484),
                      fontSize: 14

                  )),
                 Padding(padding: EdgeInsets.all(5)),
                 Container(

                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: <Widget>[

                        Consumer<StoreState>(builder: (context, storeState, child) {
                        return  Container(
                        margin: EdgeInsets.only(
                        right: 5, left: 5,
                        top: 5
                        ),
                        child: FutureBuilder<String>(
                            future: Provider.of<StoreState>(context,
                                listen: false)
                                .getStoreCharge() ,
                            builder: (context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                  return Center(
                                    child: SpinKitFadingCircle(color: cPrimaryColor),
                                  );
                                case ConnectionState.active:
                                  return Text('');
                                case ConnectionState.waiting:
                                  return Center(
                                    child: SpinKitFadingCircle(color: cPrimaryColor),
                                  );
                                case ConnectionState.done:
                                  if (snapshot.hasError) {
                                    return Text("Error");
                                  } else {

                                    return Text(snapshot.data,style: TextStyle(color: cText,fontSize: 25),);
                                  }
                              }
                              return Center(
                                child: SpinKitFadingCircle(color: cPrimaryColor),
                              );
                            }));

                        }),


                       Container(


                         child: Text(
                           AppLocalizations.of(context).sr,
                           style: TextStyle(
                               color: cPrimaryColor,
                               fontSize: 13,
                               fontWeight: FontWeight.w400),
                         ),
                       ),



                     ],
                   ),
                 )

               ],
             ),
          ),
        ),

       SizedBox(height: _width*.02,),
        Container(
          margin: EdgeInsets.only(right: _width*.04),
          alignment: Alignment.centerRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text("سجل العمليات",style: TextStyle(color: cText,fontSize: 15),),
              Padding(padding:EdgeInsets.all(5)),
              Text("سجل عمليات التي تمت على محفظتك",style: TextStyle(color: Color(0xffBEBEBE),fontSize: 14),),
            ],
          ),
        ),

        SizedBox(height: _width*.02,),
        Container(
          margin: EdgeInsets.only(bottom: 7),
          height: _height-(_height * 0.4),
          child: _buildProducts(),

        ),


        Container(
          margin: EdgeInsets.only(bottom: 20),
          height: 50,
          child: FutureBuilder<String>(
    future: Provider.of<StoreState>(context,
    listen: true)
        .getStoreChargeState() ,
    builder: (context, snapshot) {
    switch (snapshot.connectionState) {
    case ConnectionState.none:
    return Center(
    child: SpinKitFadingCircle(color: cPrimaryColor),
    );
    case ConnectionState.active:
    return Text('');
    case ConnectionState.waiting:
    return Center(
    child: SpinKitFadingCircle(color: cPrimaryColor),
    );
    case ConnectionState.done:
    if (snapshot.hasError) {
    return Text("Error");
    } else {
      List<String> xxx=snapshot.data.split(",");
      print("========");
      print("========");
      print(int.parse(xxx[0]));
      print(int.parse(xxx[1]));
      print("========");
      print("========");
    return int.parse(xxx[0])>int.parse(xxx[1])?CustomButton(
      btnColor: cPrimaryColor,
      btnLbl:"طلب سحب رصيد",
      onPressedFunction: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddRequestScreen()));
      },
    ):CustomButton(
      btnColor: cPrimaryColor,
      btnLbl:"تحويل الرصيد",
      onPressedFunction: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddConvertScreen()));
      },
    );
    }
    }
    return Center(
    child: SpinKitFadingCircle(color: cPrimaryColor),
    );
    }),

        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _progressIndicatorState = Provider.of<ProgressIndicatorState>(context);
    _navigationState = Provider.of<NavigationState>(context);
    return NetworkIndicator( child:PageContainer(
      child: Scaffold(
          body: Stack(
        children: <Widget>[

          _buildBodyItem(),




          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: GradientAppBar(
              appBarTitle:"المحفظة",
              leading:GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.only(top: 12,right: 10),
                  child: Image.asset('assets/images/back.png'),
                ),
              ),
              trailing:Container(),
            ),
          ),

          Center(
            child: ProgressIndicatorComponent(),
          )
        ],
      )),
    ));
  }
}
