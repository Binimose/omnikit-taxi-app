import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/services/routing_service.dart';
import '../../core/theme/taxi_theme.dart';
import '../../core/widgets/taxi_map.dart';
import 'package:latlong2/latlong.dart';
import 'rate_driver_screen.dart';

class TripInProgressScreen extends StatefulWidget {
  const TripInProgressScreen({super.key});

  @override
  State<TripInProgressScreen> createState() => _TripInProgressScreenState();
}

class _TripInProgressScreenState extends State<TripInProgressScreen> {
  // Simulate trip statuses
  int _statusIndex = 0;
  final List<String> _statuses = [
    "Your driver is arriving in 3 mins",
    "Driver has arrived",
    "Heading to destination",
    "Arriving at destination",
  ];

  List<LatLng> _route = [];
  final LatLng _pickup = const LatLng(51.5074, -0.1278); // Trafalgar Sq
  final LatLng _dropoff = const LatLng(51.5033, -0.1195); // London Eye
  final LatLng _driverStart = const LatLng(51.5100, -0.1300); // Nearby

  @override
  void initState() {
    super.initState();
    _fetchRoute();
    _simulateTripUpdates();
  }

  void _fetchRoute() async {
    final route = await RoutingService().getRoute(_pickup, _dropoff);
    if (mounted) setState(() => _route = route);
  }

  void _simulateTripUpdates() async {
    for (int i = 0; i < _statuses.length; i++) {
      if (!mounted) return;
      await Future.delayed(const Duration(seconds: 4));
      if (mounted) setState(() => _statusIndex = i);
    }
    // Finish trip
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const RateDriverScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map Background
          TaxiMap(
            initialCenter: _pickup,
            pickupLocation: _pickup,
            destinationLocation: _dropoff,
            driverLocation: _statusIndex < 2
                ? _driverStart
                : null, // Hide driver after pickup for simplicity
            routePolyline: _route,
          ),

          // Top Status Card
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              decoration: BoxDecoration(
                color: TaxiTheme.secondary,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                _statuses[_statusIndex],
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Bottom Driver Info Sheet
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 20,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Driver Profile
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey[300],

                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Michael D.", style: TaxiTheme.headingMedium),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16,
                              ),
                              Text(" 4.9", style: TaxiTheme.bodyMedium),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Toyota Camry",
                            style: TaxiTheme.bodyLarge.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              "HSW 8472",
                              style: TaxiTheme.bodyMedium.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.call, color: Colors.black),
                          label: const Text(
                            "Call Driver",
                            style: TextStyle(color: Colors.black),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: const BorderSide(color: Colors.grey),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.shield, color: Colors.black),
                          label: const Text("Safety"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: TaxiTheme.error.withValues(
                              alpha: 0.1,
                            ),
                            foregroundColor: TaxiTheme.error,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
