import 'package:event_app/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

class OnBoardScreen extends StatelessWidget {
  const OnBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GestureDetector(
            onTap: () { 
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HomeScreen())
              );
            },
            child: Stack(
              children: [
                Center(
                  child:  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/ob_bg.png'), // First background image
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
