import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/values/app_colors.dart';
import '../controllers/home_controller.dart';
import 'about_section.dart'; // For MaxWidthContainer
import 'animated_border_button.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 140, bottom: 80, left: 24, right: 24),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: RepaintBoundary(
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 1.5,
                    colors: [
                      AppColors.primaryOrange.withValues(alpha: 0.04),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 1.0],
                  ),
                ),
              ),
            ),
          ).animate().fadeIn(duration: 1500.ms, delay: 400.ms),

          Positioned(
            right: -350,
            top: -250,
            child: RepaintBoundary(
              child: Container(
                width: 1400, // સાઈઝ મોટી જેથી કટ ના થાય
                height: 1400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primaryOrange.withValues(alpha: 0.16),
                      AppColors.primaryOrange.withValues(alpha: 0.06),
                      Colors.transparent, // સ્મૂથ એન્ડ
                    ],
                    // ગ્રેડિયન્ટ વચ્ચે જ પૂરો થઇ જશે જેથી લાઈન ન દેખાય
                    stops: const [0.0, 0.4, 0.7],
                  ),
                ),
              ),
            ),
          ).animate().fadeIn(duration: 1200.ms, delay: 400.ms),

          MaxWidthContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // _buildTaglineCapsule(),
                const SizedBox(height: 48),
                _buildMassiveHeading(),
                const SizedBox(height: 40),
                _buildDescription(),
                const SizedBox(height: 60),
                _buildCtaAndStatsSection(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildTaglineCapsule() {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //     decoration: BoxDecoration(
  //       color: const Color(0xFF140F03),
  //       borderRadius: BorderRadius.circular(30),
  //       border: Border.all(
  //         color: AppColors.primaryOrange.withValues(alpha: 0.15),
  //       ),
  //     ),
  //     child: Row(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Container(
  //           width: 6,
  //           height: 6,
  //           decoration: const BoxDecoration(
  //             color: AppColors.primaryOrange,
  //             shape: BoxShape.circle,
  //           ),
  //         ),
  //         const SizedBox(width: 8),
  //         Text(
  //           "LEADING DIGITAL TRANSFORMATION AGENCY",
  //           style: GoogleFonts.inter(
  //             color: AppColors.primaryOrange,
  //             fontSize: 10,
  //             fontWeight: FontWeight.w700,
  //             letterSpacing: 1.5,
  //           ),
  //         ),
  //       ],
  //     ),
  //   ).animate().fadeIn().slideY(begin: 0.2, end: 0);
  // }

  Widget _buildMassiveHeading() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = MediaQuery.of(context).size.width;
        final isMobile = width < 800;
        final isVerySmall = width < 450;

        return RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: GoogleFonts.inter(
              color: AppColors.textWhite,
              fontSize: isVerySmall ? 42 : (isMobile ? 56 : 86),
              fontWeight: FontWeight.w900,
              height: 1.0,
              letterSpacing: isMobile ? -1.5 : -2.5,
            ),
            children: [
              const TextSpan(text: "Building "),
              TextSpan(
                text: isVerySmall ? "Innovative " : "Innovative\n",
                style: const TextStyle(color: AppColors.primaryOrange),
              ),
              const TextSpan(text: "Digital Solutions"),
            ],
          ),
        ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1, end: 0);
      },
    );
  }

  Widget _buildDescription() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = MediaQuery.of(context).size.width;
        final isMobile = width < 800;

        return ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: Text(
            isMobile
                ? "We specialize in building robust and scalable applications for your business, driving growth through cutting-edge technology and human-centric design."
                : "We specialize in building robust and scalable applications for your\nbusiness, driving growth through cutting-edge technology and human-\ncentric design.",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: AppColors.textLightGrey,
              fontSize: isMobile ? 15 : 18,
              height: 1.5,
              fontWeight: FontWeight.w400,
            ),
          ),
        ).animate().fadeIn(delay: 800.ms);
      },
    );
  }

  Widget _buildCtaAndStatsSection(BuildContext context) {
    final controller = Get.find<HomeController>();

    final isMobile = MediaQuery.of(context).size.width < 600;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // First Button: Book a Free Call
        Flexible(child: _buildGlowingCtaButton()),

        SizedBox(width: isMobile ? 8 : 12),

        // Vertical Divider Line
        Container(
          height: isMobile ? 20 : 30,
          width: 1,
          color: Colors.white.withValues(alpha: 0.15),
        ),

        SizedBox(width: isMobile ? 8 : 12),

        // Second Button: View Our Work (Orange Theme)
        Flexible(
          child: AnimatedBorderButton(
            showMovingBorder: false,
            text: "View Our Work",
            icon: Icons.grid_view_rounded,
            onPressed: () => controller.scrollToSection(
              controller.portfolioKey,
              "Portfolio",
            ),
            fillOnHover: true,
            backgroundColor: AppColors.primaryOrange.withValues(alpha: 0.1),
            textColor: AppColors.primaryOrange,
          ),
        ),
      ],
    ).animate().fadeIn(delay: 1000.ms).slideY(begin: 0.2, end: 0);
  }

  Widget _buildGlowingCtaButton() {
    final controller = Get.find<HomeController>();
    return AnimatedBorderButton(
      text: "Book a Free Call",

      icon: Icons.phone_in_talk_outlined,
      onPressed: () =>
          controller.scrollToSection(controller.contactKey, "Contact Us"),
      fillOnHover: false,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: GoogleFonts.inter(
            color: AppColors.textWhite,
            fontSize: 36,
            fontWeight: FontWeight.w900,
            letterSpacing: -1.0,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFFA3A3A3),
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 2.0,
          ),
        ),
      ],
    );
  }
}
