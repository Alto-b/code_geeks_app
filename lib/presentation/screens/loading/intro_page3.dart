
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class IntroPage3 extends StatefulWidget {
  const IntroPage3({super.key});

  @override
  State<IntroPage3> createState() => _IntroPage3State();
}

class _IntroPage3State extends State<IntroPage3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.amber,
 backgroundColor: const Color.fromARGB(255, 110, 132, 214),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Now Let's Get To Work",style: GoogleFonts.cinzel(
                color: Colors.white,
                fontSize: 20,
                letterSpacing: 2,
                fontWeight: FontWeight.w600
                ),),
              const SizedBox(height: 20,),
              SizedBox(
                width: 300,
                height: 300,
                child: Lottie.asset('lib/assets/intro3.json'),
                )
            ],
        ),
      ),
    );
  }
}