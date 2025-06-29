import 'package:flutter/material.dart';
import 'package:maple_byte/Route/route_names.dart';
import 'package:maple_byte/Screens/Auth/congrats_screen.dart';
import 'package:maple_byte/Screens/Auth/forget_pass_screen.dart';
import 'package:maple_byte/Screens/Auth/login_screen.dart';
import 'package:maple_byte/Screens/Auth/otp_screen.dart';
import 'package:maple_byte/Screens/Auth/reset_pass_screen.dart';
import 'package:maple_byte/Screens/Auth/signup_screen.dart';
import 'package:maple_byte/Screens/Home/Navigator/top_navigator.dart';
import 'package:maple_byte/Screens/Home/finished_screen.dart';
import 'package:maple_byte/Screens/Home/Navigator/bottom_navigator.dart';
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
      case RouteNames.topNavigator:
        return MaterialPageRoute(builder: (context) => const TopNavigator());
      case RouteNames.bottomNavigator:
        return MaterialPageRoute(builder: (context) => const BottomNavigator());
      case RouteNames.finishScreen:
        return MaterialPageRoute(builder: (context) => FinishedScreen());
      case RouteNames.progressScreen:
        return MaterialPageRoute(builder: (context) => ProgressScreen());
      case RouteNames.todoScreen:
        return MaterialPageRoute(builder: (context) => TodoScreen());

      // messages
      case RouteNames.chatScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => ChatScreen(
            currentUserId: args['currentUserId'],
            otherUserId: args['otherUserId'],
            otherUserName: args['otherUserName'],
          ),
        );
      case RouteNames.usersScreen:
        final args = settings.arguments as String; // Expecting user ID
        return MaterialPageRoute(
          builder: (context) => UsersScreen(currentUserId: args),
        );
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
