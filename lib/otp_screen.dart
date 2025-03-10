import 'package:accidentapp/Email_Verification.dart';
import 'package:flutter/material.dart';

class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isSending = false;

  Future<void> _sendOTP() async {
    String email = _emailController.text.trim();

    if (email.isEmpty || !email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Enter a valid email!")),
      );
      return;
    }

    setState(() {
      _isSending = true;
    });

    bool success = await sendOTP(email);

    setState(() {
      _isSending = false;
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OTP sent to $email")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to send OTP!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Email OTP Verification")),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: "Enter your email"),
            ),
            SizedBox(height: 20),
            _isSending
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _sendOTP,
                    child: Text("Send OTP"),
                  ),
          ],
        ),
      ),
    );
  }
}
