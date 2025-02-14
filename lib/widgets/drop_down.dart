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
    return  DropdownButton<String>(
              value: selectedBreed,
              hint: const Text('Select Dog Breed'),
              onChanged: (String? newBreed) {
                setState(() {
                  selectedBreed = newBreed;
                  Provider.of<DogData>(context, listen: false).
              getDogBreed(selectedBreed);
                });
              },
              items: <String>['Labrador', 'Bulldog', 'Poodle', 'Beagle', 'Golden Retriever']
                  .map<DropdownMenuItem<String>>((String breed) {
                return DropdownMenuItem<String>(
                  value: breed,
                  child: Text(breed),
                );
              }).toList(),
            );
  }
}