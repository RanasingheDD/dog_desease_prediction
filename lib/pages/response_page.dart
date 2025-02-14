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
          "My dog is a ${dogData.breed}, ${dogData.age} years old, and ${dogData.gender}. My dog has these symptoms: ${_controller.text}. What are the possible diseases? summerize 100 words";

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
        title: const Text('Response Page'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Consumer<DogData>(
            builder: (context, value, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Breed: ${dogData.breed}"),
                  Text("Age: ${dogData.age}"),
                  Text("Gender: ${dogData.gender}"),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Enter Symptoms',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : BUTTON(
                          bg_color: Colors.blue,
                          fg_color: Colors.white,
                          title: 'Response',
                          onPressed: _fetchResponse,
                        ),
                  const SizedBox(height: 20),
                  if (_apiResponse.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        _apiResponse,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
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
