import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yummygo/controllers/authentication_controller.dart';
import 'package:yummygo/controllers/cart_controller.dart';
import 'package:yummygo/controllers/menu_controller.dart';
import 'package:yummygo/firebase_options.dart';
import 'package:yummygo/views/splash_screen/splash_screen.dart';

Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationController>(
          create: (context) => AuthenticationController(),
        ),
        ChangeNotifierProvider<MenuControllerprovider>(
          create: (context) => MenuControllerprovider(),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (context) => CartProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
