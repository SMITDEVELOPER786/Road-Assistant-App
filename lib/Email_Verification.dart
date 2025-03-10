import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

const serviceID = 'service_2e18lxf'; // Replace with your EmailJS service ID
const templateID = 'template_ha3dted'; // Replace with your EmailJS template ID
const publicKey = 'zpls0evSRmr6bomCn'; // Replace with your EmailJS public key
//  const privateKey = 'P5S6_xJAWWMF2sT1DXbn2';
// Function to generate a 6-digit OTP
String generateOTP() {
  Random random = Random();
  int otp = 100000 + random.nextInt(900000 - 100000); // Ensures OTP is 6 digits
  return otp.toString();
}

// Function to send OTP via Email using REST API
Future<bool> sendOTP(String recipientEmail) async {
  String otp = generateOTP();
  print("Generated OTP: $otp");

  final Map<String, dynamic> emailData = {
    'service_id': serviceID,
    'template_id': templateID,
    'user_id': publicKey, // Use publicKey here
    'template_params': {
      'to_email': recipientEmail, // ✅ Matches {{to_email}} in EmailJS template
      'otp': otp, // ✅ Matches {{otp}} in EmailJS template
    }
  };

  try {
    final response = await http.post(
      Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(emailData),
    );

    if (response.statusCode == 200) {
      print('OTP Sent Successfully to $recipientEmail!');
      return true;
    } else {
      print('Failed to send OTP. Status Code: ${response.statusCode}');
      print('Response: ${response.body}');
      return false;
    }
  } catch (error) {
    print('Error sending OTP: $error');
    return false;
  }
}
