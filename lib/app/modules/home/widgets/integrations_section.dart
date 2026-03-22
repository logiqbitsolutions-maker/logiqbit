import 'dart:math' as math;
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
        vertical: MediaQuery.of(context).size.width > 700 ? 80 : 40,
        horizontal: 24,
      ),
      child: MaxWidthContainer(
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isMobile = constraints.maxWidth < 800;
            return Column(
              children: [
                _buildHeader(isMobile),
                const SizedBox(height: 60),
                _buildMapArea(context, constraints, isMobile),
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
                  fontSize: isMobile ? 36 : 48,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                  letterSpacing: -1,
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
            .fadeIn(
              duration: const Duration(milliseconds: 800),
              delay: const Duration(milliseconds: 100),
            )
            .slideY(begin: 0.2, end: 0),
        const SizedBox(height: 24),
        SizedBox(
          width: 700,
          child: Text(
            "Logiqbit leverages Flutter, Firebase, and cutting-edge AI to build high-performance, scalable, and intelligent digital ecosystems for your business.",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: AppColors.textGrey,
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

  Widget _buildMapArea(
    BuildContext context,
    BoxConstraints constraints,
    bool isMobile,
  ) {
    return _AnimatedMapArea(constraints: constraints);
  }

  Widget _buildCoreHub() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.primaryOrange,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryOrange.withValues(alpha: 0.3),
                    blurRadius: 40,
                    spreadRadius: 10,
                  ),
                ],
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Center(
                child: Text(
                  "L",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            )
            .animate(onPlay: (controller) => controller.repeat(reverse: true))
            .scale(
              begin: const Offset(1, 1),
              end: const Offset(1.1, 1.1),
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOut,
            )
            .shimmer(
              duration: const Duration(seconds: 3),
              delay: const Duration(seconds: 1),
            ),
        const SizedBox(height: 16),
        Text(
          "CORE HUB",
          style: GoogleFonts.inter(
            color: AppColors.primaryOrange,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
          ),
        ),
      ],
    ).animate().scale(
      delay: const Duration(milliseconds: 400),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutBack,
    );
  }
}

class _AnimatedMapArea extends StatefulWidget {
  final BoxConstraints constraints;

  const _AnimatedMapArea({required this.constraints});

  @override
  State<_AnimatedMapArea> createState() => _AnimatedMapAreaState();
}

class _AnimatedMapAreaState extends State<_AnimatedMapArea>
    with SingleTickerProviderStateMixin {
  late AnimationController _sparkController;

  @override
  void initState() {
    super.initState();
    _sparkController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _sparkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nodes = [
      _IntegrationNode(
        iconData: Icons.phone_android_rounded,
        iconColor: Colors.blue,
        category: "MOBILE",
        title: "Flutter Engine",
        delay: 500,
        bobDelay: 0,
      ),
      _IntegrationNode(
        iconData: Icons.auto_awesome_rounded,
        iconColor: AppColors.primaryOrange,
        category: "SOLUTION",
        title: "Custom AI",
        delay: 600,
        bobDelay: 400,
      ),
      _IntegrationNode(
        iconData: Icons.local_fire_department_rounded,
        iconColor: Colors.orangeAccent,
        category: "DATABASE",
        title: "Cloud Firestore",
        delay: 700,
        bobDelay: 800,
      ),
      _IntegrationNode(
        iconData: Icons.local_fire_department_rounded,
        iconColor: Colors.redAccent,
        category: "BACKEND",
        title: "Firebase",
        delay: 800,
        bobDelay: 200,
      ),
      _IntegrationNode(
        iconData: Icons.psychology_rounded,
        iconColor: Colors.tealAccent,
        category: "INTELLIGENCE",
        title: "Gemini AI",
        delay: 900,
        bobDelay: 600,
      ),
      _IntegrationNode(
        iconData: Icons.security_rounded,
        iconColor: Colors.blueAccent,
        category: "SECURITY",
        title: "Firebase Auth",
        delay: 1000,
        bobDelay: 100,
      ),
      _IntegrationNode(
        iconData: Icons.cloud_done_rounded,
        iconColor: Colors.greenAccent,
        category: "LOGIC",
        title: "Cloud Functions",
        delay: 1100,
        bobDelay: 500,
      ),
    ];

    // Define shared positioning logic (Truly radial/circular)
    List<Offset> getNodeCenters(Size size) {
      final center = Offset(size.width / 2, size.height / 2);
      
      // Calculate radius based on available width and nodes size
      final isVerySmall = size.width < 450;
      final isSmall = size.width < 800;
      final nodeW = isVerySmall ? 110.0 : (isSmall ? 140.0 : 200.0);
      
      // Radius should ensure nodes stay within bounds
      // (size.width - nodeW) / 2 is the maximum radius we can have
      final double radius = math.min(
        (size.width - nodeW) * 0.48, // slightly inside
        (size.height - 120) * 0.48 // Leave some vertical margin
      );

      // Define angles in degrees (0 = Right, 90 = Top, etc.)
      // Matching the visual feel of the web view
      const angles = [
        140.0, // Node 0: Top Left
        90.0,  // Node 1: Top Center
        40.0,  // Node 2: Top Right
        180.0, // Node 3: Mid Left
        0.0,   // Node 4: Mid Right
        220.0, // Node 5: Bottom Left
        320.0, // Node 6: Bottom Right
      ];

      return angles.map((angle) {
        final rad = angle * math.pi / 180;
        return Offset(
          center.dx + radius * math.cos(rad),
          center.dy - radius * math.sin(rad),
        );
      }).toList();
    }

    final size = Size(widget.constraints.maxWidth, widget.constraints.maxWidth < 600 ? 500.0 : 600.0);
    final isSmall = size.width < 800;
    final centers = getNodeCenters(size);
    final isVerySmall = size.width < 450;
    final nodeW = isVerySmall ? 110.0 : (isSmall ? 140.0 : 200.0);
    final nodeH = isSmall ? 56.0 : 80.0;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background lines and animated sparks
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _sparkController,
              builder: (context, child) {
                return CustomPaint(
                  painter: _NetworkPainter(
                    isMobile: isSmall,
                    sparkProgress: _sparkController.value,
                    nodeCenters: centers,
                  ),
                );
              },
            ).animate().fadeIn(duration: const Duration(milliseconds: 1000)),
          ),

          // Central Hub
          Positioned(child: const IntegrationsSection()._buildCoreHub()),

          // Nodes
          // Node 0
          Positioned(
            left: centers[0].dx - nodeW/2,
            top: centers[0].dy - nodeH/2,
            child: nodes[0],
          ),
          // Node 1
          Positioned(
            left: centers[1].dx - nodeW/2,
            top: centers[1].dy - nodeH/2,
            child: nodes[1],
          ),
          // Node 2
          Positioned(
            left: centers[2].dx - nodeW/2,
            top: centers[2].dy - nodeH/2,
            child: nodes[2],
          ),
          // Node 3
          Positioned(
            left: centers[3].dx - nodeW/2,
            top: centers[3].dy - nodeH/2,
            child: nodes[3],
          ),
          // Node 4
          Positioned(
            left: centers[4].dx - nodeW/2,
            top: centers[4].dy - nodeH/2,
            child: nodes[4],
          ),
          // Node 5
          Positioned(
            left: centers[5].dx - nodeW/2,
            top: centers[5].dy - nodeH/2,
            child: nodes[5],
          ),
          // Node 6
          Positioned(
            left: centers[6].dx - nodeW/2,
            top: centers[6].dy - nodeH/2,
            child: nodes[6],
          ),
        ],
      ),
    );
  }
}

