import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'response_screen.dart';
 
class HomeScreen extends StatelessWidget {
  final TextEditingController _inputController = TextEditingController();
  final String backendUrl = "https://c8f2-39-43-141-51.ngrok-free.app/generate-text";
 
  Future<String> fetchResponse(String userInput) async {
    final response = await http.post(
      Uri.parse(backendUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"user_input": userInput}),
    );
 
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data["response"];
    }
    return "Error fetching response";
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("How Are You Feeling?")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _inputController),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String userInput = _inputController.text;
                String response = await fetchResponse(userInput);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResponseScreen(aiResponse: response),
                  ),
                );
              },
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}