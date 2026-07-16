import 'package:flutter/material.dart';

class EmptyTodo extends StatelessWidget {
  const EmptyTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.inbox),
          SizedBox(height: 16),
          Text("Tidak ada todo"),
          Text("Buat to do pada tombol +"),
        ],
      ),
    );
  }
}