class _IntegrationNode extends StatelessWidget {
  final IconData iconData;
  final Color iconColor;
  final String category;
  final String title;
  final int delay;
  final int bobDelay;

  const _IntegrationNode({
    required this.iconData,
    required this.iconColor,
    required this.category,
    required this.title,
    required this.delay,
    this.bobDelay = 0,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final width = MediaQuery.of(context).size.width;
    final isVerySmall = width < 450;
    final isSmall = width < 800;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () =>
            controller.scrollToSection(controller.contactKey, "Contact Us"),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: isVerySmall ? 110 : (isSmall ? 140 : 200),
          padding: EdgeInsets.all(isVerySmall ? 6 : (isSmall ? 8 : 12)),
          decoration: BoxDecoration(
            color: const Color(0xFF111113).withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(isVerySmall ? 8 : 16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(isVerySmall ? 4 : (isSmall ? 6 : 10)),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(isVerySmall ? 6 : 10),
                ),
                child: Icon(
                  iconData,
                  color: iconColor,
                  size: isVerySmall ? 14 : (isSmall ? 18 : 24),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      category,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF888888),
                        fontSize: isVerySmall ? 6 : (isSmall ? 8 : 10),
                        fontWeight: FontWeight.w700,
                        letterSpacing: isVerySmall ? 0.5 : 1,
                      ),
                    ),
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: isVerySmall ? 9 : (isSmall ? 11 : 14),
                        fontWeight: FontWeight.w700,
                      ),
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
    .scale(begin: const Offset(0.9, 0.9))
    .then()
    .animate(onPlay: (controller) => controller.repeat(reverse: true))
    .moveY(
      begin: -5,
      end: 5,
      duration: const Duration(seconds: 3),
      delay: Duration(milliseconds: bobDelay),
      curve: Curves.easeInOut,
    );
  }
}

class _NetworkPainter extends CustomPainter {
  final bool isMobile;
  final double sparkProgress;
  final List<Offset> nodeCenters;

  _NetworkPainter({
    required this.isMobile,
    this.sparkProgress = 0,
    required this.nodeCenters,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final circlePaint = Paint()
      ..color = AppColors.primaryOrange.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final linePaint = Paint()
      ..color = AppColors.primaryOrange.withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final sparkPaint = Paint()
      ..color = AppColors.primaryOrange
      ..style = PaintingStyle.fill;

    final double radius1 = isMobile ? 100 : 150;
    final double radius2 = isMobile ? 200 : 300;
    final double radius3 = isMobile ? 300 : 450;

    canvas.drawCircle(center, radius1, circlePaint);
    canvas.drawCircle(center, radius2, circlePaint);
    canvas.drawCircle(center, radius3, circlePaint);

    for (var target in nodeCenters) {
      // Draw base line
      canvas.drawLine(center, target, linePaint);

      // Draw traveling spark
      final int index = nodeCenters.indexOf(target);
      final double progress =
          (sparkProgress + (index / nodeCenters.length)) % 1.0;
      final Offset sparkPos = Offset.lerp(center, target, progress)!;

      // Glow effect for spark
      canvas.drawCircle(
        sparkPos,
        4,
        Paint()
          ..color = AppColors.primaryOrange.withValues(alpha: 0.3)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
      );
      canvas.drawCircle(sparkPos, 2, sparkPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _NetworkPainter oldDelegate) =>
      oldDelegate.sparkProgress != sparkProgress ||
      oldDelegate.nodeCenters != nodeCenters;
}
