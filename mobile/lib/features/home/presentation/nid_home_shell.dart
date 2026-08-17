import 'package:flutter/material.dart';
import 'package:nid_mobile/core/widgets/nid_components.dart';
import 'package:nid_mobile/features/ai/presentation/ai_screen.dart';
import 'package:nid_mobile/features/camera/presentation/camera_screen.dart';
import 'package:nid_mobile/features/communication/presentation/communication_screen.dart';
import 'package:nid_mobile/features/conversations/presentation/conversations_screen.dart';
import 'package:nid_mobile/features/menu/presentation/app_menu_screen.dart';
import 'package:nid_mobile/features/notifications/presentation/notifications_screen.dart';
import 'package:nid_mobile/features/profile/presentation/profile_screen.dart';
import 'package:nid_mobile/features/reels/presentation/reels_screen.dart';
import 'package:nid_mobile/features/search/presentation/search_maps_screen.dart';
import 'package:nid_mobile/features/gallery/presentation/gallery_screen.dart';

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
    GalleryScreen(),
    ReelsScreen(),
    AiScreen(),
    CommunicationScreen(),
    AppMenuScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    if (index == 0) return _buildHome();
    return PopScope(
      canPop: false,
      onPopInvoked: (_) => setState(() => index = 0),
      child: Stack(
        children: [
          pages[index],
          Positioned(
            top: 48,
            left: 12,
            child: IconButton(
              onPressed: () => setState(() => index = 0),
              icon: const Icon(Icons.home_outlined),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHome() {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (d) {
          if ((d.primaryVelocity ?? 0) > 0) setState(() => index = 7);
          if ((d.primaryVelocity ?? 0) < 0) setState(() => index = 8);
        },
        onVerticalDragEnd: (d) {
          if ((d.primaryVelocity ?? 0) < 0) setState(() => index = 9);
          if ((d.primaryVelocity ?? 0) > 0) setState(() => index = 10);
        },
        onDoubleTap: () => setState(() => index = 5),
        child: NIDEarthBackground(
          child: SafeArea(
            child: Stack(
              children: [
                const Center(child: NIDAvatar(radius: 42)),
                Positioned(top: 12, left: 12, child: IconButton(onPressed: () => setState(() => index = 1), icon: const Icon(Icons.notifications_none))),
                Positioned(top: 12, right: 12, child: IconButton(onPressed: () => setState(() => index = 2), icon: const Icon(Icons.forum_outlined))),
                Positioned(bottom: 18, left: 16, child: IconButton(onPressed: () => setState(() => index = 3), icon: const Icon(Icons.search))),
                Positioned(bottom: 18, left: 0, right: 0, child: Center(child: IconButton(onPressed: () => setState(() => index = 4), icon: const Icon(Icons.camera_alt_outlined)))),
                Positioned(bottom: 18, right: 16, child: IconButton(onPressed: () => setState(() => index = 6), icon: const Icon(Icons.smart_display_outlined))),
                Positioned(top: 12, child: Center(child: SizedBox(width: MediaQuery.of(context).size.width, child: IconButton(onPressed: () => setState(() => index = 10), icon: const Icon(Icons.person_outline))))),
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
