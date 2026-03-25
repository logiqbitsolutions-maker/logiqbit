import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../../../core/values/app_colors.dart';
import '../controllers/home_controller.dart';
import 'about_section.dart';

class IntegrationsSection extends StatelessWidget {
  const IntegrationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.backgroundBlack,
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.width > 700 ? 100 : 60,
        horizontal: 24,
      ),
      child: MaxWidthContainer(
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isMobile = constraints.maxWidth < 800;
            return Column(
              children: [
                _buildHeader(isMobile),
                const SizedBox(height: 80),
                _buildIntelligentCore(context, constraints, isMobile),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(bool isMobile) {
    return Column(
      children: [
        RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: GoogleFonts.inter(
                  fontSize: isMobile ? 36 : 56,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                  letterSpacing: -2,
                ),
                children: [
                  const TextSpan(
                    text: "Connected ",
                    style: TextStyle(color: Colors.white),
                  ),
                  const TextSpan(
                    text: "Intelligence",
                    style: TextStyle(color: AppColors.primaryOrange),
                  ),
                ],
              ),
            )
            .animate()
            .fadeIn(duration: const Duration(milliseconds: 800))
            .slideY(begin: 0.2, end: 0),
        const SizedBox(height: 24),
        SizedBox(
          width: 800,
          child: Text(
            "Our core hub orchestrates a unified digital ecosystem, seamlessly integrating AI, backend infrastructure, and specialized services into a single point of intelligence.",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFFF9F9F9).withValues(alpha: 0.6),
              fontSize: isMobile ? 14 : 16,
              height: 1.6,
            ),
          ),
        ).animate().fadeIn(
          duration: const Duration(milliseconds: 800),
          delay: const Duration(milliseconds: 200),
        ),
      ],
    );
  }

  Widget _buildIntelligentCore(
    BuildContext context,
    BoxConstraints constraints,
    bool isMobile,
  ) {
    return _IntelligentCoreSystem(constraints: constraints);
  }
}

class _IntelligentCoreSystem extends StatefulWidget {
  final BoxConstraints constraints;

  const _IntelligentCoreSystem({required this.constraints});

  @override
  State<_IntelligentCoreSystem> createState() => _IntelligentCoreSystemState();
}

class _IntelligentCoreSystemState extends State<_IntelligentCoreSystem>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = widget.constraints.maxWidth;
    final isMobile = width < 800;
    final isVerySmall = width < 500;

    final coreSize = isMobile ? 80.0 : 120.0;
    final containerHeight = isMobile ? (isVerySmall ? 500.0 : 600.0) : 700.0;

    final nodes = [
      _NodeData(
        Icons.phone_android_rounded,
        Colors.blue,
        "MOBILE",
        "Flutter",
        140.0,
      ),
      _NodeData(
        Icons.auto_awesome_rounded,
        AppColors.primaryOrange,
        "SOLUTION",
        "Custom AI",
        90.0,
      ),
      _NodeData(
        Icons.local_fire_department_rounded,
        Colors.redAccent,
        "BACKEND",
        "Firebase",
        40.0,
      ),
      _NodeData(
        Icons.psychology_rounded,
        Colors.tealAccent,
        "INTELLIGENCE",
        "Gemini AI",
        185.0,
      ),
      _NodeData(
        Icons.terminal_rounded,
        Colors.greenAccent,
        "DEVOPS",
        "CI / CD",
        0.0,
      ),
      _NodeData(
        Icons.payments_rounded,
        Colors.amberAccent,
        "PAYMENT",
        "Pay Gateway",
        230.0,
      ),
      _NodeData(
        Icons.support_agent_rounded,
        Colors.purpleAccent,
        "SUPPORT",
        "24/7 Support",
        315.0,
      ),
    ];

    return SizedBox(
      width: width,
      height: containerHeight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Atmospheric Elements
          _buildAtmosphere(width, containerHeight),

          // Connection Paths & Particles
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                return CustomPaint(
                  painter: _CoreLinkPainter(
                    pulseValue: _pulseController.value,
                    nodeAngles: nodes.map((n) => n.angle).toList(),
                    isMobile: isMobile,
                  ),
                );
              },
            ),
          ),

          // Central Hub
          _buildCentralHub(coreSize),

          // Peripheral Nodes
          ...nodes.asMap().entries.map((entry) {
            final node = entry.value;
            final idx = entry.key;
            return _buildNodePositioned(
              node,
              idx,
              width,
              containerHeight,
              isMobile,
              isVerySmall,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildAtmosphere(double width, double height) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 0.8,
          colors: [
            AppColors.primaryOrange.withValues(alpha: 0.05),
            Colors.transparent,
          ],
        ),
      ),
      child: Stack(
        children: List.generate(3, (i) {
          return Center(
            child:
                Container(
                      width: (i + 1) * (width * 0.3),
                      height: (i + 1) * (width * 0.3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.03),
                          width: 1,
                        ),
                      ),
                    )
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .scale(
                      begin: const Offset(1, 1),
                      end: Offset(1 + (i * 0.05), 1 + (i * 0.05)),
                      duration: Duration(milliseconds: 2000 + i * 1000),
                      curve: Curves.easeInOut,
                    ),
          );
        }),
      ),
    );
  }

  Widget _buildCentralHub(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.backgroundBlack,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryOrange.withValues(alpha: 0.2),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
        border: Border.all(
          color: AppColors.primaryOrange.withValues(alpha: 0.4),
          width: 2,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Inner Glow
          Container(
                width: size * 0.7,
                height: size * 0.7,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primaryOrange.withValues(alpha: 0.8),
                      AppColors.primaryOrange.withValues(alpha: 0.2),
                    ],
                  ),
                ),
              )
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scale(
                begin: const Offset(0.8, 0.8),
                end: const Offset(1, 1),
                duration: const Duration(seconds: 2),
              ),

          Text(
            "L",
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: size * 0.6,
              fontWeight: FontWeight.w900,
            ),
          ),

          // Outer Orbiting Ring
          Container(
                width: size * 1.1,
                height: size * 1.1,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primaryOrange.withValues(alpha: 0.2),
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                ),
              )
              .animate(onPlay: (c) => c.repeat())
              .rotate(duration: const Duration(seconds: 10)),
        ],
      ),
    );
  }

  Widget _buildNodePositioned(
    _NodeData node,
    int index,
    double width,
    double height,
    bool isMobile,
    bool isVerySmall,
  ) {
    final double radius = isMobile ? (width * 0.35) : (width * 0.28);
    final double rad = node.angle * math.pi / 180;

    final double dx = radius * math.cos(rad);
    final double dy = -radius * math.sin(rad);

    return Transform.translate(
      offset: Offset(dx, dy),
      child: _GlassyNode(data: node, isSmall: isVerySmall, delay: index * 150),
    );
  }
}

