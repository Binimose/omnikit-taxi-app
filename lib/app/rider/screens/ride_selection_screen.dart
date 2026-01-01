import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/services/ride_service.dart';
import '../../core/taxi_data.dart';
import '../../core/theme/taxi_theme.dart';
import '../../core/widgets/taxi_map.dart';
import 'package:latlong2/latlong.dart';
import 'trip_in_progress_screen.dart';

class RideSelectionScreen extends StatefulWidget {
  const RideSelectionScreen({super.key});

  @override
  State<RideSelectionScreen> createState() => _RideSelectionScreenState();
}

class _RideSelectionScreenState extends State<RideSelectionScreen> {
  String _selectedRideId = 'econo';
  bool _isSearching = false; // Add loading state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Select Ride', style: TaxiTheme.headingMedium),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Simulated Map Background (Static for now)
          TaxiMap(
            initialCenter: const LatLng(51.5074, -0.1278),
            pickupLocation: const LatLng(51.5074, -0.1278), // Trafalgar Sq
            destinationLocation: const LatLng(51.5033, -0.1195), // London Eye
          ),

          // Bottom Sheet
          DraggableScrollableSheet(
            initialChildSize: 0.55,
            minChildSize: 0.55,
            maxChildSize: 0.8,
            builder: (context, scrollController) {
              return Container(
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
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(24),
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text("Suggested Rides", style: TaxiTheme.headingMedium),
                    const SizedBox(height: 16),
                    // Ride Options
                    ...TaxiData.rideTypes.map((ride) => _buildRideOption(ride)),

                    const SizedBox(height: 24),

                    // Payment Method Row
                    Row(
                      children: [
                        const Icon(Icons.credit_card, color: Colors.black54),
                        const SizedBox(width: 12),
                        Text("Visa **** 4242", style: TaxiTheme.bodyLarge),
                        const Spacer(),
                        const Icon(Icons.chevron_right, color: Colors.grey),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Book Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isSearching
                            ? null
                            : () {
                                // Trigger Loading and Request
                                setState(() => _isSearching = true);

                                final selectedRide = TaxiData.rideTypes
                                    .firstWhere(
                                      (r) => r['id'] == _selectedRideId,
                                    );

                                // Simulate request
                                RideService().requestRide(
                                  pickup: const LatLng(51.5074, -0.1278),
                                  dropoff: const LatLng(51.5033, -0.1195),
                                  fare: selectedRide['price_multiplier'] * 15.0,
                                  rideType: selectedRide['name'],
                                );

                                // Navigate after delay
                                Future.delayed(const Duration(seconds: 2), () {
                                  if (context.mounted) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            const TripInProgressScreen(),
                                      ),
                                    );
                                  }
                                });
                              },
                        child: _isSearching
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                  strokeWidth: 2,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Book ${_getRideName(_selectedRideId)}"),
                                  const SizedBox(width: 8),
                                  // Price
                                  Text(
                                    "\$${(15 * _getRideMultiplier(_selectedRideId)).toStringAsFixed(2)}",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  String _getRideName(String id) {
    return TaxiData.rideTypes.firstWhere((r) => r['id'] == id)['name'];
  }

  double _getRideMultiplier(String id) {
    return TaxiData.rideTypes.firstWhere(
      (r) => r['id'] == id,
    )['price_multiplier'];
  }

  Widget _buildRideOption(Map<String, dynamic> ride) {
    final isSelected = _selectedRideId == ride['id'];
    return GestureDetector(
      onTap: () => setState(() => _selectedRideId = ride['id']),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? TaxiTheme.primary.withValues(alpha: 0.1)
              : Colors.white,
          border: Border.all(
            color: isSelected ? TaxiTheme.primary : Colors.grey[200]!,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // Car Image
            Image.asset(
              ride['image'],
              width: 80,
              height: 50,
              fit: BoxFit.contain,
              errorBuilder: (ctx, err, stack) => Icon(
                Icons.directions_car,
                size: 40,
                color: isSelected ? TaxiTheme.primary : Colors.grey,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ride['name'],
                    style: TaxiTheme.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${ride['eta']} • ${ride['capacity']} seats",
                    style: TaxiTheme.bodyMedium.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "\$${(15 * ride['price_multiplier']).toStringAsFixed(2)}",
                  style: TaxiTheme.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (isSelected)
                  const Icon(
                    Icons.check_circle,
                    color: TaxiTheme.primary,
                    size: 16,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
