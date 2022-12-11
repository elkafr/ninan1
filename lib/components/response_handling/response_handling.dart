
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:ninan1/components/app_data/shared_preferences_helper.dart';
import 'package:ninan1/components/dialogs/response_alert_dialog.dart';
import 'package:ninan1/locale/localization.dart';


handleUnauthenticated( BuildContext context ) {
  showDialog(
                                barrierDismissible:
                                    false, // user must tap button!
                                context: context,
                                builder: (_) {
                                  return ResponseAlertDialog(
                                    alertTitle: 'عفواً',
                                    alertMessage: 'يرجي تسجيل الدخول مجدداً',
                                    alertBtn: 'موافق',
                                    onPressedAlertBtn: () {
                                      Navigator.pop(context);
                                      SharedPreferencesHelper.remove("user");
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              '/login_screen',
                                              (Route<dynamic> route) => false);
                                    },
                                  );
                                });
}

   showErrorDialog(var message,BuildContext context) {
    showDialog(
        barrierDismissible: false, // user must tap button!
        context: context,
        builder: (_) {
          return ResponseAlertDialog(
            alertTitle: 'عفواً',
            alertMessage: message,
            alertBtn: AppLocalizations.of(context).ok,
            onPressedAlertBtn: () {
    
            },
          );
        });
  }
  
  showToast(String message, context) {
  return Toast.show(message, context,
      backgroundColor: Theme.of(context).primaryColor,
      duration: Toast.LENGTH_LONG,
      gravity: Toast.BOTTOM);
}
