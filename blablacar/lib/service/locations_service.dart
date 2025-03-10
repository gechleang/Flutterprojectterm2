


import '../model/ride/locations.dart';
import '../repository/locations_repository.dart';

class LocationService {
  LocationsRepository _repository;

  // Private constructor
  LocationService._internal(this._repository);

  // Singleton instance
  static LocationService? _instance;

  // Factory constructor to create or return the singleton instance
  factory LocationService.initialize(LocationsRepository repository) {
    _instance = LocationService._internal(repository);
    return _instance!;
  }

  // Getter for the singleton instance
  static LocationService get instance {
    if (_instance == null) {
      throw StateError('LocationService must be initialized first');
    }
    return _instance!;
  }

  List<Location> getLocations() {
    return _repository.getLocations();
  }
}