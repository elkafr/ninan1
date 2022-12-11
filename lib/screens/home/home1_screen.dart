import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ninan1/components/app_repo/app_state.dart';
import 'package:ninan1/components/connectivity/network_indicator.dart';
import 'package:ninan1/components/response_handling/response_handling.dart';
import 'package:ninan1/components/safe_area/page_container.dart';
import 'package:ninan1/locale/localization.dart';
import 'package:ninan1/services/access_api.dart';
import 'package:ninan1/screens/auth/mtger_login_screen.dart';
import 'package:ninan1/screens/auth/login_screen.dart';
import 'package:ninan1/utils/app_colors.dart';
import 'package:ninan1/utils/utils.dart';
import 'package:provider/provider.dart';



class Home1Screen extends StatefulWidget {
  @override
  _Home1ScreenState createState() => _Home1ScreenState();
}

class _Home1ScreenState extends State<Home1Screen> {

  double _height ,_width;
  Services _services = Services();
  AppState _appState;
  bool _initialRun = true;





  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(_initialRun){
      _appState = Provider.of<AppState>(context);
      _initialRun = false;
    }


  }

  Widget _buildBodyItem(){

    return  Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Spacer(flex: 1,),
             Row(
               children: <Widget>[
                 GestureDetector(
                   onTap: (){
                     Navigator.push(
                         context,
                         MaterialPageRoute(
                             builder: (context) => MtgerLoginScreen()));
                   },
                   child: Container(
                     alignment: Alignment.center,
                     width: _width*.45,
                     padding: EdgeInsets.all(20),
                     decoration: BoxDecoration(
                       color: cOmarColor,
                       border: Border.all(color: Color(0xff1F61301A), width: 1.0),
                       borderRadius: BorderRadius.circular(10),
                     ),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: <Widget>[
                         Image.asset("assets/images/store.png",height: _width*.2,),
                         Padding(padding: EdgeInsets.all(10)),
                         Text("متجر",style: TextStyle(color: Color(0xff404040),fontSize: 16),),
                         Padding(padding: EdgeInsets.all(10)),
                         Center(child: Text("سجل دخولك الان فى التطبيق كصاحب متجر",style: TextStyle(color: Color(0xffC5C5C5),fontSize: 12),),)
                       ],
                     ),
                   ),
                 ),



                 Padding(
                   padding: EdgeInsets.all(_width*.02),
                 ),


                 GestureDetector(
                   onTap: (){
                     Navigator.push(
                         context,
                         MaterialPageRoute(
                             builder: (context) => LoginScreen()));
                   },
                   child: Container(
                     alignment: Alignment.center,
                     width: _width*.45,
                     padding: EdgeInsets.all(20),
                     decoration: BoxDecoration(
                       color: cOmarColor,
                       border: Border.all(color: Color(0xff1F61301A), width: 1.0),
                       borderRadius: BorderRadius.circular(10),
                     ),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: <Widget>[
                         Image.asset("assets/images/tawsil1.png",height: _width*.2,),
                         Padding(padding: EdgeInsets.all(10)),
                         Text("مندوب توصيل",style: TextStyle(color: Color(0xff404040),fontSize: 16),),
                         Padding(padding: EdgeInsets.all(10)),
                         Center(child: Text("تابع طلبات التوصيل واستفد بوقتك",style: TextStyle(color: Color(0xffC5C5C5),fontSize: 12),),)
                       ],
                     ),
                   ),
                 )



               ],
             ),

            Spacer(flex: 2,),
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {


    final appBar = AppBar(
      elevation: 0,
        backgroundColor: cWhite,
        centerTitle: true,
        title: Text(AppLocalizations.of(context).SelectYourLogin,
            style: Theme.of(context).textTheme.display1),

    );
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _width = MediaQuery.of(context).size.width;
    return  NetworkIndicator( child:PageContainer(
      child: Scaffold(
        appBar: appBar,
        body:
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg1.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child:  _buildBodyItem(),
            )



      ),
    ));
  }
}