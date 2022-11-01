import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:starter_pack/resources/core/no_page_widget.dart';
import 'package:starter_pack/route/customer/customer_all_products_route.dart';
import 'package:starter_pack/route/customer/customer_basket_route.dart';
import 'package:starter_pack/route/customer/customer_change_password_route.dart';
import 'package:starter_pack/route/customer/customer_change_profile_data_route.dart';
import 'package:starter_pack/route/customer/customer_one_product_route.dart';
import 'package:starter_pack/route/customer/customer_profile_route.dart';
import 'package:starter_pack/route/customer/customer_home_route.dart';
import 'package:starter_pack/route/main/main_route.dart';
import 'package:starter_pack/route/login_route.dart';
import 'package:starter_pack/route/register_route.dart';
import 'package:starter_pack/route/splash_route.dart';

class RouteGenerator {

  static const SPLASH_ROUTE = "/";
  static const MAIN_ROUTE = "/main/mainRoute";

  static const LOGIN_ROUTE = "/loginRoute";
  static const REGISTER_ROUTE = "/registerRoute";

  static const CUSTOMER_HOME_ROUTE = "/customerHomeRoute";
  static const CUSTOMER_PROFILE_ROUTE = "/customerProfileRoute";
  static const CUSTOMER_ALL_PRODUCTS_ROUTE = "/customerAllProductsRoute";
  static const CUSTOMER_ONE_PRODUCT_ROUTE = "/customerOneProductRoute";
  static const CUSTOMER_BASKET_ROUTE = "/customerBasketRoute";
  static const CUSTOMER_CHANGE_PROFILE_DATA_ROUTE = "/customerChangeProfileDataRoute";
  static const CUSTOMER_CHANGE_PASSWORD_ROUTE = "/customerChangePasswordRoute";


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SPLASH_ROUTE:
        return MaterialPageRoute(builder: (_) => SplashRoute());
      case MAIN_ROUTE:
        return MaterialPageRoute(builder: (_) => MainRoute());

      case LOGIN_ROUTE:
        return MaterialPageRoute(builder: (_) => LoginRoute());
      case REGISTER_ROUTE:
        return MaterialPageRoute(builder: (_) => RegisterRoute());

      case CUSTOMER_HOME_ROUTE:
        return MaterialPageRoute(builder: (_) => CustomerHomeRoute());
      case CUSTOMER_PROFILE_ROUTE:
        return MaterialPageRoute(builder: (_) => CustomerProfileRoute());
      case CUSTOMER_ALL_PRODUCTS_ROUTE:
        return MaterialPageRoute(builder: (_) => CustomerAllProductsRoute());
      case CUSTOMER_ONE_PRODUCT_ROUTE:
        return MaterialPageRoute(builder: (_) => CustomerOneProductRoute(product: settings.arguments));
      case CUSTOMER_BASKET_ROUTE:
        return MaterialPageRoute(builder: (_) => CustomerBasketRoute());
      case CUSTOMER_CHANGE_PROFILE_DATA_ROUTE:
        return MaterialPageRoute(builder: (_) => CustomerChangeProfileDataRoute());
      case CUSTOMER_CHANGE_PASSWORD_ROUTE:
        return MaterialPageRoute(builder: (_) => CustomerChangePasswordRoute());


      default:
        return MaterialPageRoute(builder: (_) => NoPageWidget());
    }
  }

}