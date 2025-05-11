import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
 
class ResponseScreen extends StatefulWidget {
  final String aiResponse;
 
  ResponseScreen({required this.aiResponse});
 
  @override
  _ResponseScreenState createState() => _ResponseScreenState();
}
 
class _ResponseScreenState extends State<ResponseScreen> {
  final AudioPlayer audioPlayer = AudioPlayer();
  String selectedVoice = "Soft";
  final String backendUrl = "http://127.0.0.1:5000/generate-voice";
 
  @override
  void initState() {
    super.initState();
    loadVoice();
  }
 
  Future<void> loadVoice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedVoice = prefs.getString("selectedVoice") ?? "Soft";
    });
  }
 
  Future<void> playAudio(String text) async {
    final response = await http.post(
      Uri.parse(backendUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"text": text, "voice": selectedVoice}),
    );
 
    final data = json.decode(response.body);
    await audioPlayer.play(data["audio_url"]);
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your ASMR Response")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => playAudio(widget.aiResponse),
          child: Text("Play ASMR in $selectedVoice voice"),
        ),
      ),
    );
  }
}