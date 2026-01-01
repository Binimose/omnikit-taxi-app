import 'package:flutter/material.dart';
import '../../core/theme/taxi_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Mock Data
  final TextEditingController _nameController = TextEditingController(
    text: "Alpaca User",
  );
  final TextEditingController _emailController = TextEditingController(
    text: "alpaca@example.com",
  );
  final TextEditingController _phoneController = TextEditingController(
    text: "+1 234 567 8900",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Profile Updated!")));
              Navigator.pop(context);
            },
            child: const Text(
              "Save",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Avatar
            Stack(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: TaxiTheme.secondary,
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: TaxiTheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Form Fields
            _buildTextField("Full Name", _nameController, Icons.person),
            const SizedBox(height: 16),
            _buildTextField("Email", _emailController, Icons.email),
            const SizedBox(height: 16),
            _buildTextField("Phone Number", _phoneController, Icons.phone),

            const SizedBox(height: 32),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text("Change Password"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    IconData icon,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TaxiTheme.bodyMedium.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.grey),
            hintText: "Enter $label",
            fillColor: Colors.grey[50],
          ),
        ),
      ],
    );
  }
}
