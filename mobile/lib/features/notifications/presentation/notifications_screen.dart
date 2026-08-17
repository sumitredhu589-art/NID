import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notifications'),
          bottom: const TabBar(isScrollable: true, tabs: [
            Tab(text: 'All'), Tab(text: 'Important'), Tab(text: 'Personal'), Tab(text: 'Finance'), Tab(text: 'Social'), Tab(text: 'Other'), Tab(text: 'Unread')
          ]),
        ),
        body: const TabBarView(children: [
          _NotificationList(), _NotificationList(), _NotificationList(), _NotificationList(), _NotificationList(), _NotificationList(), _NotificationList()
        ]),
      ),
    );
  }
}

class _NotificationList extends StatelessWidget {
  const _NotificationList();
  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: 8,
        itemBuilder: (_, i) => ListTile(
          leading: Icon(i.isEven ? Icons.mark_email_unread : Icons.done),
          title: Text('Notification group ${i + 1}'),
          subtitle: const Text('Deep link • Mark as read • Reminder action'),
          trailing: TextButton(onPressed: () {}, child: const Text('Read')),
        ),
      );
}
