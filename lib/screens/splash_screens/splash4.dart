import 'package:flutter/material.dart';
import 'package:nala_c/screens/splash_screens/splash5.dart';
import '../../widget/button.dart';
import '../../widget/splash_generator.dart';

class SplashScreen5 extends StatefulWidget {
  const SplashScreen5({super.key});

  @override
  State<SplashScreen5> createState() => _SplashScreen5State();
}

class _SplashScreen5State extends State<SplashScreen5> {
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
                SplashGenerator().title('Multiple vehicle options'),
                // splash illustraion image
                SplashGenerator()
                    .splashImage('assets/images/splash_vehicle.png'),
                // splash body
                SplashGenerator().bodyText(
                    'Lorem ipsum dolor sit amet consectetur, adipisicing elit. '),
                const SizedBox(
                  height: 30.0,
                ),
                //  next button
                Buttons().longButton('next', () {
                  // button on pressed
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const SplashScreen6(),
                  //   ),
                  // );

                  // animation
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                      const SplashScreen6(),
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