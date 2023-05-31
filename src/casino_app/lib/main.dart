import 'dart:io';

import 'package:casino_app/view/screens/api_beers.dart';
import 'package:casino_app/view/screens/beers_screen.dart';
import 'package:casino_app/view/screens/gems_bonanza_screen.dart';
import 'package:casino_app/view/screens/home_screen.dart';
import 'package:casino_app/view/screens/login_screen.dart';
import 'package:casino_app/view/screens/shopping_cart_screen.dart';
import 'package:casino_app/view/screens/slots_screen.dart';
import 'package:casino_app/viewmodel/beer_view_model.dart';
import 'package:casino_app/viewmodel/profile_view_model.dart';
import 'package:casino_app/viewmodel/slots_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: BeerViewModel()),
        ChangeNotifierProvider.value(value: ProfileViewModel()),
        ChangeNotifierProvider(create: (_) => SlotsViewModel(),
        lazy: false,
        child: const SlotsScreen(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Casino',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(),
          primarySwatch: Colors.orange,
        ),
        initialRoute: '/',
        routes: {
          '/':(context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
          '/beers':(context) => const BeersScreen(),
          '/slots': (context) => const SlotsScreen(),
          '/gemsbonanza': (context) => const GemsBonanzaScreen(),
          '/apibeers': (context) => const ApiBeersScreen(),
          '/shoppingcart': (context) => const ShoppingCartScreen(),
        },
      ),
    );
  }
}


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

