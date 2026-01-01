import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../theme/taxi_theme.dart';

class TaxiMap extends StatefulWidget {
  final LatLng initialCenter;
  final List<LatLng>? routePolyline;
  final LatLng? driverLocation;
  final LatLng? pickupLocation;
  final LatLng? destinationLocation;

  const TaxiMap({
    super.key,
    required this.initialCenter,
    this.routePolyline,
    this.driverLocation,
    this.pickupLocation,
    this.destinationLocation,
  });

  @override
  State<TaxiMap> createState() => _TaxiMapState();
}

class _TaxiMapState extends State<TaxiMap> {
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: widget.initialCenter,
        initialZoom: 14.0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName:
              'com.omnikit.flutter.bundle', // Valid package name for OSM
        ),
        if (widget.routePolyline != null && widget.routePolyline!.isNotEmpty)
          PolylineLayer(
            polylines: [
              Polyline(
                points: widget.routePolyline!,
                color: TaxiTheme.primary,
                strokeWidth: 5.0,
              ),
            ],
          ),
        MarkerLayer(
          markers: [
            if (widget.driverLocation != null)
              Marker(
                point: widget.driverLocation!,
                width: 40,
                height: 40,
                child: Transform.rotate(
                  angle: 0, // In a real app, calculate bearing
                  child: const Icon(
                    Icons.local_taxi,
                    size: 24,
                    color: Colors.black,
                  ),
                ),
              ),
            if (widget.pickupLocation != null)
              Marker(
                point: widget.pickupLocation!,
                width: 40,
                height: 40,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.black,
                  size: 40,
                ),
              ),
            if (widget.destinationLocation != null)
              Marker(
                point: widget.destinationLocation!,
                width: 40,
                height: 40,
                child: const Icon(
                  Icons.location_on,
                  color: TaxiTheme.primary,
                  size: 40,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
