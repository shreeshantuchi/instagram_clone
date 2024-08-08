import 'package:flutter/material.dart';
import 'package:login_token_app/core/theme/textThme.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: InkWell(
            onTap: () {},
            child: Container(
              width: width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(width * 0.1),
                child: Image.asset('images/user_icon.png'),
              ),
            )),
        title: Center(
          child: Text(
            'Social Media',
            style: instagramTextTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}
