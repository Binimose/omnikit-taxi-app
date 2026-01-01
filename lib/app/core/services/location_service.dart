import 'dart:async';
import 'package:latlong2/latlong.dart';

class LocationService {
  // Simulate stream of driver location updates
  Stream<LatLng> postDriverLocationUpdates() async* {
    LatLng currentLocation = const LatLng(51.5100, -0.1300);

    while (true) {
      await Future.delayed(const Duration(seconds: 2));

      // Simulate movement (random small changes)
      final newLat =
          currentLocation.latitude +
          (DateTime.now().millisecond % 10 - 5) * 0.0001;
      final newLng =
          currentLocation.longitude + (DateTime.now().second % 10 - 5) * 0.0001;

      currentLocation = LatLng(newLat, newLng);
      yield currentLocation;
    }
  }
}
