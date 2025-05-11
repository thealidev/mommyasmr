import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'settings_screen.dart';
 
void main() {
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mommy ASMR',
      theme: ThemeData(
        primarySwatch: Colors.blue, // It's good practice to keep a primary color
        scaffoldBackgroundColor: Colors.black, // Set the background color here
      ),

      home: MainScreen(),
    );
  }
}
 
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}
 
class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
 
  static List<Widget> _screens = <Widget>[
    HomeScreen(),
    SettingsScreen(),
  ];
 
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}