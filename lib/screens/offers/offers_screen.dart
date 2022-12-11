import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:ninan1/components/app_repo/app_state.dart';
import 'package:ninan1/components/app_repo/progress_indicator_state.dart';
import 'package:ninan1/components/app_repo/store_state.dart';
import 'package:ninan1/components/connectivity/network_indicator.dart';
import 'package:ninan1/components/gradient_app_bar/gradient_app_bar.dart';
import 'package:ninan1/components/no_data/no_data.dart';
import 'package:ninan1/components/not_registered/not_registered.dart';
import 'package:ninan1/components/progress_indicator_component/progress_indicator_component.dart';
import 'package:ninan1/components/safe_area/page_container.dart';
import 'package:ninan1/components/store_card/store_card_item.dart';
import 'package:ninan1/locale/localization.dart';
import 'package:ninan1/models/favourite_store.dart';
import 'package:ninan1/models/store.dart';
import 'package:ninan1/screens/favourite/components/favourite_store_item.dart';
import 'package:ninan1/services/access_api.dart';
import 'package:ninan1/utils/app_colors.dart';
import 'package:ninan1/models/slider.dart';

class OffersScreen extends StatefulWidget {
  @override
  _OffersScreenState createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  double _height, _width;
  Services _services = Services();
  StoreState _storeState;
  AppState _appState;
  bool _initialRun = true;

  Future<List<SliderModel>> _sliderImages;
  Future<List<SliderModel>> _getFavouriteStores() async {
    Map<String, dynamic> results = await _services.get(
        'https://ninanapp.com/app/api/show_offers?lang=${_appState.currentLang}');
    List<SliderModel> sliderList = List<SliderModel>();
    if (results['response'] == '1') {
      Iterable iterable = results['results'];
      sliderList = iterable.map((model) => SliderModel.fromJson(model)).toList();
    } else {
      print('error');
    }
    return sliderList;
  }

  Widget _buildStores() {
    return LayoutBuilder(builder: (context, constraints) {
      return   FutureBuilder<List<SliderModel>>(
        future: _sliderImages,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          
                          _appState.setCurrentCupone(snapshot.data[index].offerCuponeValue);
                          Navigator.pushReplacementNamed(
                              context, '/home_screen');
                        },
                        child: Container(
                          width: _width,
                          height: constraints.maxHeight * 0.25,
                          margin:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 12),
                          decoration: BoxDecoration(
                              color: Color(0xffF5F2F2),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Image.network(snapshot.data[index].offerPhoto,width: _width,),
                        ));
                  });
            } else {
              return NoData(
                message:  AppLocalizations.of(context).noResults,
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
    return  Consumer<AppState>(builder: (context, appState, child) {
      return  appState.currentUser != null
          ? ListView(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Container(
            // margin: EdgeInsets.only(top: 7, bottom: 20),
              height: _height - 100,
              child: _buildStores())
        ],
      ) : NotRegistered();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _initialRun = false;
      _appState = Provider.of<AppState>(context);
      if (_appState.currentUser != null) {
        _sliderImages = _getFavouriteStores();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _storeState = Provider.of<StoreState>(context);
    return  NetworkIndicator( child:PageContainer(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: <Widget>[
              _buildBodyItem(),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: GradientAppBar(
                  appBarTitle: "العروض",



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
