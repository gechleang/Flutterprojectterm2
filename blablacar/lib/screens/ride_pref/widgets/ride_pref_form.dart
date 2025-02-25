import 'package:blablacar/screens/ride_pref/widgets/actions/BlaButton.dart';
import 'package:blablacar/theme/theme.dart';
import 'package:blablacar/utils/animations_util.dart';
import 'package:blablacar/widgets/display/bla_divider.dart';
import 'package:flutter/material.dart';

import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';

/// A Ride Preference Form is a view to select:
/// - A departure location
/// - An arrival location
/// - A date
/// - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  /// Callback triggered when form is submitted
  final ValueChanged<RidePref> onSubmit;

  const RidePrefForm({super.key, this.initRidePref, required this.onSubmit});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  // Select departure location
  Location? departure;

  // Select departure time
  late DateTime departureDate;

  // Select arrival location
  Location? arrival;

  // Number of Passengers
  late int requestedSeats;

  /// Valid Form when both locations and date are selected
  bool get _isFormFieldValid =>
      departure != null &&
      arrival != null &&
      departureDate.isAfter(DateTime.now());

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    _initializeFormData();
  }

  // Initialize form fields from provided RidePref or default values
  void _initializeFormData() {
    final pref = widget.initRidePref;
    departure = pref?.departure;
    arrival = pref?.arrival;
    departureDate = pref?.departureDate ?? DateTime.now();
    requestedSeats = pref?.requestedSeats ?? 1;
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  // Handle to open LocationSearchScreen with Bottom-to-Top transition
  Future<void> _handleDepartureSelect() async {
    final selectedLocation = await Navigator.push<Location>(
      context,
      createBottomToTopRoute(const LocationSearchScreen()),
    );
    if (selectedLocation != null) {
      setState(() {
        departure = selectedLocation;
      });
    }
  }

  // Handle to open LocationSearchScreen with Bottom-to-Top transition
  Future<void> _handleArrivalSelect() async {
    final selectedLocation = await Navigator.push<Location>(
      context,
      createBottomToTopRoute(const LocationSearchScreen()),
    );
    if (selectedLocation != null) {
      setState(() {
        arrival = selectedLocation;
      });
    }
  }

  void _handleDateSelect(DateTime date) {
    setState(() {
      departureDate = date;
    });
  }

  void _handleSeatsSelect(int seats) {
    setState(() {
      requestedSeats = seats;
    });
  }

  // Creates and submits a RidePref object when form is valid
  void _handleSubmit() {
    if (_isFormFieldValid) {
      widget.onSubmit(RidePref(
        departure: departure!,
        arrival: arrival!,
        departureDate: departureDate,
        requestedSeats: requestedSeats,
      ));
    }
  }

  // Switches departure and arrival locations when both already selected
  void _handleLocationSwitch() {
    if (departure != null && arrival != null) {
      setState(() {
        final temp = departure;
        departure = arrival;
        arrival = temp;
      });
    }
  }

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(BlaSpacings.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Departure location field with correct onTap
          _departureField(
            label: 'Leaving from',
            initialLocation: departure,
            onTap: _handleDepartureSelect, // Pass function reference
            icon: Icons.radio_button_checked_outlined,
          ),
          const BlaDivider(),

          // Arrival location field with correct onTap
          _departureField(
            label: 'Going to',
            initialLocation: arrival,
            onTap: _handleArrivalSelect, // Pass function reference
            icon: Icons.location_on_outlined,
          ),
          const BlaDivider(),

          // Date selection field
          _dateField(),
          const BlaDivider(),

          // Passenger count field
          _passengerField(requestedSeats),
          const SizedBox(height: BlaSpacings.xl),

          BlaButton(
            label: 'Search',
            onPressed: _isFormFieldValid ? _handleSubmit : () {},
          ),
        ],
      ),
    );
  }
  
  Route<Location> createBottomToTopRoute(LocationSearchScreen locationSearchScreen) {
    return PageRouteBuilder<Location>(
      pageBuilder: (context, animation, secondaryAnimation) => locationSearchScreen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}

class LocationSearchScreen extends StatelessWidget {
  const LocationSearchScreen();

  @override
  Widget build(BuildContext context) {
    // Your implementation for the Location Search Screen
    return Scaffold(
      appBar: AppBar(title: Text('Select Location')),
      body: Center(child: Text('Location Search UI here')),
    );
  }
}

// Implement a location selection field
Widget _departureField({
  required String label,
  required Location? initialLocation,
  required VoidCallback onTap,
  required IconData icon,
}) {
  return InkWell(
    onTap: onTap, // Call function when tap
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: BlaSpacings.s),
      child: Row(
        children: [
          Icon(icon, color: BlaColors.neutralLight, size: 24),
          const SizedBox(width: BlaSpacings.m),
          Text(
            initialLocation?.name ?? label,
            style: BlaTextStyles.body.copyWith(
              color: initialLocation != null ? BlaColors.textNormal : BlaColors.textLight,
            ),
          ),
        ],
      ),
    ),
  );
}

/// Implement the date selection field
Widget _dateField() {
  return InkWell(
    onTap: () {
      // TODO: Implement date selection
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: BlaSpacings.s),
      child: Row(
        children: [
          Icon(
            Icons.calendar_month_outlined,
            color: BlaColors.neutralLight,
            size: 24,
          ),
          const SizedBox(width: BlaSpacings.m),
          Text(
            'Today',
            style: BlaTextStyles.body.copyWith(
              color: BlaColors.textNormal,
            ),
          ),
        ],
      ),
    ),
  );
}

// Implement the passenger count selection field
Widget _passengerField(int requestedSeats) {
  return InkWell(
    onTap: () {
      // TODO: Implement passenger selection
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: BlaSpacings.s),
      child: Row(
        children: [
          Icon(
            Icons.person_outline,
            color: BlaColors.neutralLight,
            size: 24,
          ),
          const SizedBox(width: BlaSpacings.m),
          Text(
            '$requestedSeats',
            style: BlaTextStyles.body.copyWith(
              color: BlaColors.textNormal,
            ),
          ),
        ],
      ),
    ),
  );
}