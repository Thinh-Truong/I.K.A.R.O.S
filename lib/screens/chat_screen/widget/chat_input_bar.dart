import 'package:flutter/material.dart';
import 'package:ikaros/screens/chat_screen/bloc/chat_provider.dart';
import 'package:ikaros/utils/ui_constants.dart';
import 'package:provider/provider.dart';

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

    context.read<ChatProvider>().setUserTyping(hasText);
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
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('💕 Affection +1'),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _startVoiceMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🎤 Voice message coming soon!'),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom:
            UIConstants.inputBarBottomPadding +
            MediaQuery.of(context).padding.bottom,
      ),
      child: TextField(
        controller: _textController,
        focusNode: _focusNode,
        maxLines: 4,
        minLines: 1,
        style: theme.textTheme.bodyLarge,
        onSubmitted: (_) => _sendMessage(),
        decoration: InputDecoration(
          hintText: 'Type a message...',
          filled: true,
          fillColor: theme.colorScheme.surfaceContainerHighest,

          // 🔵 Viền bo tròn
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide.none,
          ),

          // 🎤 Prefix icon (Mic)
          prefixIcon: IconButton(
            icon: const Icon(Icons.mic_rounded),
            onPressed: _startVoiceMessage,
            splashRadius: 20,
            color: theme.colorScheme.onSurfaceVariant,
          ),

          // ❤️ / 📤 Suffix icon (Favorite ↔ Send)
          suffixIcon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: _hasText
                ? IconButton(
                    key: const ValueKey('send'),
                    icon: const Icon(Icons.send_rounded),
                    onPressed: _sendMessage,
                    splashRadius: 20,
                    color: theme.colorScheme.primary,
                  )
                : IconButton(
                    key: const ValueKey('favorite'),
                    icon: const Icon(Icons.favorite_rounded),
                    onPressed: _showEmojiPicker,
                    splashRadius: 20,
                    color: theme.colorScheme.tertiary,
                  ),
          ),

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}
