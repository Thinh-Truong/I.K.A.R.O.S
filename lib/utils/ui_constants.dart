/// UI Constants for the Virtual Girlfriend app
class UIConstants {
  // Avatar area height percentage
  static const double avatarAreaHeightRatio = 0.45;

  // Chat bubble styling
  static const double chatBubbleRadius = 20.0;
  static const double chatBubbleMaxWidth = 0.75;

  // Message spacing
  static const double messageSpacing = 12.0;
  static const double senderMessageMargin = 60.0;

  // Input bar
  static const double inputBarHeight = 60.0;
  static const double inputBarBottomPadding = 8.0;

  // Avatar animation durations
  static const Duration avatarTransitionDuration = Duration(milliseconds: 500);
  static const Duration typingIndicatorDuration = Duration(milliseconds: 800);

  // Auto-reply delays
  static const Duration thinkingDelay = Duration(seconds: 1);
  static const Duration replyDelay = Duration(milliseconds: 1500);

  // Inactivity timer
  static const Duration inactivityDuration = Duration(seconds: 10);
}
