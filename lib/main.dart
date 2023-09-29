import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:nala_c/src/pages/splash_screens/splash.dart';
import 'package:nala_c/src/provider/position.dart';
import 'package:provider/provider.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();      // theme: ThemeData(


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

    return MultiProvider(
        providers: [
        ChangeNotifierProvider(create: (_) => PositionProvider()),
    ],
       child:MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'nala ride',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      home: const SplashScreen(),
       )
    );
  }
}