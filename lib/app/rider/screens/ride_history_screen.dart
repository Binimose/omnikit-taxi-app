import 'package:flutter/material.dart';
import '../../core/theme/taxi_theme.dart';

class RideHistoryScreen extends StatelessWidget {
  const RideHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Your Trips"),
          bottom: const TabBar(
            labelColor: TaxiTheme.primary,
            unselectedLabelColor: Colors.grey,
            indicatorColor: TaxiTheme.primary,
            tabs: [
              Tab(text: "Completed"),
              Tab(text: "Cancelled"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildTripList(isCancelled: false),
            _buildTripList(isCancelled: true),
          ],
        ),
      ),
    );
  }

  Widget _buildTripList({required bool isCancelled}) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          color: Colors.grey.shade50,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Feb ${10 - index}, 2026 • 10:30 AM",
                      style: TaxiTheme.bodyMedium.copyWith(color: Colors.grey),
                    ),
                    Text(
                      isCancelled ? "\$0.00" : "\$24.50",
                      style: TaxiTheme.headingMedium.copyWith(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.circle, size: 12, color: Colors.green),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text("123 Piccadilly Circus, London"),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.circle, size: 12, color: Colors.red),
                    const SizedBox(width: 8),
                    const Expanded(child: Text("456 Oxford Street, London")),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: TaxiTheme.primary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.local_taxi,
                        size: 20,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isCancelled ? "Cancelled" : "Completed",
                      style: TextStyle(
                        color: isCancelled ? Colors.red : Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
