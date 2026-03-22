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
    if (isMobile) {
      final nodes = [
        _IntegrationNode(
          iconData: Icons.phone_android_rounded,
          iconColor: Colors.blue,
          category: "MOBILE",
          title: "Flutter Engine",
          delay: 500,
          isMobileLayout: isMobile,
        ),
        _IntegrationNode(
          iconData: Icons.auto_awesome_rounded,
          iconColor: AppColors.primaryOrange,
          category: "SOLUTION",
          title: "Custom AI",
          delay: 600,
          isMobileLayout: isMobile,
        ),
        _IntegrationNode(
          iconData: Icons.local_fire_department_rounded,
          iconColor: Colors.orangeAccent,
          category: "DATABASE",
          title: "Cloud Firestore",
          delay: 700,
          isMobileLayout: isMobile,
        ),
        _IntegrationNode(
          iconData: Icons.local_fire_department_rounded,
          iconColor: Colors.redAccent,
          category: "BACKEND",
          title: "Firebase",
          delay: 800,
          isMobileLayout: isMobile,
        ),
        _IntegrationNode(
          iconData: Icons.psychology_rounded,
          iconColor: Colors.tealAccent,
          category: "INTELLIGENCE",
          title: "Gemini AI",
          delay: 900,
          isMobileLayout: isMobile,
        ),
        _IntegrationNode(
          iconData: Icons.security_rounded,
          iconColor: Colors.blueAccent,
          category: "SECURITY",
          title: "Firebase Auth",
          delay: 1000,
          isMobileLayout: isMobile,
        ),
        _IntegrationNode(
          iconData: Icons.cloud_done_rounded,
          iconColor: Colors.greenAccent,
          category: "LOGIC",
          title: "Cloud Functions",
          delay: 1100,
          isMobileLayout: isMobile,
        ),
      ];
      return Column(
        children: [
          _buildCoreHub(),
          const SizedBox(height: 60),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: nodes,
          ),
        ],
      );
    }

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

    return SizedBox(
      width: double.infinity,
      height: 600.0,
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
                    isMobile: false,
                    sparkProgress: _sparkController.value,
                  ),
                );
              },
            ).animate().fadeIn(duration: const Duration(milliseconds: 1000)),
          ),

          // Central Hub
          Positioned(child: const IntegrationsSection()._buildCoreHub()),

          // Nodes
          Positioned(
            top: 50,
            left: widget.constraints.maxWidth * 0.15,
            child: nodes[0],
          ),
          Positioned(top: 0, child: nodes[1]),
          Positioned(
            top: 50,
            right: widget.constraints.maxWidth * 0.15,
            child: nodes[2],
          ),
          Positioned(left: 0, child: nodes[3]),
          Positioned(right: 0, child: nodes[4]),
          Positioned(
            bottom: 50,
            left: widget.constraints.maxWidth * 0.15,
            child: nodes[5],
          ),
          Positioned(
            bottom: 50,
            right: widget.constraints.maxWidth * 0.15,
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
  final bool isMobileLayout;

  const _IntegrationNode({
    required this.iconData,
    required this.iconColor,
    required this.category,
    required this.title,
    required this.delay,
    this.bobDelay = 0,
    this.isMobileLayout = false,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () =>
                controller.scrollToSection(controller.contactKey, "Contact Us"),
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: isMobileLayout ? double.infinity : 200,
              padding: EdgeInsets.all(isMobileLayout ? 8 : 12),
              decoration: BoxDecoration(
                color: const Color(0xFF111113).withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(16),
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
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: iconColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      iconData,
                      color: iconColor,
                      size: isMobileLayout ? 18 : 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          category,
                          style: GoogleFonts.inter(
                            color: const Color(0xFF888888),
                            fontSize: isMobileLayout ? 9 : 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                          ),
                        ),
                        Text(
                          title,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: isMobileLayout ? 12 : 14,
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

  _NetworkPainter({required this.isMobile, this.sparkProgress = 0});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final circlePaint = Paint()
      ..color = AppColors.primaryOrange.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawCircle(center, 150, circlePaint);
    canvas.drawCircle(center, 300, circlePaint);
    canvas.drawCircle(center, 450, circlePaint);

    final linePaint = Paint()
      ..color = AppColors.primaryOrange.withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final sparkPaint = Paint()
      ..color = AppColors.primaryOrange
      ..style = PaintingStyle.fill;

    if (!isMobile) {
      final List<Offset> targets = [
        Offset(size.width * 0.15 + 100, 50 + 30), // Top Left
        Offset(size.width / 2, 30), // Top Center
        Offset(size.width * 0.85 - 100, 50 + 30), // Top Right
        Offset(100, size.height / 2), // Middle Left
        Offset(size.width - 100, size.height / 2), // Middle Right
        Offset(size.width * 0.15 + 100, size.height - 50 - 30), // Bottom Left
        Offset(size.width * 0.85 - 100, size.height - 50 - 30), // Bottom Right
      ];

      for (var target in targets) {
        // Draw base line
        canvas.drawLine(center, target, linePaint);

        // Draw traveling spark
        final double progress =
            (sparkProgress + (targets.indexOf(target) / targets.length)) % 1.0;
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
  }

  @override
  bool shouldRepaint(covariant _NetworkPainter oldDelegate) =>
      oldDelegate.sparkProgress != sparkProgress;
}
