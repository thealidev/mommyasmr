import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
 
class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}
 
class _SettingsScreenState extends State<SettingsScreen> {
  String selectedVoice = "Soft";
  List<String> voices = ["Soft", "Motherly", "Gentle"];
 
  Future<void> saveVoice(String voice) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("selectedVoice", voice);
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Column(
        children: voices.map((voice) {
          return ListTile(
            title: Text(voice),
            trailing: Radio(
              value: voice,
              groupValue: selectedVoice,
              onChanged: (String? value) {
                setState(() {
                  selectedVoice = value!;
                  saveVoice(value);
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}