import 'package:flutter/material.dart';

class TodoStatsCard extends StatelessWidget {
  final int total;
  final int active;
  final int completed;

  const TodoStatsCard({
    super.key,
    required this.total,
    required this.active,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildRow(
              title: "Total",
              value: total,
            ),
            const SizedBox(height: 8),
            _buildRow(
              title: "Active",
              value: active,
            ),
            const SizedBox(height: 8),
            _buildRow(
              title: "Completed",
              value: completed,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow({
    required String title,
    required int value,
  }) {
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