import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../../../core/values/app_colors.dart';
import '../controllers/home_controller.dart';
import 'about_section.dart'; // For MaxWidthContainer
import 'hover_card.dart';
import 'execution_blueprint.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                _buildHeader(constraints),
                SizedBox(height: constraints.maxWidth > 700 ? 80 : 40),

                // 3x2 Grid of Services
                _buildServicesLayout(constraints, controller),
                SizedBox(height: constraints.maxWidth > 700 ? 80 : 40),

                // The Execution Blueprint
                _buildExecutionBlueprint(constraints),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BoxConstraints constraints) {
    bool isDesktop = constraints.maxWidth > 800;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: GoogleFonts.inter(
              fontSize: isDesktop ? 48 : 36,
              fontWeight: FontWeight.w800,
              height: 1.1,
              letterSpacing: -1.0,
            ),
            children: [
              const TextSpan(
                text: "Our ",
                style: TextStyle(color: AppColors.textWhite),
              ),
              const TextSpan(
                text: "Services",
                style: TextStyle(color: AppColors.primaryOrange),
              ),
            ],
          ),
        ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.05, end: 0),
        const SizedBox(height: 32),
        SizedBox(
          width: 600,
          child: Text(
            "We combine cutting-edge technology with strategic design to build digital products that dominate markets. Explore our suite of advanced technical capabilities.",
            style: GoogleFonts.inter(
              color: AppColors.textGrey,
              fontSize: isDesktop ? 16 : 14,
              height: 1.6,
            ),
          ),
        ).animate().fadeIn(duration: 800.ms, delay: 200.ms),
      ],
    );
  }

  Widget _buildServicesLayout(
    BoxConstraints constraints,
    HomeController controller,
  ) {
    final isMobile = constraints.maxWidth < 700;
    final isTablet = constraints.maxWidth >= 700 && constraints.maxWidth < 1000;

    double cardWidth = constraints.maxWidth;
    if (isTablet) cardWidth = (constraints.maxWidth - 32) / 2;
    if (!isMobile && !isTablet) cardWidth = (constraints.maxWidth - 64) / 3;

    final cardsData = [
      {
        "icon": Icons.smartphone_rounded,
        "title": "Mobile App Development",
        "description":
            "Expert engineering of high-performance native and cross-platform applications, delivering seamless experiences across all mobile devices.",
      },
      {
        "icon": Icons.sports_esports_rounded,
        "title": "Game Development",
        "description":
            "Designing immersive 2D and 3D gaming experiences with advanced mechanics and high-performance graphics for all major platforms.",
      },
      {
        "icon": Icons.language_rounded,
        "title": "Web Development",
        "description":
            "Building responsive, scalable web applications using modern frameworks, optimized for high performance and exceptional user engagement.",
      },
      {
        "icon": Icons.cloud_sync_rounded,
        "title": "CI/CD & DevOps",
        "description":
            "Optimizing software delivery with automated pipelines and cloud infrastructure, ensuring faster releases and superior system reliability.",
      },
      {
        "icon": Icons.design_services_rounded,
        "title": "UI/UX Design",
        "description":
            "Creating user-centric, visually stunning interfaces that prioritize usability and brand identity to deliver intuitive digital experiences.",
      },
      {
        "icon": Icons.fact_check_rounded,
        "title": "Testing & QA",
        "description":
            "Implementing rigorous quality assurance and automated testing strategies to ensure bug-free, highly reliable, and secure software products.",
      },
    ];

    return Wrap(
      spacing: 32,
      runSpacing: 32,
      alignment: WrapAlignment.start,
      children: cardsData.asMap().entries.map((entry) {
        final idx = entry.key;
        final data = entry.value;
        return _buildServiceCard(
          icon: data["icon"] as IconData,
          title: data["title"] as String,
          description: data["description"] as String,
          delay: idx * 100,
          width: cardWidth,
          controller: controller,
        );
      }).toList(),
    );
  }

  Widget _buildServiceCard({
    required IconData icon,
    required String title,
    required String description,
    required int delay,
    required double width,
    required HomeController controller,
  }) {
    return HoverCard(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => controller.scrollToSection(
                controller.contactKey,
                "Contact Us",
              ),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: width,
                constraints: const BoxConstraints(minHeight: 320),
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: AppColors.cardBlack.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.08),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primaryOrange.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        icon,
                        color: AppColors.primaryOrange,
                        size: 24,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        color: AppColors.textWhite,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      description,
                      style: GoogleFonts.inter(
                        color: const Color(0xFFF9F9F9).withValues(alpha: 0.6),
                        fontSize: 14,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 800.ms, delay: delay.ms)
        .slideY(begin: 0.1, end: 0);
  }

  Widget _buildExecutionBlueprint(BoxConstraints constraints) {
    bool isMobile = constraints.maxWidth < 700;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: GoogleFonts.inter(
              fontSize: isMobile ? 36 : 48,
              fontWeight: FontWeight.w800,
              letterSpacing: -1,
            ),
            children: [
              TextSpan(
                text: "The Execution ",
                style: TextStyle(color: AppColors.textWhite),
              ),
              const TextSpan(
                text: "Blueprint",
                style: TextStyle(color: AppColors.primaryOrange),
              ),
            ],
          ),
        ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.1, end: 0),
        const SizedBox(height: 16),
        SizedBox(
          width: 600,
          child: Text(
            "A rigorous, transparent, and results-oriented methodology designed for high-stakes digital products.",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: AppColors.textGrey,
              fontSize: isMobile ? 14 : 16,
              height: 1.6,
            ),
          ),
        ).animate().fadeIn(duration: 800.ms, delay: 100.ms),
        SizedBox(height: isMobile ? 40 : 80),

        const AdvancedExecutionBlueprint(),
      ],
    );
  }
}
