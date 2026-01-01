import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/taxi_theme.dart';
import '../../core/widgets/taxi_map.dart';
import 'package:latlong2/latlong.dart';
import 'earnings_screen.dart';
import 'ride_request_modal.dart';
import '../../widgets/taxi_drawer.dart';

import 'dart:async';
import '../../core/services/ride_service.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  bool _isOnline = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  StreamSubscription? _rideSubscription;

  @override
  void initState() {
    super.initState();
    _rideSubscription = RideService().rideRequestStream.listen((trip) {
      if (_isOnline && mounted) {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => RideRequestModal(trip: trip),
        );
      }
    });
  }

  @override
  void dispose() {
    _rideSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const TaxiDrawer(role: 'driver'),
      body: Stack(
        children: [
          // Map Background
          TaxiMap(
            initialCenter: const LatLng(51.509364, -0.128928), // London
            driverLocation: _isOnline
                ? const LatLng(51.509364, -0.128928)
                : null,
          ),

          // Header
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCircularButton(
                  icon: Icons.menu,
                  onTap: () => _scaffoldKey.currentState?.openDrawer(),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 10),
                    ],
                  ),
                  child: Row(
                    children: [
                      Text(
                        "\$142.50",
                        style: TaxiTheme.headingMedium.copyWith(fontSize: 16),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "TODAY",
                        style: TaxiTheme.bodyMedium.copyWith(fontSize: 10),
                      ),
                    ],
                  ),
                ),
                _buildCircularButton(
                  icon: Icons.notifications_none,
                  onTap: () {
                    // Simulate incoming request for demo
                    final mockTrip = {
                      'id': 'TEST_TRIP',
                      'pickup': const LatLng(51.5074, -0.1278),
                      'dropoff': const LatLng(51.5033, -0.1195),
                      'fare': 25.50,
                      'rideType': 'Comfort',
                      'rating': 4.9,
                      'riderName': 'Test User',
                    };

                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => RideRequestModal(trip: mockTrip),
                    );
                  },
                ),
              ],
            ),
          ),

          // Online/Offline Toggle
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  setState(() => _isOnline = !_isOnline);
                },
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: _isOnline ? TaxiTheme.primary : Colors.grey[800],
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: _isOnline
                            ? TaxiTheme.primary.withValues(alpha: 0.4)
                            : Colors.black26,
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                        spreadRadius: 5,
                      ),
                    ],
                    border: Border.all(color: Colors.white, width: 4),
                  ),
                  child: Icon(
                    Icons.power_settings_new,
                    color: _isOnline ? Colors.black : Colors.white,
                    size: 32,
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 130,
            left: 0,
            right: 0,
            child: Text(
              _isOnline ? "YOU ARE ONLINE" : "GO ONLINE",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: _isOnline ? TaxiTheme.primary : Colors.grey[800],
                shadows: [Shadow(color: Colors.white, blurRadius: 10)],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.black),
      ),
    );
  }
}
