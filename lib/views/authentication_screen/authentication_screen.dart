import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:yummygo/controllers/authentication_controller.dart';
import 'package:yummygo/services/google_signin_service.dart';
import 'package:yummygo/views/home_screen/home_screen.dart';
import 'package:yummygo/views/phone_auth_screens/phone_auth_screen.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/wall.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: logincontainer(context),
      ),
    );
  }

  Widget logincontainer(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.sizeOf(context).width * .9,
        height: MediaQuery.sizeOf(context).height * .5,
        decoration: BoxDecoration(
          color: Colors.black54,
          border: Border.all(color: Colors.white70),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            //yummyGo Text
            logo(),
            SizedBox(height: 50),
            //Email Button
            gmailButton(context),
            SizedBox(height: 30),
            //Phone Button
            phoneButton(context),
          ],
        ),
      ),
    );
  }

  Widget logo() {
    return Text(
      "YummiGo",
      style: GoogleFonts.poppins(
        color: Colors.white,
        fontWeight: .bold,
        fontSize: 30,
      ),
    );
  }

  Widget gmailButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () async {
          final provider = Provider.of<AuthenticationController>(
            context,
            listen: false,
          );
          await provider.login();

          if (provider.user != null) {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                transitionDuration: Duration(microseconds: 500),
                pageBuilder: (_, animation, _) =>
                    FadeTransition(opacity: animation, child: HomeScreen()),
              ),
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: .center,
              spacing: 10,
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: AssetImage('assets/images/google.jpeg'),
                ),
                Text(
                  "Sign in with Google",
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: .w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget phoneButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => PhoneLoginScreen()),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: .center,
              spacing: 10,
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: AssetImage('assets/images/phone.jpg'),
                ),
                Text(
                  "Sign in with Mobile",
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: .w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
