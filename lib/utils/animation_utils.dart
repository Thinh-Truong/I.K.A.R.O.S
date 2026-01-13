import 'package:flutter/material.dart';

/// Animation utilities for the Virtual Girlfriend app
class AnimationUtils {
  /// Creates a smooth fade transition for widgets
  static Widget fadeTransition({
    required Widget child,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return AnimatedSwitcher(
      duration: duration,
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: child,
    );
  }

  /// Creates a scale and fade transition
  static Widget scaleFadeTransition({
    required Widget child,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return AnimatedSwitcher(
      duration: duration,
      transitionBuilder: (child, animation) {
        return ScaleTransition(
          scale: animation,
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      child: child,
    );
  }

  /// Creates a slide transition from bottom
  static Widget slideFromBottom({
    required Widget child,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return AnimatedSwitcher(
      duration: duration,
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.3),
            end: Offset.zero,
          ).animate(animation),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      child: child,
    );
  }
}
