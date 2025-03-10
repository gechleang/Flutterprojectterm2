import 'package:blablacar/model/ride_pref/ride_pref.dart';
import 'package:blablacar/model/ride_filter/ride_filter.dart';

import '../model/ride/ride.dart';


abstract class RidesRepository {
  List<Ride> getRidesFor(RidePreference ridePreference, RideFilter? rideFilter);
}

class RideFilter {
}