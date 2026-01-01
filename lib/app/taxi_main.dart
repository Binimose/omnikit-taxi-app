import 'package:flutter/material.dart';

import 'core/theme/taxi_theme.dart';
import 'core/screens/taxi_splash_screen.dart';
import 'core/screens/taxi_onboarding_screen.dart';
import 'core/screens/login_screen.dart';
import 'core/screens/verification_screen.dart';

import 'rider/screens/ride_selection_screen.dart';
import 'rider/screens/trip_in_progress_screen.dart';
import 'rider/screens/rate_driver_screen.dart';
import 'rider/screens/ride_history_screen.dart';
import 'rider/screens/wallet_screen.dart';
import 'driver/screens/earnings_screen.dart';
import 'rider/screens/promotions_screen.dart';
import 'rider/screens/rider_profile_screen.dart';
import 'rider/screens/support_screen.dart';
import 'driver/screens/driver_history_screen.dart';
import 'driver/screens/driver_reviews_screen.dart';
import 'driver/screens/driver_profile_screen.dart';
import 'core/screens/settings_screen.dart';
import 'taxi_gateway.dart';

class TaxiApp extends StatelessWidget {
  const TaxiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'City Taxi',
      theme: TaxiTheme.theme,
      home: const TaxiSplashScreen(),
      routes: {
        '/onboarding': (context) => const TaxiOnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/verify': (context) => const VerificationScreen(),
        '/home': (context) => const TaxiGateway(),
        '/ride-selection': (context) => const RideSelectionScreen(),
        '/trip': (context) => const TripInProgressScreen(),
        '/rate': (context) => const RateDriverScreen(),
        '/rider/history': (context) => const RideHistoryScreen(),
        '/rider/wallet': (context) => const WalletScreen(),
        '/rider/promotions': (context) => const PromotionsScreen(),
        '/rider/profile': (context) => const RiderProfileScreen(),
        '/rider/support': (context) => const SupportScreen(),
        '/driver/earnings': (context) => const EarningsScreen(),
        '/driver/history': (context) => const DriverHistoryScreen(),
        '/driver/reviews': (context) => const DriverReviewsScreen(),
        '/driver/profile': (context) => const DriverProfileScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
      // Handle any unnamed routes or deep links if necessary
      onGenerateRoute: (settings) {
        return null; // For now
      },
    );
  }
}
