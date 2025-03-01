import 'package:flutter/material.dart';

class LocationPicker extends StatefulWidget {
  final Function(String) onLocationSelected;

  const LocationPicker({Key? key, required this.onLocationSelected}) : super(key: key);

  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  final TextEditingController _controller = TextEditingController();
  List<String> _locations = [];
  List<String> _filteredLocations = [];

  @override
  void initState() {
    super.initState();
    _locations = [
      "Paris, France",
      "Pisa, Italy",
      "Rome, Italy",
      "Berlin, Germany",
      "Madrid, Spain",
      "London, UK"
      
    ];
  }

  void _filterLocations(String query) {
    setState(() {
      _filteredLocations = _locations
          .where((location) => location.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _clearInput() {
    _controller.clear();
    _filterLocations('');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Input Field for Searching Locations
        TextField(
          controller: _controller,
          onChanged: _filterLocations,
          decoration: InputDecoration(
            hintText: 'Search for a location',
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: _clearInput,
            ),
          ),
        ),
        // List of Filtered Locations
        Expanded(
          child: ListView.builder(
            itemCount: _filteredLocations.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_filteredLocations[index]),
                onTap: () {
                  widget.onLocationSelected(_filteredLocations[index]);
                  Navigator.of(context).pop(); // Close the picker
                },
              );
            },
          ),
        ),
      ],
    );
  }
}