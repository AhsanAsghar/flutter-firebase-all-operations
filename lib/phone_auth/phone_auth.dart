import 'package:firebase/phone_auth/otpscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class phoneAuthWidget extends StatefulWidget {
  const phoneAuthWidget({super.key});

  @override
  State<phoneAuthWidget> createState() => _phoneAuthWidgetState();
}

class _phoneAuthWidgetState extends State<phoneAuthWidget> {
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Phone Authentication!',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  hintText: "Enter Phone Number!",
                  suffixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  )),
            ),
          ),
          SizedBox(height: 30),
          ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.verifyPhoneNumber(
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException ex) {},
                    codeSent: (String verificationId, int? resendToken) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OTPScreenWidget(
                                    verificationId: verificationId,
                                  )));
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {},
                    phoneNumber: phoneController.text.toString());
              },
              child: Text("Send Code"))
        ],
      ),
    );
  }
}
