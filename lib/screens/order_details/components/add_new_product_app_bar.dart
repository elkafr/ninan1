import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:ninan1/components/app_repo/app_state.dart';
import 'package:ninan1/components/app_repo/navigation_state.dart';
import 'package:ninan1/components/app_repo/store_state.dart';
import 'package:ninan1/components/app_repo/tab_state.dart';
import 'package:ninan1/services/access_api.dart';
import 'package:ninan1/utils/app_colors.dart';

class AddNewProductAppBar extends StatefulWidget {
  
  @override
  _AddNewProductAppBarState createState() => _AddNewProductAppBarState();
}

class _AddNewProductAppBarState extends State<AddNewProductAppBar> {
 

  @override
  Widget build(BuildContext context) {
    
     
    return Consumer<StoreState>(builder: (context, storeState, child) {
      return Stack(
        children: <Widget>[
          Container(
            height: 100,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [ Color(0xff1532C2),Color(0xff0083D3),],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[500],
                    offset: Offset(0.0, 1.5),
                    blurRadius: 1.5,
                  ),
                ]),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
              Container(),
                Text(storeState.currentStoreTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.display1),

              GestureDetector(
                onTap: (){
                     Navigator.pop(context);
                      Navigator.pushReplacementNamed(
                                context, '/edit_order_details_screen');
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Image.asset('assets/images/cancel.png',color: cWhite,),
                )
              )
         
                     
              ],
            ),
          ),
        ],
      );
    });
  }
}
