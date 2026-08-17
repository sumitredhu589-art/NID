import 'package:flutter/material.dart';
import 'package:nid_mobile/core/widgets/nid_components.dart';
import 'package:nid_mobile/features/ai/presentation/ai_screen.dart';
import 'package:nid_mobile/features/camera/presentation/camera_screen.dart';
import 'package:nid_mobile/features/communication/presentation/communication_screen.dart';
import 'package:nid_mobile/features/conversations/presentation/conversations_screen.dart';
import 'package:nid_mobile/features/menu/presentation/app_menu_screen.dart';
import 'package:nid_mobile/features/notifications/presentation/notifications_screen.dart';
import 'package:nid_mobile/features/reels/presentation/reels_screen.dart';
import 'package:nid_mobile/features/search/presentation/search_maps_screen.dart';

class NIDHomeShell extends StatefulWidget {
  const NIDHomeShell({super.key});

  @override
  State<NIDHomeShell> createState() => _NIDHomeShellState();
}

class _NIDHomeShellState extends State<NIDHomeShell> {
  int index = 0;
  final pages = const [
    _HomeCanvas(),
    NotificationsScreen(),
    ConversationsScreen(),
    SearchMapsScreen(),
    CameraScreen(),
    ReelsScreen(),
    AiScreen(),
    CommunicationScreen(),
    AppMenuScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    if (index == 0) return _buildHome();
    return Scaffold(body: pages[index]);
  }

  Widget _buildHome() {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (d) {
          if ((d.primaryVelocity ?? 0) > 0) setState(() => index = 6);
          if ((d.primaryVelocity ?? 0) < 0) setState(() => index = 7);
        },
        onVerticalDragEnd: (d) {
          if ((d.primaryVelocity ?? 0) < 0) setState(() => index = 8);
        },
        child: NIDEarthBackground(
          child: SafeArea(
            child: Stack(
              children: [
                const Center(child: NIDAvatar(radius: 42)),
                Positioned(top: 12, left: 12, child: IconButton(onPressed: () => setState(() => index = 1), icon: const Icon(Icons.notifications_none))),
                Positioned(top: 12, right: 12, child: IconButton(onPressed: () => setState(() => index = 2), icon: const Icon(Icons.forum_outlined))),
                Positioned(bottom: 18, left: 16, child: IconButton(onPressed: () => setState(() => index = 3), icon: const Icon(Icons.search))),
                Positioned(bottom: 18, left: 0, right: 0, child: Center(child: IconButton(onPressed: () => setState(() => index = 4), icon: const Icon(Icons.camera_alt_outlined)))),
                Positioned(bottom: 18, right: 16, child: IconButton(onPressed: () => setState(() => index = 5), icon: const Icon(Icons.smart_display_outlined))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeCanvas extends StatelessWidget {
  const _HomeCanvas();
  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
