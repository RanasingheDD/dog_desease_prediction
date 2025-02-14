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
    {'title': 'Pet Food', 'description': 'Feed your dog \nquality food', 'image': 'assets/5.png'},
    {'title': 'Pet Toy', 'description': 'Take your dog \nfor regular \nwalks and play', 'image': 'assets/3.png'},
    {'title': 'Pet Shampoo', 'description': 'Take your dog \nto the vet \nfor check-ups', 'image': 'assets/4.png'},
    {'title': 'Pet Bed', 'description': 'Spend quality time \nwith your dog', 'image': 'assets/2.png'},
  ];

  String? selectedBreed;
  int? dogAge;
  String? dogGender = 'Male'; // Default value for gender

  // Function to automatically scroll horizontally
  void _autoScroll() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
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
      appBar: AppBar(
        title: const Text(
          'Welcome to the Pet Care Shop',
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Product card scroll
            SizedBox(
              height: screenHeight * 0.35,  // Height of the product card container
              child: ListView.builder(
                scrollDirection: Axis.horizontal, // Horizontal list
                controller: _scrollController,
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  final product = _products[index];
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        width: 180,
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: AssetImage(product['image']!), // Add product image path
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: screenHeight * 0.05),
                                Text(
                                  product['description']!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
              decoration: const InputDecoration(
                labelText: 'Enter Dog Age (Years)',
                border: OutlineInputBorder(),
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
              children: [
                const Text('Gender:'),
                Radio<String>(
                  value: 'Male',
                  groupValue: dogGender,
                  onChanged: (String? value) {
                    setState(() {
                      dogGender = value;
                    });
                  },
                ),
                const Text('Male'),
                Radio<String>(
                  value: 'Female',
                  groupValue: dogGender,
                  onChanged: (String? value) {
                    setState(() {
                      dogGender = value;
                    });
                  },
                ),
                const Text('Female'),
              ],
            ),

            SizedBox(height: screenHeight * 0.05),
            SizedBox(
              height: screenWidth * 0.14,
              child: BUTTON(
              bg_color: Colors.blue, 
              fg_color: Colors.white, 
              title: 'Next ➡', 
              onPressed: (){
                // When you update the data
              Provider.of<DogData>(context, listen: false).
              getDogData(dogAge, dogGender);
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ResponsePage(),
                ),
              );

              }
              ),
            )
          ],
        ),
      ),
    );
  }
}
