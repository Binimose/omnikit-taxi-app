import 'package:flutter/material.dart';
import 'core/models/user_model.dart';
import 'rider/screens/taxi_home_screen.dart';
import 'driver/screens/driver_home_screen.dart';

class TaxiGateway extends StatelessWidget {
  const TaxiGateway({super.key});

  @override
  Widget build(BuildContext context) {
    // In a real app, you would check `Provider.of<auth>(context).userRole`
    // Here we use a static param for demo switching
    final role = TaxiUserParams.currentRole;

    if (role == 'driver') {
      return const DriverHomeScreen();
    } else {
      return const TaxiHomeScreen();
    }
  }
}
