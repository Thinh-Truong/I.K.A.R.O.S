import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:ikaros/data_model/chat_message.dart';
import 'package:ikaros/utils/ui_constants.dart';
import 'package:intl/intl.dart';

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
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        tween: Tween(begin: 12, end: 0),
        builder: (context, offset, child) => Opacity(
          opacity: (12 - offset) / 12,
          child: Transform.translate(offset: Offset(0, offset), child: child),
        ),
        child: Column(
          crossAxisAlignment: isUser
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            // Message bubble
            GestureDetector(
              onLongPress: () async {
                await Clipboard.setData(ClipboardData(text: message.text));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Copied to clipboard'),
                    duration: const Duration(seconds: 1),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: screenWidth * UIConstants.chatBubbleMaxWidth,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  gradient: isUser
                      ? LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            theme.colorScheme.primary,
                            theme.colorScheme.primary.withValues(alpha: 0.85),
                          ],
                        )
                      : LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            theme.colorScheme.surfaceContainerHighest,
                            theme.colorScheme.surface,
                          ],
                        ),
                  border: Border.all(
                    color: theme.colorScheme.outline.withValues(alpha: 0.12),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(
                      UIConstants.chatBubbleRadius,
                    ),
                    topRight: const Radius.circular(
                      UIConstants.chatBubbleRadius,
                    ),
                    bottomLeft: Radius.circular(
                      isUser ? UIConstants.chatBubbleRadius : 6,
                    ),
                    bottomRight: Radius.circular(
                      isUser ? 6 : UIConstants.chatBubbleRadius,
                    ),
                  ),
                ),
                child: MarkdownBody(
                  data: message.text,
                  selectable: true,
                  styleSheet: MarkdownStyleSheet.fromTheme(theme).copyWith(
                    a: TextStyle(
                      color: isUser
                          ? theme.colorScheme.onPrimary
                          : theme.colorScheme.onSurface,
                      decoration: TextDecoration.underline,
                    ),

                    blockquote: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      height: 1.4,
                    ),

                    blockquoteDecoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border(
                        left: BorderSide(
                          color: theme.colorScheme.outline.withValues(
                            alpha: 0.4,
                          ),
                          width: 3,
                        ),
                      ),
                    ),

                    codeblockDecoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                    ),

                    codeblockPadding: const EdgeInsets.all(12),

                    listBullet: theme.textTheme.bodyLarge?.copyWith(
                      color: isUser
                          ? theme.colorScheme.onPrimary
                          : theme.colorScheme.onSurface,
                    ),

                    p: theme.textTheme.bodyLarge?.copyWith(
                      color: isUser
                          ? theme.colorScheme.onPrimary
                          : theme.colorScheme.onSurface,
                      height: 1.4,
                    ),

                    strong: const TextStyle(fontWeight: FontWeight.bold),

                    h1: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isUser
                          ? theme.colorScheme.onPrimary
                          : theme.colorScheme.onSurface,
                    ),

                    h2: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),

                    code: theme.textTheme.bodyMedium?.copyWith(
                      fontFamily: 'monospace',
                      backgroundColor: theme.colorScheme.surface.withValues(
                        alpha: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Timestamp
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 12, right: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    DateFormat('HH:mm').format(message.timestamp),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant.withValues(
                        alpha: 0.7,
                      ),
                    ),
                  ),
                  if (isUser) ...[
                    const SizedBox(width: 6),
                    Icon(
                      Icons.check_rounded,
                      size: 14,
                      color: theme.colorScheme.primary,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
