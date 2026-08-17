import 'package:flutter/material.dart';

class ConversationsScreen extends StatelessWidget {
  const ConversationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('All Conversations'),
          bottom: const TabBar(isScrollable: true, tabs: [
            Tab(text: 'All'), Tab(text: 'Unread'), Tab(text: 'Personal'), Tab(text: 'Social'), Tab(text: 'Work'), Tab(text: 'Other')
          ]),
        ),
        body: ListView.builder(
          itemCount: 15,
          itemBuilder: (_, i) => ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text('Conversation ${i + 1}'),
            subtitle: const Text('Connector required for third-party APIs'),
            trailing: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text('${i + 1}m'), CircleAvatar(radius: 10, child: Text('${i % 5}'))]),
          ),
        ),
      ),
    );
  }
}
