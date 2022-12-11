import 'package:ninan1/screens/auth/login_screen.dart';
import 'package:ninan1/screens/auth/mtger_register_code_activation_screen.dart';
import 'package:ninan1/screens/auth/password_recovery_screen.dart';
import 'package:ninan1/screens/auth/register_code_activation_screen.dart';
import 'package:ninan1/screens/auth/register_screen.dart';
import 'package:ninan1/screens/bottom_navigation.dart/bottom_navigation_bar.dart';
import 'package:ninan1/screens/cart/cart_screen.dart';
import 'package:ninan1/screens/home/home1_screen.dart';
import 'package:ninan1/screens/intro/our_vision.dart';
import 'package:ninan1/screens/intro/torf_city.dart';
import 'package:ninan1/screens/location/addLocation_screen.dart';
import 'package:ninan1/screens/notifications/notifications_screen.dart';
import 'package:ninan1/screens/order_details/add_new_product_to_order.dart';
import 'package:ninan1/screens/order_details/edit_order_details.dart';
import 'package:ninan1/screens/order_details/mtger_order_details.dart';
import 'package:ninan1/screens/order_details/order_details.dart';
import 'package:ninan1/screens/order_follow/order_follow.dart';
import 'package:ninan1/screens/orders/orders_screen.dart';
import 'package:ninan1/screens/orders/mtger_orders_screen.dart';
import 'package:ninan1/screens/profile/personal_information_screen.dart';
import 'package:ninan1/screens/profile/mtger_personal_information_screen.dart';
import 'package:ninan1/screens/splash/splash_screen.dart';
import 'package:ninan1/screens/store/store_screen.dart';


final routes = {
  '/': (context) => SplashScreen(),
  '/our_vision':(context) => OurVision(),
  '/torf_city' :(context) => TorfCity(),
  '/login_screen':(context) => LoginScreen(),
  '/password_recovery_screen':(context) => PasswordRecoveryScreen(),
  '/register_screen':(context) => RegisterScreen(),
  '/store_screen':(context) => StoreScreen(),
  '/navigation':(context) => BottomNavigation(),

  '/cart_screen':(context) => CartScreen(),
  '/home1_screen':(context) => Home1Screen(),
  '/orders_screen':(context) => OrdersScreen(),

  '/mtger_orders_screen':(context) => MtgerOrdersScreen(),
  '/personal_information_screen':(context) => PersonalInformationScreen(),
  '/mtger_personal_information_screen':(context) => MtgerPersonalInformationScreen(),
  '/notifications_screen' :(context) => NotificationsScreen(),
  '/order_details_screen':(context) => OrderDetailsScreen(),
  '/mtger_order_details_screen':(context) => MtgerOrderDetailsScreen(),
  '/order_follow_screen':(context) => OrderFollowScreen(),
  '/edit_order_details_screen':(context) => EditOrderDetailsScreen(),
  '/add_new_product_to_order_screen':(context) => AddNewProductToOrderScreen(),
  '/register_code_activation_screen' :(context) => RegisterCodeActivationScreen(),
  '/mtger_register_code_activation_screen' :(context) => MtgerRegisterCodeActivationScreen(),
  '/addLocation_screen' :(context) => AddLocationScreen()



};
