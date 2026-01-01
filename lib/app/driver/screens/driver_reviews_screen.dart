import 'package:flutter/material.dart';
import '../../core/theme/taxi_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class DriverReviewsScreen extends StatelessWidget {
  const DriverReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Reviews"), centerTitle: true),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 4,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey[200],
                      child: Icon(Icons.person, color: Colors.grey[400]),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Passenger ${index + 1}",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        Row(
                          children: List.generate(
                            5,
                            (i) => Icon(
                              Icons.star,
                              size: 14,
                              color: i < 4 ? Colors.amber : Colors.grey[300],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      "2 days ago",
                      style: TaxiTheme.bodyMedium.copyWith(fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  "Great driver! Very polite and the car was clean. Would definitely ride again.",
                  style: TaxiTheme.bodyMedium,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
