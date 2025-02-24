import 'package:accidentapp/Company%20Side/CompanyVerficationCode.dart';
import 'package:accidentapp/Loginoonly.dart';
import 'package:accidentapp/User%20Side/VerificationCode.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String userType = "User";
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  InputDecoration customInputDecoration(String hintText, IconData icon, {bool isPassword = false, VoidCallback? toggleVisibility}) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey[200],
      hintText: hintText,
      prefixIcon: Icon(icon, color: Color(0xFF001E62)),
      suffixIcon: isPassword
          ? IconButton(
              icon: Icon(
                toggleVisibility == _togglePasswordVisibility ? (_obscurePassword ? Icons.visibility_off : Icons.visibility) : (_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility),
                color: Colors.black54,
              ),
              onPressed: toggleVisibility,
            )
          : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Color(0xFF001E62)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Color(0xFF001E62), width: 2),
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 120,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.center,
                colors: [Color(0xFF001E62), Colors.white],
              ),
            ),
            child: const Center(
              child: Text(
                "Register",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    TextField(
                      decoration: customInputDecoration("Enter your email", Icons.email),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      obscureText: _obscurePassword,
                      decoration: customInputDecoration("Enter your password", Icons.lock, isPassword: true, toggleVisibility: _togglePasswordVisibility),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      obscureText: _obscureConfirmPassword,
                      decoration: customInputDecoration("Confirm your password", Icons.lock, isPassword: true, toggleVisibility: _toggleConfirmPasswordVisibility),
                    ),
                    const SizedBox(height: 15),
                    const Text("User Type", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    Row(
                      children: [
                        Radio(
                          value: "User",
                          groupValue: userType,
                          onChanged: (value) {
                            setState(() {
                              userType = value.toString();
                            });
                          },
                        ),
                        const Text("User"),
                        Radio(
                          value: "Company",
                          groupValue: userType,
                          onChanged: (value) {
                            setState(() {
                              userType = value.toString();
                            });
                          },
                        ),
                        const Text("Company"),
                      ],
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (userType == "User") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => VerificationCode()),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Companyverficationcode(),
                            ));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF001E62),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: const Text(
                          "Registration",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const loginOnly()),
                          );
                        },
                        child: const Text.rich(
                          TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: "Sign In",
                                style: TextStyle(color: Color(0xFF001E62), fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
