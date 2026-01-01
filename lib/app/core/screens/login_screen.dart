import 'package:flutter/material.dart';

import '../theme/taxi_theme.dart';
import '../models/user_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  String _selectedRole = "rider"; // Default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enter your mobile number', style: TaxiTheme.headingLarge),
            const SizedBox(height: 32),
            // Role Toggle (For Demo)
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text("Rider"),
                    value: "rider",
                    groupValue: _selectedRole,
                    contentPadding: EdgeInsets.zero,
                    activeColor: TaxiTheme.primary,
                    onChanged: (val) {
                      setState(() {
                        _selectedRole = val!;
                        TaxiUserParams.currentRole = val;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text("Driver"),
                    value: "driver",
                    groupValue: _selectedRole,
                    contentPadding: EdgeInsets.zero,
                    activeColor: TaxiTheme.primary,
                    onChanged: (val) {
                      setState(() {
                        _selectedRole = val!;
                        TaxiUserParams.currentRole = val;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/taxi/taxi-ride.jpg',
                        width: 24,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.flag, size: 24),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '+1',
                        style: TaxiTheme.bodyLarge.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    style: TaxiTheme.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Mobile Number',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/verify');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Continue'),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'By continuing, you agree to our Terms of Service\nand Privacy Policy.',
                textAlign: TextAlign.center,
                style: TaxiTheme.bodyMedium.copyWith(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
