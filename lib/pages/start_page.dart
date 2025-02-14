import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/widgets/button.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double fontSize = screenWidth * 0.1; // 10% of the screen width
    double buttonWidth = screenWidth * 0.5; // Button width as 50% of screen width

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/1.png'), // Path to your image
            fit: BoxFit.cover, // Ensures the image covers the entire background
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: screenHeight * 0.13, // 20% of the screen height for spacing
              ),
              Text(
                "Pet Shop and \nCare Tips",
                style: GoogleFonts.capriola(
                  height: 1.2,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    const Shadow(
                      blurRadius: 10.0,
                      color: Colors.black54,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.05), // 5% of the screen height for padding
                child: SizedBox(
                  width: buttonWidth, // Adjust the button width based on screen size
                  height: screenHeight * 0.08, // Button height as 8% of screen height
                  child: BUTTON(
                    bg_color: Colors.grey,
                    fg_color: Colors.white,
                    title: 'Get Started',
                    opacity: 0.5,
                    onPressed: () {},
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
