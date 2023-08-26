import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../widget/button.dart';
import '../../widget/splash_generator.dart';



class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({super.key});

  @override
  State<SplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // splash title
                SplashGenerator().title('Services'),
                const SizedBox(
                  height: 30,
                ),
                // services text
                SplashGenerator().bodyText(
                    'Lorem ipsum dolor sit amet consectetur, adipisicing elit. Laborum ex nisi eveniet harum.'),

                const SizedBox(
                  height: 40,
                ),
                SplashGenerator().services('car', 'On-Demand Rides'),
                const SizedBox(
                  height: 35,
                ),
                SplashGenerator().services('clock', 'Scheduled Rides   '),
                const SizedBox(
                  height: 35,
                ),
                SplashGenerator().services('carSide', 'Multiple Vehicles '),
                const SizedBox(
                  height: 35,
                ),
                SplashGenerator().services('taxi', 'Shared Rides         '),
                const SizedBox(
                  height: 100.0,
                ),
                //  next button
                Buttons().longButton('next', () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SplashScreen2(),
                    ),
                  );

                  // animation
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                      const SplashScreen2(),
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