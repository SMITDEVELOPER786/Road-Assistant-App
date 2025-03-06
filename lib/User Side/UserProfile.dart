import 'dart:io';
import 'package:accidentapp/User%20Side/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  File? _image;
  String? _selectedGender;
  TextEditingController _addressController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  InputDecoration customInputDecoration(String hintText, IconData icon, {Widget? suffixIcon}) {
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
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      GestureDetector(
            onTap: _pickImage,
            child: Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null
                    ? const Icon(Icons.camera_alt, size: 40, color: Colors.black54)
                    : null,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text("Upload Profile Picture", style: TextStyle(fontSize: 14, color: Color(0xFF001E62))),
                    const SizedBox(height: 20),
                    TextField(
                      decoration: customInputDecoration("Enter your name", Icons.person),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      decoration: customInputDecoration(
                        "Enter your address",
                        Icons.home,
                        suffixIcon: IconButton(
                          icon: Icon(Icons.location_on, color: Color(0xFF001E62)),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      decoration: customInputDecoration("Enter your age", Icons.calendar_today),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 15),
                    DropdownButtonFormField<String>(
                      decoration: customInputDecoration("Select your gender", Icons.wc),
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
                      decoration: customInputDecoration("Enter your contact address", Icons.phone),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF001E62),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: const Text("Create", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
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
