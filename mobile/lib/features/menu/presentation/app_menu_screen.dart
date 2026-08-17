import 'package:flutter/material.dart';

class AppMenuScreen extends StatelessWidget {
  const AppMenuScreen({super.key});

  static const apps = [
    'Messages','Contacts','Calendar','Gallery','Camera','Music','Maps','Notes','Settings','Files','Calculator','Clock','Weather','Recorder','Mail','Play Store'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('App Menu')),
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.all(12), child: TextField(decoration: InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search apps'))),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              children: apps
                  .map(
                    (a) => Card(
                      child: InkWell(
                        onTap: () => _openApp(context, a),
                        child: Center(child: Text(a, textAlign: TextAlign.center)),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _openApp(BuildContext context, String appName) {
    if (appName == 'Gallery') {
      Navigator.pushNamed(context, '/gallery');
      return;
    }
    if (appName == 'Contacts') {
      Navigator.pushNamed(context, '/profile');
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$appName integration is pending connector setup.')),
    );
  }
}
