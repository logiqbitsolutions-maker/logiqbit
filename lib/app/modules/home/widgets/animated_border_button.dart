import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/values/app_colors.dart';

class AnimatedBorderButton extends StatefulWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onPressed;
  final bool fillOnHover;
  final bool showMovingBorder;
  final Color? backgroundColor;
  final Color? textColor;

  const AnimatedBorderButton({
    super.key,
    required this.text,
    this.icon,
    required this.onPressed,
    this.fillOnHover = true,
    this.showMovingBorder = true,
    this.backgroundColor,
    this.textColor,
  });

  @override
  State<AnimatedBorderButton> createState() => _AnimatedBorderButtonState();
}

class _AnimatedBorderButtonState extends State<AnimatedBorderButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // --- NAVO BADLAV AHIYA CHE ---
    // Jyare hover thay tyare color white thavo joie, baki orange (widget.textColor)
    final Color currentContentColor = (_isHovered && widget.fillOnHover)
        ? Colors.white
        : (widget.textColor ?? AppColors.textWhite);

    Widget content = AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      decoration: BoxDecoration(
        color: _isHovered && widget.fillOnHover
            ? AppColors.primaryOrange
            : (widget.backgroundColor ??
                  AppColors.primaryOrange.withValues(alpha: 0.05)),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: AppColors.primaryOrange.withValues(
            alpha: _isHovered ? 0.6 : 0.3,
          ),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.text,
            style: GoogleFonts.inter(
              color: currentContentColor, // Color dynamic banavyo
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
          if (widget.icon != null) ...[
            const SizedBox(width: 8),
            Icon(
              widget.icon,
              color: currentContentColor, // Color dynamic banavyo
              size: 14,
            ),
          ],
        ],
      ),
    );

    if (widget.showMovingBorder) {
      content = CustomPaint(
        painter: MovingBorderPainter(
          animation: _controller,
          color: AppColors.primaryOrange,
          isHovered: _isHovered,
        ),
        child: content,
      );
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(onTap: widget.onPressed, child: content),
    );
  }
}

class MovingBorderPainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;
  final bool isHovered;

  MovingBorderPainter({
    required this.animation,
    required this.color,
    required this.isHovered,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(30));

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final path = Path()..addRRect(rrect);
    final metrics = path.computeMetrics().first;

    final segmentLength = metrics.length * 0.3;
    final start = metrics.length * animation.value;
    final end = start + segmentLength;

    if (end <= metrics.length) {
      canvas.drawPath(metrics.extractPath(start, end), paint);
    } else {
      canvas.drawPath(metrics.extractPath(start, metrics.length), paint);
      canvas.drawPath(metrics.extractPath(0, end - metrics.length), paint);
    }

    if (isHovered) {
      final glowPaint = Paint()
        ..color = color.withValues(alpha: 0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

      if (end <= metrics.length) {
        canvas.drawPath(metrics.extractPath(start, end), glowPaint);
      } else {
        canvas.drawPath(metrics.extractPath(start, metrics.length), glowPaint);
        canvas.drawPath(
          metrics.extractPath(0, end - metrics.length),
          glowPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant MovingBorderPainter oldDelegate) => true;
}
