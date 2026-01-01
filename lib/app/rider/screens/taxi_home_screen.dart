import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/taxi_data.dart';
import '../../core/theme/taxi_theme.dart';
import '../../core/widgets/taxi_map.dart';
import '../../widgets/taxi_drawer.dart';
import 'package:latlong2/latlong.dart';
import 'ride_selection_screen.dart';

class TaxiHomeScreen extends StatefulWidget {
  const TaxiHomeScreen({super.key});

  @override
  State<TaxiHomeScreen> createState() => _TaxiHomeScreenState();
}

class _TaxiHomeScreenState extends State<TaxiHomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const TaxiDrawer(role: 'rider'),
      body: Stack(
        children: [
          // 1. Map Background
          TaxiMap(
            initialCenter: const LatLng(51.509364, -0.128928), // London
            pickupLocation: const LatLng(51.509364, -0.128928),
          ),

          // 2. Header (Menu & Notifications)
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
                _buildCircularButton(
                  icon: Icons.notifications_none,
                  onTap: () {},
                ),
              ],
            ),
          ),

          // 3. Bottom Sheet (Where to?)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 20,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Where are you going?", style: TaxiTheme.headingMedium),
                  const SizedBox(height: 16),

                  // Search Bar
                  GestureDetector(
                    onTap: () {
                      _showDestinationSearch(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.search,
                            size: 24,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "Search destination",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Recent Locations
                  ...TaxiData.recentLocations.map((loc) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          border: Border.all(color: Colors.grey[200]!),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          loc['icon'] as IconData,
                          color: Colors.grey[600],
                          size: 20,
                        ),
                      ),
                      title: Text(
                        loc['name'] as String,
                        style: TaxiTheme.bodyLarge.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        loc['address'] as String,
                        style: TaxiTheme.bodyMedium,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RideSelectionScreen(),
                          ),
                        );
                      },
                    );
                  }),
                ],
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

  void _showDestinationSearch(BuildContext context) {
    // For simplicity, just simulate picking a location and going to ride selection
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RideSelectionScreen()),
    );
  }
}
