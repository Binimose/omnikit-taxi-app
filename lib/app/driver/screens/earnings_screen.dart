import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/theme/taxi_theme.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Earnings"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Total Balance Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: TaxiTheme.secondary,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  Text(
                    "Total Balance",
                    style: TaxiTheme.bodyMedium.copyWith(color: Colors.white70),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "\$1,240.50",
                    style: TaxiTheme.headingLarge.copyWith(
                      color: Colors.white,
                      fontSize: 36,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: TaxiTheme.primary,
                        foregroundColor: Colors.black,
                      ),
                      child: const Text("Withdraw"),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Weekly Chart Placeholder
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Weekly Activity", style: TaxiTheme.headingMedium),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                          if (value.toInt() < days.length) {
                            return Text(days[value.toInt()]);
                          }
                          return const Text('');
                        },
                      ),
                    ),
                  ),
                  barGroups: [
                    makeGroupData(0, 5),
                    makeGroupData(1, 6.5),
                    makeGroupData(2, 5),
                    makeGroupData(3, 7.5),
                    makeGroupData(4, 9),
                    makeGroupData(5, 11.5),
                    makeGroupData(6, 6.5),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Recent Transactions
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Recent Trips", style: TaxiTheme.headingMedium),
            ),
            const SizedBox(height: 16),
            ...List.generate(
              5,
              (index) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.local_taxi, color: Colors.black54),
                ),
                title: Text("Trip #384${5 - index}"),
                subtitle: Text("Today, 10:${30 + index} AM • 4.2 km"),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "+\$${(12 + index * 2).toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      "Cash",
                      style: TaxiTheme.bodyMedium.copyWith(fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Weekly Summary Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Trips", style: TaxiTheme.bodyMedium),
                      const Text(
                        "42",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Time Online", style: TaxiTheme.bodyMedium),
                      const Text(
                        "32h 15m",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: TaxiTheme.primary,
          width: 16,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}
