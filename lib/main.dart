import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maple_byte/Route/route_names.dart';
import 'package:maple_byte/Route/routes.dart';
import 'package:maple_byte/firebase_options.dart';

late Size mq;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return MaterialApp(
      title: 'Maple Byte',
      debugShowCheckedModeBanner: false,
      initialRoute: RouteNames.appOnScreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
