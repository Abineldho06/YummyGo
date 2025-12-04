import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:yummygo/controllers/authentication_controller.dart';
import 'package:yummygo/views/phone_auth_screens/otp_screen.dart';

class PhoneLoginScreen extends StatelessWidget {
  PhoneLoginScreen({super.key});

  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthenticationController>(
      context,
      listen: false,
    );

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/authentication.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(color: Colors.black38),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              "Mobile Login",
              style: GoogleFonts.montserrat(
                fontWeight: .bold,
                color: Colors.white,
              ),
            ),
            leading: BackButton(color: Colors.white),
            backgroundColor: Colors.transparent,
          ),
          body: body(context, provider),
        ),
      ),
    );
  }

  Widget body(BuildContext context, AuthenticationController provider) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: MediaQuery.sizeOf(context).width * .9,
          height: MediaQuery.sizeOf(context).height * .5,
          decoration: BoxDecoration(
            color: Colors.white54,
            border: Border.all(color: Colors.white70),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: .start,
              children: [
                Image.asset(
                  'assets/images/logotext.png',
                  width: 200,
                  height: 200,
                ),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter Mobile Number",
                    labelStyle: TextStyle(color: Colors.black),
                    prefixText: "+91 ",
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.black),
                  ),
                  onPressed: () {
                    final phone = "+91${phoneController.text.trim()}";

                    provider.sendOTP(
                      phoneNumber: phone,
                      onCodeSent: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OTPScreen(phone: phone),
                          ),
                        );
                      },
                      onError: (err) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(err)));
                      },
                    );
                  },
                  child: Text(
                    "Send OTP",
                    style: TextStyle(color: Colors.white),
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
