import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ninan1/components/app_repo/app_state.dart';
import 'package:ninan1/components/connectivity/network_indicator.dart';
import 'package:ninan1/components/response_handling/response_handling.dart';
import 'package:ninan1/components/safe_area/page_container.dart';
import 'package:ninan1/locale/localization.dart';
import 'package:ninan1/services/access_api.dart';
import 'package:ninan1/utils/app_colors.dart';
import 'package:ninan1/utils/utils.dart';
import 'package:provider/provider.dart';



class AboutAppScreen extends StatefulWidget {
  @override
  _AboutAppScreenState createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {

  double _height ,_width;
Services _services = Services();
AppState _appState;
bool _initialRun = true;

  Future<String> _aboutContent;

  Future<String> _getAboutContent() async {
    var results = await _services.get('${Utils.ABOUT_APP_URL}lang=${_appState.currentLang}');
    String aboutContent = '';
   if (results['response'] == '1') {
      aboutContent = results['content'];
    } else {
      showErrorDialog(results['message'], context);
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


  final appBar = AppBar(
        backgroundColor: cPrimaryColor,
        centerTitle: true,
        title: Text( AppLocalizations.of(context).about,
            style: Theme.of(context).textTheme.display1),
        leading: GestureDetector(
          child: Consumer<AppState>(
            builder: (context,appState,child){
              return appState.currentLang == 'ar' ? Image.asset('assets/images/back.png',color: cPrimaryColor,):
              Image.asset('assets/images/back.png',color: cPrimaryColor);

            }
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ));
            _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
         _width = MediaQuery.of(context).size.width;
    _width = MediaQuery.of(context).size.width;
    return  NetworkIndicator( child:PageContainer(
      child: Scaffold(
        appBar: appBar,
          body:
          _buildBodyItem(),


       ),
    ));
  }
}