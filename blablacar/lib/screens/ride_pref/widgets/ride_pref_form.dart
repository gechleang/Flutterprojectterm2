import 'package:flutter/material.dart';
import '../../../model/ride/ride.dart';

class RideTiles extends StatelessWidget {
  final Ride ride;
  final VoidCallback onPressed;

  const RideTiles({super.key, required this.ride, required this.onPressed});

  String get departure => "Departure: ${ride.departureLocation.name}";
  String get arrival => "Arrival: ${ride.arrivalLocation.name}";
  String get time => "Time: ${DateTimeUtils.formatDateTime(ride.departureDate)}";
  String get price => "Price: ${ride.pricePerSeat}";


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: Column(
          children: [
            Text(departure, style: BlaTextStyles.label.copyWith(color: BlaColors.textLight)),
            Text(arrival, style: BlaTextStyles.label.copyWith(color: BlaColors.textLight)),
            Text(time, style: BlaTextStyles.label.copyWith(color: BlaColors.textLight)),
            Text(price, style: BlaTextStyles.label.copyWith(color: BlaColors.textLight)),
          ],
        ),
      ),
    );
  }
}