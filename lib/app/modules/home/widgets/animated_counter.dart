import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AnimatedCounter extends StatefulWidget {
  final num targetValue;
  final String suffix;
  final String prefix;
  final Duration duration;
  final TextStyle style;
  final Curve curve;

  const AnimatedCounter({
    super.key,
    required this.targetValue,
    this.suffix = "",
    this.prefix = "",
    this.duration = const Duration(milliseconds: 1500),
    required this.style,
    this.curve = Curves.easeOutQuart,
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isVisible = false;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(begin: 0, end: widget.targetValue.toDouble())
        .animate(CurvedAnimation(parent: _controller, curve: widget.curve));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    if (!_hasAnimated) {
      _controller.forward();
      _hasAnimated = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('animated_counter_${widget.targetValue}_${widget.prefix}${widget.suffix}'), 
      onVisibilityChanged: (info) {
        if (!mounted) return;
        if (info.visibleFraction > 0.1 && !_hasAnimated) {
          _startAnimation();
        }
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          String displayValue;
          if (widget.targetValue is int) {
            displayValue = _animation.value.toInt().toString();
          } else {
            displayValue = _animation.value.toStringAsFixed(1);
          }

          return Text(
            "${widget.prefix}$displayValue${widget.suffix}",
            style: widget.style,
          );
        },
      ),
    );
  }
}
