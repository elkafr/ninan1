import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:ninan1/components/app_repo/app_state.dart';
import 'package:ninan1/components/connectivity/network_indicator.dart';
import 'package:ninan1/components/gradient_app_bar/gradient_app_bar.dart';
import 'package:ninan1/components/safe_area/page_container.dart';
import 'package:ninan1/locale/localization.dart';
import 'package:ninan1/services/access_api.dart';
import 'dart:math' as math;
import 'package:ninan1/utils/app_colors.dart';


class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {

  double _height ,_width;
Services _services = Services();
AppState _appState;
bool _initialRun = true;

  Future<String> _aboutContent;

  Future<String> _getAboutContent() async {
    var results = await _services.get('https://ninanapp.com/app/api/site_use?lang=${_appState.currentLang}');
    String aboutContent = '';
   if (results['response'] == '1') {
      aboutContent = results['content'];
    } else {
      print('error');
    }
    return aboutContent;
  }

@override
void didChangeDependencies() {
  super.didChangeDependencies();
   if(_initialRun){
       _appState = Provider.of<AppState>(context);
  _aboutContent = _getAboutContent();
  _initialRun = false;
   }
  
  
}

  Widget _buildBodyItem(){

  return  Padding(
        padding: EdgeInsets.all(10.0),
        child: FutureBuilder<String>(
          future: _aboutContent,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: <Widget>[
                    SizedBox(
              height: _height * 0.1,
            ),
            Container(
              height: _height * 0.25,
              margin: EdgeInsets.symmetric(horizontal: _width * 0.03),
              child: Center(
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
            Divider(),
                  Container(
             
                      padding: EdgeInsets.symmetric(horizontal: _width * 0.05),
                      child: Html(
                        data: snapshot.data,
                      )),
                  SizedBox(
                    height: _height * 0.35,
                  ),
               
                ],
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

             return Center(child: SpinKitThreeBounce(color: cPrimaryColor ,size: 40,));
          },
        ));
  }
 
  @override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
 
    return  NetworkIndicator( child:PageContainer(
      child: Scaffold(
          body: Stack(
        children: <Widget>[
          _buildBodyItem(),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: GradientAppBar(
              appBarTitle: AppLocalizations.of(context).about,
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