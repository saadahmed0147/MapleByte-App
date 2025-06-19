import 'package:flutter/material.dart';
import 'package:maple_byte/Route/route_names.dart';
import 'package:maple_byte/Screens/Auth/congrats_screen.dart';
import 'package:maple_byte/Screens/Auth/forget_pass_screen.dart';
import 'package:maple_byte/Screens/Auth/login_screen.dart';
import 'package:maple_byte/Screens/Auth/otp_screen.dart';
import 'package:maple_byte/Screens/Auth/reset_pass_screen.dart';
import 'package:maple_byte/Screens/Auth/signup_screen.dart';
import 'package:maple_byte/Screens/Home/finished_screen.dart';
import 'package:maple_byte/Screens/Home/progress_screen.dart';
import 'package:maple_byte/Screens/Home/todo_screen.dart';
import 'package:maple_byte/Screens/Messages/chat_screen.dart';
import 'package:maple_byte/Screens/Messages/users_screen.dart';
import 'package:maple_byte/Screens/Splash/app_on_screen.dart';
import 'package:maple_byte/Screens/Splash/detailed_splash.dart';
import 'package:maple_byte/Screens/Splash/splash_screen.dart';
import 'package:maple_byte/Screens/news_screen.dart';
import 'package:maple_byte/Screens/quotes_screen.dart';
import 'package:maple_byte/Screens/services_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //auth
      case RouteNames.congratsScreen:
        return MaterialPageRoute(builder: (context) => const CongratsScreen());
      case RouteNames.forgetpassScreen:
        return MaterialPageRoute(
          builder: (context) => const ForgetPassScreen(),
        );
      case RouteNames.loginScreen:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case RouteNames.otpScreen:
        return MaterialPageRoute(builder: (context) => const OtpScreen());
      case RouteNames.resetPassScreen:
        return MaterialPageRoute(builder: (context) => ResetPassScreen());
      case RouteNames.signupScreen:
        return MaterialPageRoute(builder: (context) => SignupScreen());

      //home
      case RouteNames.finishScreen:
        return MaterialPageRoute(builder: (context) => const FinishedScreen());
      case RouteNames.progressScreen:
        return MaterialPageRoute(builder: (context) => const ProgressScreen());
      case RouteNames.todoScreen:
        return MaterialPageRoute(builder: (context) => const TodoScreen());

      // messages
      case RouteNames.chatScreen:
        return MaterialPageRoute(builder: (context) => const ChatScreen());
      case RouteNames.usersScreen:
        return MaterialPageRoute(builder: (context) => const UsersScreen());

      //splash
      case RouteNames.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RouteNames.detailSplashScreen:
        return MaterialPageRoute(builder: (context) => const DetailedSplash());
      case RouteNames.appOnScreen:
        return MaterialPageRoute(builder: (context) => const AppOnScreen());

      // others
      case RouteNames.newsScreen:
        return MaterialPageRoute(builder: (context) => const NewsScreen());
      case RouteNames.quotesScreen:
        return MaterialPageRoute(builder: (context) => const QuotesScreen());
      case RouteNames.servicesScreen:
        return MaterialPageRoute(builder: (context) => const ServicesScreen());

      default:
        return MaterialPageRoute(
          builder: (context) =>
              const Scaffold(body: Center(child: Text('No Route Found!'))),
        );
    }
  }
}
