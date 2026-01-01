import 'dart:math';
import 'package:latlong2/latlong.dart';

class GeofencingUtils {
  static const double _earthRadiusKm = 6371.0;

  // Haversine formula
  static double calculateDistance(LatLng point1, LatLng point2) {
    var lat1 = _degreesToRadians(point1.latitude);
    var lon1 = _degreesToRadians(point1.longitude);
    var lat2 = _degreesToRadians(point2.latitude);
    var lon2 = _degreesToRadians(point2.longitude);

    var dLat = lat2 - lat1;
    var dLon = lon2 - lon1;

    var a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return _earthRadiusKm * c;
  }

  static bool isWithinRadius(LatLng center, LatLng target, double radiusKm) {
    return calculateDistance(center, target) <= radiusKm;
  }

  static double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }
}
