import 'package:flutter/material.dart';
import 'package:ninan1/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:ninan1/components/app_data/shared_preferences_helper.dart';
import 'package:ninan1/components/app_repo/store_state.dart';
import 'package:ninan1/locale/localization.dart';

class LogoutDialog1 extends StatelessWidget {
  final String alertMessage;

  const LogoutDialog1({Key key, this.alertMessage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final storeState = Provider.of<StoreState>(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                  color: cOmarColor,
                  borderRadius: BorderRadius.all(Radius.circular(50.00)),
                  border: Border.all(color: cOmarColor)),
              child: Icon(Icons.input,size: 40,color: Colors.red,),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "تسجيل الخروج",
              textAlign: TextAlign.center,
              style:
              TextStyle(fontSize: 16, height: 1.5, fontFamily: 'segoeui',color: cText,fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              alertMessage,
              textAlign: TextAlign.center,
              style:
              TextStyle(fontSize: 15, height: 1.5, fontFamily: 'segoeui',color: Colors.grey),
            ),
            SizedBox(
              height: 10,
            ),

            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[


                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      SharedPreferencesHelper.remove("store");
                      storeState.setCurrentStore(null);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/home1_screen', (Route<dynamic> route) => false);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width*.30,
                      padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                      decoration: BoxDecoration(
                          color: cPrimaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(6.00)),
                          border: Border.all(color: cPrimaryColor)),
                      child: Text(AppLocalizations.of(context).ok,
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'segoeui',
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                    )
                ),

                Padding(padding: EdgeInsets.all(5)),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width*.30,
                      padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(6.00)),
                          border: Border.all(color: cPrimaryColor)),
                      child: Text(AppLocalizations.of(context).cancel,
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'segoeui',
                              color: cPrimaryColor,
                              fontWeight: FontWeight.w500)),
                    )
                ),


              ],
            )
          ],
        ),
      ),
    );
  }
}
