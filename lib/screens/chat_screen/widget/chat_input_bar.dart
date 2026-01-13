import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/ui_constants.dart';
import 'chat_provider.dart';

/// Chat input bar with text field and action buttons
class ChatInputBar extends StatefulWidget {
  const ChatInputBar({super.key});

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _textController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = _textController.text.trim().isNotEmpty;
    if (hasText != _hasText) {
      setState(() => _hasText = hasText);
    }

    // Notify provider about typing state
    final chatProvider = context.read<ChatProvider>();
    chatProvider.setUserTyping(hasText);
  }

  Future<void> _sendMessage() async {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    _textController.clear();
    setState(() => _hasText = false);
    _focusNode.unfocus();

    await context.read<ChatProvider>().sendMessage(text);
  }

  void _showEmojiPicker() {
    // Placeholder for emoji/affection button
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('💕 Affection +1'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
      ),
    );
  }

  void _startVoiceMessage() {
    // Placeholder for voice button
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('🎤 Voice message coming soon!'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom:
            UIConstants.inputBarBottomPadding +
            MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // Voice button
            IconButton(
              onPressed: _startVoiceMessage,
              icon: const Icon(Icons.mic_rounded),
              color: theme.colorScheme.secondary,
              style: IconButton.styleFrom(
                backgroundColor: theme.colorScheme.secondaryContainer,
              ),
            ),
            const SizedBox(width: 8),

            // Text input field
            Expanded(
              child: TextField(
                controller: _textController,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant.withValues(
                      alpha: 0.6,
                    ),
                  ),
                  filled: true,
                  fillColor: theme.colorScheme.surfaceContainerHighest,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
                style: theme.textTheme.bodyLarge,
                maxLines: 4,
                minLines: 1,
                textCapitalization: TextCapitalization.sentences,
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
            const SizedBox(width: 8),

            // Affection/Emoji button or Send button
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _hasText
                  ? IconButton(
                      key: const ValueKey('send'),
                      onPressed: _sendMessage,
                      icon: const Icon(Icons.send_rounded),
                      color: theme.colorScheme.onPrimary,
                      style: IconButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                      ),
                    )
                  : IconButton(
                      key: const ValueKey('favorite'),
                      onPressed: _showEmojiPicker,
                      icon: const Icon(Icons.favorite_rounded),
                      color: theme.colorScheme.tertiary,
                      style: IconButton.styleFrom(
                        backgroundColor: theme.colorScheme.tertiaryContainer,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
