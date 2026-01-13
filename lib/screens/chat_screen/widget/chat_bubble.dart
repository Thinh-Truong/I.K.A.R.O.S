import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data_model/chat_message.dart';
import '../../../utils/ui_constants.dart';

/// Chat bubble widget displaying a single message
class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUser = message.isUser;
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(
        left: isUser ? UIConstants.senderMessageMargin : 16,
        right: isUser ? 16 : UIConstants.senderMessageMargin,
        bottom: UIConstants.messageSpacing,
      ),
      child: Column(
        crossAxisAlignment: isUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          // Message bubble
          Container(
            constraints: BoxConstraints(
              maxWidth: screenWidth * UIConstants.chatBubbleMaxWidth,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isUser
                  ? theme.colorScheme.primary
                  : theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(UIConstants.chatBubbleRadius),
                topRight: const Radius.circular(UIConstants.chatBubbleRadius),
                bottomLeft: Radius.circular(
                  isUser ? UIConstants.chatBubbleRadius : 4,
                ),
                bottomRight: Radius.circular(
                  isUser ? 4 : UIConstants.chatBubbleRadius,
                ),
              ),
            ),
            child: Text(
              message.text,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: isUser
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurface,
                height: 1.4,
              ),
            ),
          ),

          // Timestamp
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 12, right: 12),
            child: Text(
              DateFormat('HH:mm').format(message.timestamp),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant.withValues(
                  alpha: 0.6,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
