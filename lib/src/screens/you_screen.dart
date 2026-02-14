import 'package:flutter/material.dart';

class YouScreen extends StatelessWidget {
  const YouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('You')),
      body: ListView(
        children: const [
          ListTile(leading: Icon(Icons.favorite_outline), title: Text('Mood trends')), 
          ListTile(leading: Icon(Icons.schedule), title: Text('Reminders')), 
          ListTile(leading: Icon(Icons.lock_outline), title: Text('Privacy controls')), 
        ],
      ),
    );
  }
}
