import 'package:flutter/material.dart';

class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resources'),
        automaticallyImplyLeading: false,
      ),
      body: const Center(
        child: Text('Resources Screen - Coming Soon'),
      ),
    );
  }
}