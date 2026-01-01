import 'package:flutter/material.dart';
import '../../core/theme/taxi_theme.dart';

import '../../core/services/ride_service.dart';

class RideRequestModal extends StatelessWidget {
  final Map<String, dynamic> trip;

  const RideRequestModal({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    // Format fare
    final fare = "\$${(trip['fare'] as double).toStringAsFixed(2)}";
    final distance =
        "3.2 km"; // Mock distance for now (or calculate from coords)
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "New Ride Request",
            textAlign: TextAlign.center,
            style: TaxiTheme.headingMedium,
          ),
          const SizedBox(height: 24),

          // Earnings & Distance
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildInfoItem(fare, "Earnings"),
              _buildInfoItem(distance, "Distance"),
              _buildInfoItem(trip['rideType'], "Type"),
            ],
          ),
          const SizedBox(height: 24),

          const Divider(),
          const SizedBox(height: 16),

          // Locations
          Row(
            children: [
              const Icon(Icons.my_location, color: Colors.grey),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  "123 Market St, San Francisco",
                  style: TaxiTheme.bodyLarge,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.location_on, color: TaxiTheme.primary),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  "456 Mission St, San Francisco",
                  style: TaxiTheme.bodyLarge,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Actions
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: Colors.red),
                    foregroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Decline"),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    RideService().acceptRide();
                    Navigator.pop(context);
                    // Navigate to trip screen? Or just show status change on map
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TaxiTheme.accent, // Green for accept
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Accept Ride"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String value, String label) {
    return Column(
      children: [
        Text(value, style: TaxiTheme.headingMedium),
        Text(label, style: TaxiTheme.bodyMedium),
      ],
    );
  }
}
