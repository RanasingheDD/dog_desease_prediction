import 'package:flutter/material.dart';
import 'package:myapp/provider/dog_data_provider.dart';
import 'package:provider/provider.dart';

class DROPDOWN extends StatefulWidget {
  const DROPDOWN({super.key});

  @override
  State<DROPDOWN> createState() => _DROPDOWNState();
}

class _DROPDOWNState extends State<DROPDOWN> {
  String? selectedBreed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black54, width: 1.5),
        color: Colors.white.withOpacity(0.9),
      ),
      child: DropdownButtonFormField<String>(
        value: selectedBreed,
        isExpanded: true, // Ensures full-width dropdown
        decoration: const InputDecoration(
          border: InputBorder.none, // Removes default border
          contentPadding: EdgeInsets.symmetric(vertical: 12),
        ),
        hint: const Text(
          '🐶 Select Dog Breed',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        onChanged: (String? newBreed) {
          setState(() {
            selectedBreed = newBreed;
            Provider.of<DogData>(context, listen: false).getDogBreed(selectedBreed);
          });
        },
        items: <String>[
          'Labrador', 'Rottweiler', 'Bulldog', 'Poodle', 'Beagle', 'Golden Retriever', 'Other'
        ].map<DropdownMenuItem<String>>((String breed) {
          return DropdownMenuItem<String>(
            value: breed,
            child: Text(
              breed,
              style: const TextStyle(fontSize: 16),
            ),
          );
        }).toList(),
      ),
    );
  }
}
