import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SplashGenerator {
  Widget title(title) {
    return Padding(
      padding:
      const EdgeInsets.only(left: 15.0, right: 15.0, top: 0, bottom: 0),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xffffffff),
          fontSize: 40,
          fontFamily: 'Ubuntu',
        ),
      ),
    );
  }

  Widget splashImage(imagePath) {
    return Padding(
      padding:
      const EdgeInsets.only(left: 10.0, right: 10.0, top: 0, bottom: 0),
      child: SizedBox(
        height: 400,
        width: double.infinity,
        child: Image.asset(imagePath),
      ),
    );
  }

  Widget bodyText(text) {
    return Padding(
      padding:
      const EdgeInsets.only(left: 10.0, right: 10.0, top: 0, bottom: 0),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          text,
          style: const TextStyle(
            color: Color(0xffffffff),
            fontFamily: 'Poppins',
            fontSize: 17,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget services(String iconName, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 45,
          width: 45,
          child: FaIcon(
            _getIconData(iconName),
            color: const Color(0xffffffff),
            size: 35,
          ),
        ),
        SizedBox(
          height: 45,
          child: Text(
            title,
            style: const TextStyle(
              color: Color(0xffffffff),
              fontFamily: 'Ubuntu',
              fontSize: 35,
            ),
          ),
        ),
      ],
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'car':
        return FontAwesomeIcons.car;
      case 'clock':
        return FontAwesomeIcons.clock;
      case 'carSide':
        return FontAwesomeIcons.carSide;
      case 'taxi':
        return FontAwesomeIcons.taxi;
      default:
        return FontAwesomeIcons.solidCircle;
    }
  }
}