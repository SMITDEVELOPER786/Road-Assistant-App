import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:accidentapp/Company%20Side/CompanyVerficationCode.dart';
import 'package:accidentapp/Loginoonly.dart';
import 'package:accidentapp/User%20Side/VerificationCode.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String userType = "User";
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  bool _isValidPassword(String password) {
    final regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\W).{8,}$');
    return regex.hasMatch(password);
  }

  void _register() async {
    if (_emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Enter Email")));
      return;
    }
    if (_passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Enter Password")));
      return;
    }
    if (_confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Confirm your Password")));
      return;
    }
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Passwords do not match!")));
      return;
    }
    if (!_isValidPassword(_passwordController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            "Password must be at least 8 characters long, include at least one lowercase letter, one uppercase letter, and one special character."),
      ));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registration Successful!")));

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              userType == "User" ? VerificationCode() : Companyverficationcode(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registration failed: ${e.toString()}")));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "Enter your email",
                      prefixIcon: Icon(Icons.email, color: Color(0xFF001E62)),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    enabled: !_isLoading,
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: "Enter your password",
                      prefixIcon: Icon(Icons.lock, color: Color(0xFF001E62)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Color(0xFF001E62),
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    enabled: !_isLoading,
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    decoration: InputDecoration(
                      hintText: "Confirm your password",
                      prefixIcon: Icon(Icons.lock, color: Color(0xFF001E62)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Color(0xFF001E62),
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                    ),
                    enabled: !_isLoading,
                  ),
                  const SizedBox(height: 15),
                  const Text("User Type"),
                  Row(
                    children: [
                      Radio(
                        value: "User",
                        groupValue: userType,
                        onChanged: _isLoading
                            ? null
                            : (value) {
                                setState(() {
                                  userType = value.toString();
                                });
                              },
                      ),
                      const Text("User"),
                      Radio(
                        value: "Company",
                        groupValue: userType,
                        onChanged: _isLoading
                            ? null
                            : (value) {
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
                      onPressed: _isLoading ? null : _register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF001E62),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              "Register",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: GestureDetector(
                      onTap: _isLoading
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const loginOnly(),
                                ),
                              );
                            },
                      child: const Text("Already have an account? Sign In"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
