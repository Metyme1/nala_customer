
import 'package:flutter/material.dart';
import 'package:nala_c/screens/map.dart';
import 'package:nala_c/screens/splash_screens/splash.dart';

import 'package:easy_localization/easy_localization.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('am', 'ET')],
      path: 'assets/translations',

      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'nala ride',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        primarySwatch: MaterialColor(0xff1C6AC5, {
          50: Color(0xffE3E8F6),
          100: Color(0xffB8C5EA),
          200: Color(0xff8DA2DE),
          300: Color(0xff6280D3),
          400: Color(0xff3D67C9),
          500: Color(0xff1C6AC5),
          600: Color(0xff195FC0),
          700: Color(0xff1655BB),
          800: Color(0xff134AB5),
          900: Color(0xff1038AA),
        }),
      ),


      home: const SplashScreen(),
     // home:MapPage(),
    );
  }
}