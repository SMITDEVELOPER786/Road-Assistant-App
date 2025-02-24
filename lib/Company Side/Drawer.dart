import 'package:accidentapp/User Side/HelpSupport.dart';
import 'package:accidentapp/User Side/HistoryService.dart';
import 'package:accidentapp/User Side/Notification.dart';
import 'package:accidentapp/User Side/Request/RequestService.dart';
import 'package:accidentapp/User Side/home_screen.dart';
import 'package:accidentapp/User%20Side/Register.dart';
import 'package:accidentapp/User%20Side/Settings.dart';
import 'package:flutter/material.dart';

class CompanyDrawer extends StatelessWidget {
  const CompanyDrawer({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFF001E62), // Dark blue background
        child: Column(
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFF001E62),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 50, color: Color(0xFF001E62)),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'jack',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'jack@yupmail.com',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Menu Items Section
            Expanded(
              child: ListView(
                children: [
                  buildMenuItem(
                    context,
                    icon: Icons.dashboard,
                    title: "Dashboard",
                    destination: HomeScreen(),
                  ),
                  buildMenuItem(
                    context,
                    icon: Icons.location_on,
                    title: "Add/Edit Services",
                    destination: HomeScreen(),
                  ),
                  buildMenuItem(
                    context,
                    icon: Icons.build,
                    title: "Service Request",
                    destination: HomeScreen(),
                  ),
                  buildMenuItem(
                    context,
                    icon: Icons.notifications,
                    title: "Client Issue Details",
                    destination: HomeScreen(),
                  ),
                  buildMenuItem(
                    context,
                    icon: Icons.person,
                    title: "Manage Locations",
                    destination: HomeScreen(),
                  ),
                  buildMenuItem(
                    context,
                    icon: Icons.help_outline,
                    title: "Service History",
                    destination: HomeScreen(),
                  ),
                    buildMenuItem(
                    context,
                    icon: Icons.help_outline,
                    title: "Notifications",
                    destination: HomeScreen(),
                  ),
                    buildMenuItem(
                    context,
                    icon: Icons.help_outline,
                    title: "Account Settings",
                    destination: HomeScreen(),
                  ),
                    buildMenuItem(
                    context,
                    icon: Icons.help_outline,
                    title: "Help & Support",
                    destination: HomeScreen(),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.logout, color: const Color(0xFF001E62)),
                    ),
                    title: const Text(
                      "Log Out",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {
                      _showLogoutDialog(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Center(child: Text("Logout")),
          content: Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel",style: TextStyle(color:  Color(0xFF001E62)),),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationScreen()),
                );
              },
              child: Text("Yes, Logout", style: TextStyle(color:  Color(0xFF001E62))),
            ),
          ],
        );
      },
    );
  }

  Widget buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Widget destination,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(icon, color: const Color(0xFF001E62)),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
    );
  }
}
