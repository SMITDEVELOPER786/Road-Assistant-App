import 'package:flutter/material.dart';

class home extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<home> {
  int _selectedIndex = 1; // Default selected index

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Tab ${_selectedIndex + 1} Selected',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: Container(
        color: Color(0xFF001E62),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.white,
          unselectedItemColor: Color(0xFF001E62),
          showSelectedLabels: true,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          items: [
            // Home Tab
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: _selectedIndex == 0 ? Color(0xFF001E62) : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.home,
                      size: 28,
                      color: _selectedIndex == 0 ? Colors.white : Color(0xFF001E62),
                    ),
                    if (_selectedIndex == 0)
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          'Home',
                          style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ),
                  ],
                ),
              ),
              label: '',
            ),
            // Service Tab
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: _selectedIndex == 1 ? Color(0xFF001E62) : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.home_repair_service,
                      size: 28,
                      color: _selectedIndex == 1 ? Colors.white : Color(0xFF001E62),
                    ),
                    if (_selectedIndex == 1)
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          'Service',
                          style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ),
                  ],
                ),
              ),
              label: '',
            ),
            // Track Tab (Same Design as Home and Service)
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: _selectedIndex == 2 ? Color(0xFF001E62) : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.directions_car,
                      size: 28,
                      color: _selectedIndex == 2 ? Colors.white : Color(0xFF001E62),
                    ),
                    if (_selectedIndex == 2)
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          'Track',
                          style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ),
                  ],
                ),
              ),
              label: '',
            ),
            // Profile Tab (Same Design as Home and Service)
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: _selectedIndex == 3 ? Color(0xFF001E62) : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.person,
                      size: 28,
                      color: _selectedIndex == 3 ? Colors.white : Color(0xFF001E62),
                    ),
                    if (_selectedIndex == 3)
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          'Profile',
                          style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ),
                  ],
                ),
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
