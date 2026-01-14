import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ikaros/screens/text_to_speech.dart';

import '../screens/chat_screen/chat_screen.dart';

/// GoRouter configuration for app navigation
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.chat,
    routes: [
      GoRoute(
        path: AppRoutes.chat,
        name: 'chat',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: TextToSpeechPage()),
      ),
    ],
  );
}

/// Route path constants
class AppRoutes {
  static const String chat = '/';
}
