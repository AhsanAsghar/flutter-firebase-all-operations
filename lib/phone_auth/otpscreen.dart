import 'dart:developer';
import 'package:firebase/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OTPScreenWidget extends StatefulWidget {
  String verificationId;
  OTPScreenWidget({super.key, required this.verificationId});

  @override
  State<OTPScreenWidget> createState() => _OTPScreenWidgetState();
}

class _OTPScreenWidgetState extends State<OTPScreenWidget> {
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "OTP Screen",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter OTP!",
                suffixIcon: Icon(Icons.phone),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () async {
                try {
                  PhoneAuthCredential credential =
                      await PhoneAuthProvider.credential(
                          verificationId: widget.verificationId,
                          smsCode: otpController.text.toString());
                  FirebaseAuth.instance
                      .signInWithCredential(credential)
                      .then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyHomePage()));
                  });
                } catch (e) {
                  log(e.toString());
                }
              },
              child: Text("Verify OTP!"))
        ],
      ),
    );
  }
}
