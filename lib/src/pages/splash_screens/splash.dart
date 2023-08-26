import 'package:flutter/material.dart';

import '../../widget/button.dart';
import '../../widget/splash_generator.dart';
import '../screens/login.dart';




class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xff1C6AC5), Color(0xffD1D1D6)],
          stops: [0.0, 1.2],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // splash title
                SplashGenerator().title('Nala Ride'),
                // splash illustraion image
                SplashGenerator().splashImage('assets/images/1st_splash.png'),
                SplashGenerator().bodyText(
                    'Lorem ipsum dolor sit amet consectetur, adipisicing elit. '),
                const SizedBox(
                  height: 30.0,
                ),
                //  Explore button
                Buttons().longButton('Explore', () {
                  // button on pressed
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const SplashScreen2(),
                  //   ),
                  // );

                  // animation
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                      const SplashScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOut;
                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                            position: offsetAnimation, child: child);
                      },
                      transitionDuration: const Duration(milliseconds: 500),
                    ),
                  );
                }),
                //  Get Started button
                Buttons().longButton('Get Started', () {
                  // onpressed
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const LoginPage(),
                  //   ),
                  // );

                  // animation
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                      const LoginPage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOut;
                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                            position: offsetAnimation, child: child);
                      },
                      transitionDuration: const Duration(milliseconds: 500),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}