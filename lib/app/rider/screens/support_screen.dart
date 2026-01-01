import 'package:flutter/material.dart';
import '../../core/theme/taxi_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Support"), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text("How can we help?", style: TaxiTheme.headingMedium),
          const SizedBox(height: 24),
          _buildSupportItem(
            Icons.chat_bubble_outline,
            "Live Chat",
            "Talk to our support team",
          ),
          _buildSupportItem(
            Icons.phone_outlined,
            "Call Us",
            "+1 (800) 123-4567",
          ),
          _buildSupportItem(
            Icons.email_outlined,
            "Email Us",
            "support@taxiapp.com",
          ),
          _buildSupportItem(
            Icons.question_answer_outlined,
            "FAQs",
            "Common questions answered",
          ),
        ],
      ),
    );
  }

  Widget _buildSupportItem(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: TaxiTheme.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: TaxiTheme.secondary),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[600]),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }
}
