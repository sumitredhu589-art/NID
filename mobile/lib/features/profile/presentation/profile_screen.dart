import 'package:flutter/material.dart';
import 'package:nid_mobile/core/widgets/nid_components.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My NID Profile')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: const [
          Center(child: NIDAvatar(radius: 36)),
          SizedBox(height: 8),
          Center(child: Text('NID Demo')),
          Center(child: Text('demo.nid')),
          Center(child: Text('demo@email.nid')),
          ListTile(title: Text('NID Card'), subtitle: Text('Digital identity card issued by NID platform')),
          ListTile(title: Text('Edit Profile')),
          ListTile(title: Text('Privacy')),
          ListTile(title: Text('Security Center')),
          ListTile(title: Text('Connected Accounts')),
          ListTile(title: Text('Devices')),
        ],
      ),
    );
  }
}
