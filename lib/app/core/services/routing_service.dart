import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class RoutingService {
  // Using OSRM public demo server (Beware of usage limits/policies for production)
  static const String _baseUrl =
      'https://router.project-osrm.org/route/v1/driving';

  Future<List<LatLng>> getRoute(LatLng start, LatLng end) async {
    final url = Uri.parse(
      '$_baseUrl/${start.longitude},${start.latitude};${end.longitude},${end.latitude}?overview=full&geometries=geojson',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['routes'] != null && (data['routes'] as List).isNotEmpty) {
          final geometry = data['routes'][0]['geometry']['coordinates'] as List;
          return geometry
              .map(
                (coord) => LatLng(coord[1].toDouble(), coord[0].toDouble()),
              ) // GeoJSON is [lon, lat]
              .toList();
        }
      } else {
        log("OSRM Error: ${response.statusCode}");
      }
    } catch (e) {
      log("Routing Error: $e");
    }
    return [];
  }
}
