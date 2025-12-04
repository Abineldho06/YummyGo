import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yummygo/controllers/authentication_controller.dart';
import 'package:yummygo/views/home_screen/home_screen.dart';

class OTPScreen extends StatelessWidget {
  final String phone;
  OTPScreen({super.key, required this.phone});

  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthenticationController>(
      context,
      listen: false,
    );

    return Scaffold(
      appBar: AppBar(title: Text("Verify OTP")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text("OTP sent to $phone"),
            SizedBox(height: 20),
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter OTP",
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                bool ok = await provider.verifyOTP(otpController.text.trim());

                if (ok) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => HomeScreen()),
                    (route) => false,
                  );
                } else {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Invalid OTP")));
                }
              },
              child: Text("Verify"),
            ),
          ],
        ),
      ),
    );
  }
}