class _NodeData {
  final IconData icon;
  final Color color;
  final String category;
  final String title;
  final double angle;

  _NodeData(this.icon, this.color, this.category, this.title, this.angle);
}

class _GlassyNode extends StatelessWidget {
  final _NodeData data;
  final bool isSmall;
  final int delay;

  const _GlassyNode({
    required this.data,
    required this.isSmall,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final nodeSize = isSmall ? 100.0 : 160.0;
    return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () =>
                controller.scrollToSection(controller.contactKey, "Contact Us"),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: nodeSize,
              padding: EdgeInsets.all(isSmall ? 8 : 12),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1D).withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.08),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(isSmall ? 6 : 10),
                    decoration: BoxDecoration(
                      color: data.color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: data.color.withValues(alpha: 0.2),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      data.icon,
                      color: data.color,
                      size: isSmall ? 16 : 22,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          data.category,
                          style: GoogleFonts.inter(
                            color: const Color(0xFF888888),
                            fontSize: isSmall ? 7 : 9,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                        Text(
                          data.title,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: isSmall ? 10 : 13,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(
          duration: const Duration(milliseconds: 600),
          delay: Duration(milliseconds: delay),
        )
        .scale(begin: const Offset(0.8, 0.8))
        .moveY(begin: 20, end: 0)
        .then(delay: Duration(milliseconds: delay))
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .moveY(
          begin: -5,
          end: 5,
          duration: const Duration(seconds: 3),
          curve: Curves.easeInOut,
        );
  }
}

class _CoreLinkPainter extends CustomPainter {
  final double pulseValue;
  final List<double> nodeAngles;
  final bool isMobile;

  _CoreLinkPainter({
    required this.pulseValue,
    required this.nodeAngles,
    required this.isMobile,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final linkPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final radius = isMobile ? (size.width * 0.35) : (size.width * 0.28);

    for (var angle in nodeAngles) {
      final rad = angle * math.pi / 180;
      final target = Offset(
        center.dx + radius * math.cos(rad),
        center.dy - radius * math.sin(rad),
      );

      // Create a curved path
      final path = Path();
      path.moveTo(center.dx, center.dy);

      // Control point for curve
      final midAngle = (angle + 10) * math.pi / 180;
      final control = Offset(
        center.dx + (radius * 0.5) * math.cos(midAngle),
        center.dy - (radius * 0.5) * math.sin(midAngle),
      );

      path.quadraticBezierTo(control.dx, control.dy, target.dx, target.dy);

      // Draw Base Curve
      linkPaint.shader = LinearGradient(
        colors: [
          AppColors.primaryOrange.withValues(alpha: 0.3),
          AppColors.primaryOrange.withValues(alpha: 0.05),
        ],
      ).createShader(Rect.fromPoints(center, target));
      canvas.drawPath(path, linkPaint);

      // Draw Animated Particles
      final metrics = path.computeMetrics().toList();
      if (metrics.isNotEmpty) {
        final metric = metrics.first;
        final count = 2;
        for (int i = 0; i < count; i++) {
          final p = (pulseValue + (i / count)) % 1.0;
          final pos = metric.getTangentForOffset(metric.length * p)!.position;

          canvas.drawCircle(
            pos,
            3,
            Paint()
              ..color = AppColors.primaryOrange.withValues(alpha: 0.4)
              ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
          );
          canvas.drawCircle(
            pos,
            1.5,
            Paint()..color = Colors.white.withValues(alpha: 0.8),
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _CoreLinkPainter oldDelegate) => true;
}
