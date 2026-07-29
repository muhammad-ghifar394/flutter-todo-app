import 'package:flutter/material.dart';

class TodoDashboardCard extends StatelessWidget {
  final int total;
  final int active;
  final int completed;
  final double progress;

  const TodoDashboardCard({
    super.key,
    required this.total,
    required this.active,
    required this.completed,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 8,
                  ),
                  Text(
                    "${(progress * 100).round()}%",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 24),

            Expanded(
              child: Column(
                children: [
                  _buildRow("Total", total),
                  const SizedBox(height: 8),
                  _buildRow("Active", active),
                  const SizedBox(height: 8),
                  _buildRow("Completed", completed),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String title, int value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(
          value.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}