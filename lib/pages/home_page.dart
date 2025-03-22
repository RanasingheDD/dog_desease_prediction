import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myapp/pages/response_page.dart';
import 'package:myapp/provider/dog_data_provider.dart';
import 'package:myapp/widgets/button.dart';
import 'package:myapp/widgets/drop_down.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, String>> _products = [
    {
      'title': 'Pet Food',
      'description': 'Feed your dog \nquality food',
      'image': 'assets/5.png'
    },
    {
      'title': 'Pet Toy',
      'description': 'Take your dog \nfor regular \nwalks and play',
      'image': 'assets/3.png'
    },
    {
      'title': 'Pet Shampoo',
      'description': 'Take your dog \nto the vet \nfor check-ups',
      'image': 'assets/4.png'
    },
    {
      'title': 'Pet Bed',
      'description': 'Spend quality time \nwith your dog',
      'image': 'assets/2.png'
    },
  ];

  String? selectedBreed;
  int? dogAge;
  String? dogGender = 'Male'; // Default value for gender

  // Function to automatically scroll horizontally
  void _autoScroll() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // If reached end, reset to the beginning
        _scrollController.jumpTo(0);
      } else {
        // Scroll by a fixed width to the right
        _scrollController.animateTo(
          _scrollController.offset + 200, // Scroll by 200px every 3 seconds
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // Start the auto-scrolling once the widget is initialized
    _autoScroll();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          '🐾 Welcome to the Dog Care 🐾',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor:
            Colors.blueAccent.withOpacity(0.7), // Transparent AppBar
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Opacity(
              opacity: 0.2, // Adjust transparency
              child: Image.asset(
                'assets/3.png', // Change to your image path
                fit: BoxFit.cover,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(10,35,10,5),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                      height:
                          screenHeight * 0.08), // Space for transparent AppBar

                  // Product Card Scroll
                  SizedBox(
                    height: screenHeight * 0.35,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _scrollController,
                      itemCount: _products.length,
                      itemBuilder: (context, index) {
                        final product = _products[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Stack(
                              children: [
                                Container(
                                  width: 180,
                                  height: 250,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      image: AssetImage(product['image']!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: const BorderRadius.vertical(
                                          bottom: Radius.circular(15)),
                                    ),
                                    child: Text(
                                      product['description']!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.05),

                  // Dog Breed Selection Dropdown
                  const DROPDOWN(),

                  SizedBox(height: screenHeight * 0.05),

                  // Dog Age Input
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Enter Dog Age (Years)',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      prefixIcon: const Icon(Icons.cake, color: Colors.blue),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                    onChanged: (value) {
                      setState(() {
                        dogAge = int.tryParse(value);
                      });
                    },
                  ),

                  SizedBox(height: screenHeight * 0.03),

                  // Dog Gender Selection
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Gender:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'Male',
                            groupValue: dogGender,
                            onChanged: (String? value) {
                              setState(() {
                                dogGender = value;
                              });
                            },
                          ),
                          const Text('Male', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'Female',
                            groupValue: dogGender,
                            onChanged: (String? value) {
                              setState(() {
                                dogGender = value;
                              });
                            },
                          ),
                          const Text('Female', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: screenHeight * 0.05),

                  // Next Button
                  SizedBox(
                    width: screenWidth * 0.6,
                    child: BUTTON(
                        bg_color: Colors.blueAccent,
                        fg_color: Colors.white,
                        title: 'Next ➡',
                        onPressed: () {
                          if (dogAge != null && dogGender != null) {
                            // If both age and gender are valid, get dog data and navigate
                            Provider.of<DogData>(context, listen: false)
                                .getDogData(dogAge, dogGender);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ResponsePage()),
                            );
                          } else {
                            // If any of the fields is null, show an error message
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Please fill in all fields'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
