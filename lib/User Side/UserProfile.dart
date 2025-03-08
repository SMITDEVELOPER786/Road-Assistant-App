import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:accidentapp/User%20Side/home_screen.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  File? _image;
  String? _selectedGender;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  bool _isLoading = false; // Loading indicator

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  InputDecoration customInputDecoration(String hintText, IconData icon,
      {Widget? suffixIcon}) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey[200],
      hintText: hintText,
      prefixIcon: Icon(icon, color: Color(0xFF001E62)),
      suffixIcon: suffixIcon,
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

  Future<void> _storeUserData() async {
    if (_nameController.text.isEmpty ||
        _addressController.text.isEmpty ||
        _ageController.text.isEmpty ||
        _selectedGender == null ||
        _contactController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'name': _nameController.text.trim(),
        'address': _addressController.text.trim(),
        'age': _ageController.text.trim(),
        'gender': _selectedGender,
        'contact': _contactController.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile Created Successfully!")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to save data: ${e.toString()}")),
      );
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
                end: Alignment.bottomCenter,
                colors: [Color(0xFF001E62), Colors.white],
              ),
            ),
            child: const Center(
              child: Text(
                "Create Profile",
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey[300],
                          backgroundImage:
                              _image != null ? FileImage(_image!) : null,
                          child: _image == null
                              ? const Icon(Icons.camera_alt,
                                  size: 40, color: Colors.black54)
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text("Upload Profile Picture (optional)",
                        style:
                            TextStyle(fontSize: 14, color: Color(0xFF001E62))),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _nameController,
                      decoration: customInputDecoration(
                          "Enter your name", Icons.person),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _addressController,
                      decoration: customInputDecoration(
                        "Enter your address",
                        Icons.home,
                        suffixIcon: IconButton(
                          icon:
                              Icon(Icons.location_on, color: Color(0xFF001E62)),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _ageController,
                      decoration: customInputDecoration(
                          "Enter your age", Icons.calendar_today),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 15),
                    DropdownButtonFormField<String>(
                      decoration:
                          customInputDecoration("Select your gender", Icons.wc),
                      value: _selectedGender,
                      items: ["Male", "Female"].map((String gender) {
                        return DropdownMenuItem<String>(
                          value: gender,
                          child: Text(gender),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedGender = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _contactController,
                      decoration: customInputDecoration(
                          "Enter your contact number", Icons.phone),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _storeUserData,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF001E62),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : const Text(
                                "Create",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                      ),
                    ),
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
