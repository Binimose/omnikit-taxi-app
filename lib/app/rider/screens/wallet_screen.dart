import 'package:flutter/material.dart';
import '../../core/theme/taxi_theme.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Wallet"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Balance Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: TaxiTheme.secondary,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  Text(
                    "Current Balance",
                    style: TaxiTheme.bodyMedium.copyWith(color: Colors.white70),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "\$45.50",
                    style: TaxiTheme.headingLarge.copyWith(
                      color: Colors.white,
                      fontSize: 36,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Top-up functionality coming soon!"),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: TaxiTheme.primary,
                        foregroundColor: Colors.black,
                      ),
                      child: const Text("Add Money"),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Recent Transactions",
                style: TaxiTheme.headingMedium,
              ),
            ),
            const SizedBox(height: 16),

            // Transaction List
            ...List.generate(
              3,
              (index) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    index == 0 ? Icons.add : Icons.remove,
                    color: index == 0 ? Colors.green : Colors.red,
                  ),
                ),
                title: Text(index == 0 ? "Top Up" : "Ride Payment"),
                subtitle: Text("Yesterday, ${10 + index}:30 AM"),
                trailing: Text(
                  index == 0 ? "+\$50.00" : "-\$15.50",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: index == 0 ? Colors.green : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
