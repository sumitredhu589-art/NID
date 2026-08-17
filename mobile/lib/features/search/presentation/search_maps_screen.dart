import 'package:flutter/material.dart';

class SearchMapsScreen extends StatelessWidget {
  const SearchMapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NID Search / Maps')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const TextField(decoration: InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'People, places, destinations, shops, services')),
          const SizedBox(height: 12),
          ...List.generate(
            8,
            (i) => Card(
              child: ListTile(
                title: Text('Place ${i + 1} • Open'),
                subtitle: const Text('Rating 4.5 • 1.2 km • Photos available'),
                trailing: Wrap(spacing: 8, children: const [Icon(Icons.call), Icon(Icons.directions), Icon(Icons.share), Icon(Icons.bookmark_border)]),
              ),
            ),
          ),
          const ListTile(title: Text('Route'), subtitle: Text('ETA 20 min • Distance 8.2 km • Start Navigation')),
        ],
      ),
    );
  }
}
