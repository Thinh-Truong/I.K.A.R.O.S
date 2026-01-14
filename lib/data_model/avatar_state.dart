/// Avatar state representing the current emotional/activity state of the girlfriend
enum AvatarState {
  /// Default resting state
  idle,

  /// Currently speaking/replying
  talking,

  /// Waiting for user response (sad/lonely)
  waiting,

  /// Thinking/processing
  thinking,
}

/// Extension to get display properties for each avatar state
extension AvatarStateExtension on AvatarState {
  /// Get the emoji representation of this state
  String get emoji {
    switch (this) {
      case AvatarState.idle:
        return '😊';
      case AvatarState.talking:
        return '🥰';
      case AvatarState.waiting:
        return '🥺';
      case AvatarState.thinking:
        return '🤔';
    }
  }

  /// Get the description text for this state
  String get description {
    switch (this) {
      case AvatarState.idle:
        return 'Đang hoạt động';
      case AvatarState.talking:
        return 'Đang nói';
      case AvatarState.waiting:
        return 'Đang chờ';
      case AvatarState.thinking:
        return 'Đang suy nghĩ';
    }
  }

  /// Get the background gradient colors for this state
  List<int> get gradientColors {
    switch (this) {
      case AvatarState.idle:
        return [0xFFFFE5EC, 0xFFFFF0F5];
      case AvatarState.talking:
        return [0xFFFFD4E5, 0xFFFFE5F0];
      case AvatarState.waiting:
        return [0xFFE8D5F0, 0xFFF0E5FF];
      case AvatarState.thinking:
        return [0xFFFFE8D5, 0xFFFFF0E5];
    }
  }
}
