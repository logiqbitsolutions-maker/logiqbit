import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/values/app_colors.dart';

class AdvancedExecutionBlueprint extends StatefulWidget {
  const AdvancedExecutionBlueprint({super.key});

  @override
  State<AdvancedExecutionBlueprint> createState() =>
      _AdvancedExecutionBlueprintState();
}

class _AdvancedExecutionBlueprintState extends State<AdvancedExecutionBlueprint>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 16),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 900;
        if (isDesktop) {
          return _buildDesktopLayout(constraints);
        }
        return _buildMobileLayout(constraints);
      },
    );
  }

  Widget _buildDesktopLayout(BoxConstraints constraints) {
    final stepWidth = constraints.maxWidth / 4;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.topLeft,
          children: [
            // Static Base Line - Restored to Center (y=36)
            Positioned(
              top: 36,
              left: stepWidth / 2,
              right: stepWidth / 2,
              child: Container(
                height: 1,
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),

            // Step Boxes (Row)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(4, (index) {
                return Expanded(
                  child: _buildStep(
                    index,
                    _getStepTitle(index),
                    _getStepDescription(index),
                    false,
                    _getStepNumber(index),
                  ),
                );
              }),
            ),

            // Hybrid Traveling Spark (Box Perimeter + Line) - Restored to Center Path
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(
                  painter: HybridSparkPainter(
                    progress: _controller.value,
                    stepSize: stepWidth,
                    numSteps: 4,
                    isVertical: false,
                    boxSize: 72,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMobileLayout(BoxConstraints constraints) {
    const double stepSpacing = 180;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            // Static Vertical Connecting Line - Restored to Center
            Positioned(
              top: 36,
              bottom: 36,
              left: constraints.maxWidth / 2,
              child: Container(
                width: 1,
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),

            // Step Boxes
            Column(
              children: List.generate(4, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: _buildStep(
                    index,
                    _getStepTitle(index),
                    _getStepDescription(index),
                    true,
                    _getStepNumber(index),
                  ),
                );
              }),
            ),

            // Hybrid Traveling Spark (Vertical) - Restored to Center Entry/Exit
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(
                  painter: HybridSparkPainter(
                    progress: _controller.value,
                    stepSize: stepSpacing,
                    numSteps: 4,
                    isVertical: true,
                    boxSize: 56,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStep(
    int index,
    String title,
    String description,
    bool isMobile,
    String number,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: isMobile ? 56 : 72,
          height: isMobile ? 56 : 72,
          decoration: BoxDecoration(
            color: AppColors.cardBlack.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.08),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryOrange.withValues(alpha: 0.1),
                blurRadius: 15,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Center(
            child: Text(
              number,
              style: GoogleFonts.inter(
                color: AppColors.primaryOrange,
                fontSize: isMobile ? 16 : 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: AppColors.textWhite,
            fontSize: isMobile ? 18 : 20,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          description,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: const Color(0xFFF9F9F9).withValues(alpha: 0.6),
            fontSize: 14,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  String _getStepNumber(int index) => "0${index + 1}";
  String _getStepTitle(int index) {
    switch (index) {
      case 0:
        return "Audit & Plan";
      case 1:
        return "UX/UI Prototype";
      case 2:
        return "Agile Sprints";
      case 3:
        return "Scale & Ship";
      default:
        return "";
    }
  }

  String _getStepDescription(int index) {
    switch (index) {
      case 0:
        return "Deep dive into requirements, architecture planning, and strategic scoping.";
      case 1:
        return "Rapid high-fidelity prototyping and user validation before a single line of code.";
      case 2:
        return "High-velocity development cycles with continuous integration and testing.";
      case 3:
        return "Zero-downtime deployment with intensive monitoring and optimization.";
      default:
        return "";
    }
  }
}

class HybridSparkPainter extends CustomPainter {
  final double progress;
  final double stepSize;
  final int numSteps;
  final bool isVertical;
  final double boxSize;

  HybridSparkPainter({
    required this.progress,
    required this.stepSize,
    required this.numSteps,
    required this.isVertical,
    required this.boxSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Path fullPath = Path();
    final double radius = 20.0;

    if (isVertical) {
      final double centerX = size.width / 2;
      for (int i = 0; i < numSteps; i++) {
        final double centerY = 36 + (i * stepSize);
        final Rect boxRect = Rect.fromCenter(
          center: Offset(centerX, centerY),
          width: boxSize,
          height: boxSize,
        );

        if (i == 0) {
          fullPath.moveTo(centerX, centerY - boxSize / 2);
        } else {
          fullPath.lineTo(centerX, centerY - boxSize / 2);
        }

        _addRRectToPath(fullPath, boxRect, radius, isVertical: true);

        if (i < numSteps - 1) {
          fullPath.moveTo(centerX, centerY + boxSize / 2);
          fullPath.lineTo(centerX, centerY + stepSize - boxSize / 2);
        }
      }
    } else {
      // Desktop Path at Center Edge (y=36)
      final double centerY = 36.0;
      for (int i = 0; i < numSteps; i++) {
        final double centerX = (stepSize / 2) + (i * stepSize);
        final Rect boxRect = Rect.fromCenter(
          center: Offset(centerX, centerY),
          width: boxSize,
          height: boxSize,
        );

        if (i == 0) {
          fullPath.moveTo(centerX - boxSize / 2, centerY);
        } else {
          fullPath.lineTo(centerX - boxSize / 2, centerY);
        }

        _addRRectToPath(fullPath, boxRect, radius, isVertical: false);

        if (i < numSteps - 1) {
          fullPath.moveTo(centerX + boxSize / 2, centerY);
          fullPath.lineTo(centerX + stepSize - boxSize / 2, centerY);
        }
      }
    }

    final paint = Paint()
      ..color = AppColors.primaryOrange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final glowPaint = Paint()
      ..color = AppColors.primaryOrange.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    final List<PathMetric> metrics = fullPath.computeMetrics().toList();
    if (metrics.isEmpty) return;

    double totalLength = 0;
    for (var m in metrics) {
      totalLength += m.length;
    }

    final double currentPos = progress * totalLength;
    const double sparkLength = 100.0;

    double startOffset = currentPos - sparkLength;
    double endOffset = currentPos;

    _drawSpark(canvas, metrics, startOffset, endOffset, paint, glowPaint);
  }

  void _addRRectToPath(
    Path path,
    Rect rect,
    double radius, {
    required bool isVertical,
  }) {
    if (isVertical) {
      // Entry top center, exit bottom center
      path.lineTo(rect.left + radius, rect.top);
      path.arcToPoint(
        Offset(rect.right - radius, rect.top),
        radius: Radius.circular(radius),
        clockwise: true,
      );
      path.arcToPoint(
        Offset(rect.right, rect.top + radius),
        radius: Radius.circular(radius),
        clockwise: true,
      );
      path.lineTo(rect.right, rect.bottom - radius);
      path.arcToPoint(
        Offset(rect.right - radius, rect.bottom),
        radius: Radius.circular(radius),
        clockwise: true,
      );
      path.lineTo(rect.left + radius, rect.bottom);
      path.arcToPoint(
        Offset(rect.left, rect.bottom - radius),
        radius: Radius.circular(radius),
        clockwise: true,
      );
      path.lineTo(rect.left, rect.top + radius);
      path.arcToPoint(
        Offset(rect.left + radius, rect.top),
        radius: Radius.circular(radius),
        clockwise: true,
      );
      path.moveTo(rect.center.dx, rect.bottom);
    } else {
      // Entry left center (rect.left, centerY), back to right center
      path.lineTo(rect.left, rect.top + radius);
      path.arcToPoint(
        Offset(rect.left + radius, rect.top),
        radius: Radius.circular(radius),
        clockwise: true,
      );
      path.lineTo(rect.right - radius, rect.top);
      path.arcToPoint(
        Offset(rect.right, rect.top + radius),
        radius: Radius.circular(radius),
        clockwise: true,
      );
      path.lineTo(rect.right, rect.bottom - radius);
      path.arcToPoint(
        Offset(rect.right - radius, rect.bottom),
        radius: Radius.circular(radius),
        clockwise: true,
      );
      path.lineTo(rect.left + radius, rect.bottom);
      path.arcToPoint(
        Offset(rect.left, rect.bottom - radius),
        radius: Radius.circular(radius),
        clockwise: true,
      );
      path.lineTo(rect.left, rect.top + rect.height / 2);
      path.moveTo(rect.right, rect.top + rect.height / 2);
    }
  }

  void _drawSpark(
    Canvas canvas,
    List<PathMetric> metrics,
    double start,
    double end,
    Paint paint,
    Paint glow,
  ) {
    double accumulatedLength = 0;
    for (var metric in metrics) {
      final double metricStart = (start - accumulatedLength).clamp(
        0.0,
        metric.length,
      );
      final double metricEnd = (end - accumulatedLength).clamp(
        0.0,
        metric.length,
      );

      if (metricStart < metricEnd) {
        final Path extract = metric.extractPath(metricStart, metricEnd);
        canvas.drawPath(extract, glow);
        canvas.drawPath(extract, paint);
      }
      accumulatedLength += metric.length;
    }
  }

  @override
  bool shouldRepaint(HybridSparkPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
