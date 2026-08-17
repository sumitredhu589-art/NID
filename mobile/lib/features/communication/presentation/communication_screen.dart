import 'package:flutter/material.dart';

class CommunicationScreen extends StatelessWidget {
  const CommunicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Communication'),
          bottom: const TabBar(isScrollable: true, tabs: [
            Tab(text: 'Calls'),
            Tab(text: 'Messages'),
            Tab(text: 'Favorites'),
            Tab(text: 'Recent'),
            Tab(text: 'Contacts'),
            Tab(text: 'Dial Pad'),
          ]),
        ),
        body: const TabBarView(
          children: [
            _SimpleList(title: 'Call history: incoming/outgoing/missed'),
            _SimpleList(title: 'SMS conversations'),
            _SimpleList(title: 'Favorite contacts'),
            _SimpleList(title: 'Recent activity'),
            _SimpleList(title: 'Contacts list'),
            _SimpleList(title: 'Dial pad with handoff to system dialer'),
          ],
        ),
      ),
    );
  }
}

class _SimpleList extends StatelessWidget {
  const _SimpleList({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) => ListView(children: [ListTile(title: Text(title))]);
}
