import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ninan1/screens/orders/mtger_orders_screen.dart';
import 'package:provider/provider.dart';
import 'package:ninan1/components/app_repo/app_state.dart';
import 'package:ninan1/components/app_repo/store_state.dart';
import 'package:ninan1/components/app_repo/store_state.dart';
import 'package:ninan1/components/dialogs/response_alert_dialog.dart';
import 'package:ninan1/screens/store/components/log_out_dialog.dart';
import 'package:ninan1/services/access_api.dart';
import 'package:ninan1/utils/app_colors.dart';

class StoreAppBar extends StatefulWidget {
  
  @override
  _StoreAppBarState createState() => _StoreAppBarState();
}

class _StoreAppBarState extends State<StoreAppBar> {
  bool _initialRun = true;
  AppState _appState;
  StoreState _storeState;
  Services _services = Services();




  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _appState = Provider.of<AppState>(context);
      _storeState = Provider.of<StoreState>(context);
      _initialRun = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StoreState>(builder: (context, storeState, child) {
      return Stack(
        children: <Widget>[
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(


                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[500],
                    offset: Offset(0.0, 1.5),
                    blurRadius: 1.5,
                  ),
                ]),

            child: FittedBox(
                fit: BoxFit.cover,
                child: Image.network(
                  storeState.currentStore.mtgerPhoto1,
                )),

          ),
          Positioned(
            right: 0,
            top: 27,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Image.asset("assets/images/back1.png"),
                  onPressed: () async{

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MtgerOrdersScreen()));


                  },
                ),


              ],
            ),
          ),
        ],
      );
    });
  }
}
