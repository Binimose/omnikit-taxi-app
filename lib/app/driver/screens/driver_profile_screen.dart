import 'package:flutter/material.dart';
import '../../core/theme/taxi_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class DriverProfileScreen extends StatefulWidget {
  const DriverProfileScreen({super.key});

  @override
  State<DriverProfileScreen> createState() => _DriverProfileScreenState();
}

class _DriverProfileScreenState extends State<DriverProfileScreen> {
  bool _isEditing = false;

  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _vehicleController;
  late TextEditingController _licenseController;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(text: "+1 (555) 999-0000");
    _emailController = TextEditingController(text: "alex.driver@example.com");
    _vehicleController = TextEditingController(text: "Toyota Camry (White)");
    _licenseController = TextEditingController(text: "XYZ-1234");
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    _vehicleController.dispose();
    _licenseController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveProfile() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Driver Profile Updated!")));
    setState(() {
      _isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Driver Profile"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.check : Icons.edit),
            onPressed: () {
              if (_isEditing) {
                _saveProfile();
              } else {
                _toggleEdit();
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: TaxiTheme.secondary,
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: TaxiTheme.primary,
                      radius: 18,
                      child: const Icon(
                        Icons.camera_alt,
                        size: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text("Alex Driver", style: TaxiTheme.headingMedium),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 18),
                const SizedBox(width: 4),
                Text("4.9 (150+ Trips)", style: TaxiTheme.bodyMedium),
              ],
            ),
            const SizedBox(height: 32),

            _buildSectionHeader("Vehicle Information"),
            // Vehicle info is typically read-only or requires approval to change
            _buildProfileItem(
              "Vehicle",
              _vehicleController,
              Icons.directions_car,
              readOnly: !_isEditing,
            ),
            _buildProfileItem(
              "License Plate",
              _licenseController,
              Icons.confirmation_number,
              readOnly: true,
            ), // Kept strictly read-only for realism

            const SizedBox(height: 24),
            _buildSectionHeader("Personal Info"),
            _buildProfileItem(
              "Phone",
              _phoneController,
              Icons.phone,
              readOnly: !_isEditing,
            ),
            _buildProfileItem(
              "Email",
              _emailController,
              Icons.email,
              readOnly: !_isEditing,
            ),

            if (_isEditing)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TaxiTheme.primary,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text("Save Changes"),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
            letterSpacing: 1.0,
          ),
        ),
      ),
    );
  }

  Widget _buildProfileItem(
    String title,
    TextEditingController controller,
    IconData icon, {
    bool readOnly = false,
  }) {
    // If we are globally editing, but this specific field is readOnly (like license plate),
    // we show it as text but maybe simpler.
    // The logic here: if _isEditing is true, and readOnly is false, show TextField.
    // If _isEditing is true, and readOnly is true, show Text with a "Locked" hint maybe.

    bool canEdit = _isEditing && !readOnly;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: readOnly && _isEditing ? Colors.grey[100] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: TaxiTheme.secondary, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
                canEdit
                    ? TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 4),
                          border: InputBorder.none,
                        ),
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      )
                    : Text(
                        controller.text,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: readOnly && _isEditing
                              ? Colors.grey[600]
                              : Colors.black87,
                        ),
                      ),
              ],
            ),
          ),
          if (canEdit)
            const Icon(Icons.edit, size: 20, color: TaxiTheme.primary)
          else if (_isEditing && readOnly)
            const Icon(Icons.lock, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}
