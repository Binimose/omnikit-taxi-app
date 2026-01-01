import 'dart:async';
import 'package:latlong2/latlong.dart';

enum TripStatus {
  requested,
  accepted,
  arrived,
  inProgress,
  completed,
  cancelled,
}

class RideService {
  // Singleton pattern
  static final RideService _instance = RideService._internal();
  factory RideService() => _instance;
  RideService._internal();

  // Stream controllers
  final _rideRequestController =
      StreamController<Map<String, dynamic>>.broadcast();
  final _tripStatusController = StreamController<TripStatus>.broadcast();

  // Streams
  Stream<Map<String, dynamic>> get rideRequestStream =>
      _rideRequestController.stream;
  Stream<TripStatus> get tripStatusStream => _tripStatusController.stream;

  // Current Trip State (Mock Database)
  Map<String, dynamic>? _currentTrip;

  void requestRide({
    required LatLng pickup,
    required LatLng dropoff,
    required double fare,
    required String rideType,
  }) {
    // Create a mock trip object
    _currentTrip = {
      'id': 'TRIP_${DateTime.now().millisecondsSinceEpoch}',
      'pickup': pickup,
      'dropoff': dropoff,
      'fare': fare,
      'rideType': rideType,
      'status': TripStatus.requested,
      'riderName': 'John Doe', // Mock rider
      'rating': 4.8,
    };

    // Broadcast valid request to drivers
    _rideRequestController.add(_currentTrip!);
    _tripStatusController.add(TripStatus.requested);
  }

  void acceptRide() {
    if (_currentTrip != null) {
      _currentTrip!['status'] = TripStatus.accepted;
      _tripStatusController.add(TripStatus.accepted);

      // Simulate driver arriving after 5 seconds
      Future.delayed(const Duration(seconds: 5), () {
        _currentTrip!['status'] = TripStatus.arrived;
        _tripStatusController.add(TripStatus.arrived);
      });

      // Simulate trip start after another 5 seconds
      Future.delayed(const Duration(seconds: 10), () {
        _currentTrip!['status'] = TripStatus.inProgress;
        _tripStatusController.add(TripStatus.inProgress);
      });
    }
  }

  void cancelRide() {
    _currentTrip = null;
    _tripStatusController.add(TripStatus.cancelled);
  }

  // For verifying simulation
  TripStatus get currentStatus =>
      _currentTrip?['status'] ?? TripStatus.cancelled;
}
