import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/provider/dog_data_provider.dart';
import 'package:myapp/widgets/button.dart';
import 'package:provider/provider.dart';

class ResponsePage extends StatefulWidget {
  const ResponsePage({super.key});

  @override
  State<ResponsePage> createState() => _ResponsePageState();
}

class _ResponsePageState extends State<ResponsePage> {
  final TextEditingController _controller = TextEditingController();
  String _apiResponse = ''; // To store API response
  bool _isLoading = false; // Loading indicator

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Function to call OpenRouter API
  Future<void> _fetchResponse() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    try {
      final dogData = Provider.of<DogData>(context, listen: false);
      final prompt =
          "My dog is a ${dogData.breed}, ${dogData.age} years old, and ${dogData.gender}. My dog has these symptoms: ${_controller.text}. What are the possible diseases? give only most 2 desease and treatment for it. summerize 50 words";

      final response = await fetchOpenRouterResponse(prompt);
      setState(() {
        _apiResponse = response; // Update response
      });
    } catch (e) {
      setState(() {
        _apiResponse = 'Error: $e'; // Show error message
      });
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
    }
  }

  // Function to fetch response from OpenRouter API
  Future<String> fetchOpenRouterResponse(String prompt) async {
    const apiKey =
        "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"; // Your OpenRouter API key
    const model = "deepseek/deepseek-r1:free"; // Choose model
    final apiUrl = Uri.parse("https://openrouter.ai/api/v1/chat/completions");

    try {
      final response = await http.post(
        apiUrl,
        headers: {
          "Authorization": "Bearer $apiKey",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "model": model,
          "messages": [
            {"role": "user", "content": prompt}
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data["choices"][0]["message"]["content"];
      } else {
        throw Exception("Failed to load response: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Request Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final dogData = Provider.of<DogData>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dog Diagnosis',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Consumer<DogData>(
            builder: (context, value, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("🐶 Breed: ${dogData.breed}",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Text("📆 Age: ${dogData.age} years",
                              style: TextStyle(fontSize: 18)),
                          Text("⚧ Gender: ${dogData.gender}",
                              style: TextStyle(fontSize: 18)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Enter Symptoms',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      prefixIcon: Icon(Icons.sick, color: Colors.red),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : BUTTON(
                      bg_color: Colors.blue,
                      fg_color: Colors.white,
                      title: '🔍 Get Diagnosis',
                      onPressed: () {
                        if (_controller.text.isNotEmpty) {
                          _fetchResponse();
                        } else {
                          // Optionally show a message if the text field is empty
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter symptoms'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                    ),

                  const SizedBox(height: 20),
                  if (_apiResponse.isNotEmpty)
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        _apiResponse.replaceAll(RegExp(r'[^\w\s.,]'), ''), // Removes special characters
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
