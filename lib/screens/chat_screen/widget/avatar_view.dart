import 'package:flutter/material.dart';
import '../../../data_model/avatar_state.dart';
import '../../../utils/ui_constants.dart';

/// Avatar view widget - displays the girlfriend's avatar with animated states
/// This is designed to be replaceable with Live2D/3D/WebView in the future
class AvatarView extends StatelessWidget {
  final AvatarState state;

  const AvatarView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final colors = state.gradientColors;
    final screenWidth = MediaQuery.of(context).size.width;

    return AnimatedContainer(
      duration: UIConstants.avatarTransitionDuration,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(colors[0]), Color(colors[1])],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Avatar emoji with scale animation
            AnimatedScale(
              scale: state == AvatarState.talking ? 1.1 : 1.0,
              duration: const Duration(milliseconds: 300),
              child: AnimatedRotation(
                turns: state == AvatarState.waiting ? -0.02 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: Text(
                  state.emoji,
                  style: TextStyle(fontSize: screenWidth * 0.35),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // State description
            AnimatedOpacity(
              opacity: 1.0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.surface.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  state.description,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            // Pulsing indicator for thinking state
            if (state == AvatarState.thinking) ...[
              const SizedBox(height: 16),
              _ThinkingIndicator(),
            ],
          ],
        ),
      ),
    );
  }
}

/// Pulsing dots indicator for thinking state
class _ThinkingIndicator extends StatefulWidget {
  @override
  State<_ThinkingIndicator> createState() => _ThinkingIndicatorState();
}

class _ThinkingIndicatorState extends State<_ThinkingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final delay = index * 0.2;
            final value = (_controller.value - delay) % 1.0;
            final scale = 0.5 + (0.5 * (1 - (value * 2 - 1).abs()));

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Transform.scale(
                scale: scale,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
