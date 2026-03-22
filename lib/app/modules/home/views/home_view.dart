import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../../../core/values/app_colors.dart';
import '../widgets/navbar.dart';
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';
import '../widgets/services_section.dart';
import '../widgets/why_us_section.dart';
import '../widgets/portfolio_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/integrations_section.dart';
import '../widgets/footer.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBlack,
      body: Stack(
        children: [
          // Main Scroll Content
          NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollUpdateNotification) {
                controller.updateScrollOpacity(notification.metrics.pixels);
              }
              return true;
            },
            child: SingleChildScrollView(
              controller: controller.scrollController,
              child: Column(
                children: [
                  HeroSection(key: controller.heroKey),
                  AboutSection(key: controller.aboutKey),
                  ServicesSection(key: controller.servicesKey),
                  WhyUsSection(key: controller.whyUsKey),
                  IntegrationsSection(key: controller.integrationsKey),
                  PortfolioSection(key: controller.portfolioKey),
                  ContactSection(key: controller.contactKey),
                  const Footer(),
                ],
              ),
            ),
          ),

          // Fixed Navbar
          Obx(() {
            final isScrolled = controller.scrollOpacity.value > 0.1;
            return AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              top: isScrolled ? 0 : 30,
              left: 0,
              right: 0,
              child: const NavbarWidget(),
            );
          }),

          // Scroll to Top Button (Bottom Right)
          Positioned(
            right: 20,
            bottom: 40,
            child: Obx(() {
              return GestureDetector(
                onTap: () =>
                    controller.scrollToSection(controller.heroKey, "Home"),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 54,
                      height: 54,
                      child: CustomPaint(
                        painter: ProgressPainter(
                          controller.scrollProgress.value,
                        ),
                      ),
                    ),
                    Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: Color(0xFF1A1A1A),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.keyboard_arrow_up_rounded,
                        color: Colors.white70,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack);
            }),
          ),
        ],
      ),
    );
  }
}

class ProgressPainter extends CustomPainter {
  final double progress;
  ProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return; // Progress 0 hoy to kai draw na karo

    final paint = Paint()
      ..color = AppColors.primaryOrange
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = size.width / 2;

    // Background circle (Subtle border)
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.05)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.0,
    );

    double sweepAngle = 2 * 3.1415926535 * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -1.5708, // Starting from Top
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(ProgressPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
