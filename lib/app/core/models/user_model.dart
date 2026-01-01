// Shared User Model
class User {
  final String uid;
  final String role; // 'rider' or 'driver'
  final String name;
  final String phone;

  User({
    required this.uid,
    required this.role,
    required this.name,
    required this.phone,
  });
}

// Global scope for demo purposes (In real app, use Provider/Bloc)
class TaxiUserParams {
  static String currentRole = 'rider'; // Default to rider for now
}
