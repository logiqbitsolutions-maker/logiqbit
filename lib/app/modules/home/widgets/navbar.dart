import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/values/app_colors.dart';
import '../controllers/home_controller.dart';
import 'animated_border_button.dart';

final RxDouble _logoScale = 1.0.obs;

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Obx(() {
      final scrollOpacity = controller.scrollOpacity.value;
      final isScrolled = scrollOpacity > 0.1;

      return LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = MediaQuery.of(context).size.width > 900;
          final navbarHorizontalPadding = 0.0;
          final navbarVerticalPadding = 0.0;

          return AnimatedPadding(
            duration: const Duration(milliseconds: 300),
            padding: EdgeInsets.symmetric(
              horizontal: navbarHorizontalPadding,
              vertical: navbarVerticalPadding,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: double.infinity),
                child: ClipRRect(
                  borderRadius: BorderRadius.zero,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: isScrolled ? 16 : 0,
                      sigmaY: isScrolled ? 16 : 0,
                    ),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: EdgeInsets.symmetric(
                        horizontal: isDesktop ? 60 : 24,
                        vertical: isScrolled ? 16 : 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundBlack.withValues(
                          alpha: isScrolled ? 0.65 : 0.0,
                        ),
                        borderRadius: BorderRadius.zero,
                        // border: removed as requested
                        boxShadow: [
                          if (isScrolled)
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.35),
                              blurRadius: 24,
                              offset: const Offset(0, 8),
                            ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Branding Logo
                          Obx(() {
                            return MouseRegion(
                              cursor: SystemMouseCursors.click,
                              onEnter: (_) =>
                                  _logoScale.value = 1.1, // Hover par 10% moto
                              onExit: (_) => _logoScale.value =
                                  1.0, // Hover nikalta normal
                              child: GestureDetector(
                                onTap: () => controller.scrollToSection(
                                  controller.heroKey,
                                  "Home",
                                ),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeInOut,
                                  transform: Matrix4.identity()
                                    ..scale(_logoScale.value),
                                  child: const LogoWidget(),
                                ),
                              ),
                            );
                          }),

                          if (isDesktop) ...[
                            // Navigation Links Pill (Desktop Only)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.02),
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  width: 1.2,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _buildNavLink("Home", controller.heroKey),
                                  _buildNavLink(
                                    "About Us",
                                    controller.aboutKey,
                                  ),
                                  _buildNavLink(
                                    "Services",
                                    controller.servicesKey,
                                  ),
                                  _buildNavLink(
                                    "Why Logiqbit",
                                    controller.whyUsKey,
                                  ),
                                  _buildNavLink(
                                    "Portfolio",
                                    controller.portfolioKey,
                                  ),
                                ],
                              ),
                            ),

                            AnimatedBorderButton(
                              text: "Contact Us",
                              icon: Icons.arrow_outward,
                              onPressed: () => controller.scrollToSection(
                                controller.contactKey,
                                "Contact Us",
                              ),
                              fillOnHover: false,
                              showMovingBorder: false,
                            ),
                          ] else ...[
                            // Mobile Hamburger Menu
                            IconButton(
                              icon: const Icon(
                                Icons.menu_rounded,
                                color: Colors.white,
                                size: 32,
                              ),
                              onPressed: () => _showMobileMenu(context),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }

  void _showMobileMenu(BuildContext context) {
    final controller = Get.find<HomeController>();
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Menu",
      barrierColor: AppColors.backgroundBlack.withValues(alpha: 0.95),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const LogoWidget(),
                      IconButton(
                        icon: const Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                          size: 32,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  Expanded(
                    child: ListView(
                      children: [
                        _buildMobileNavLink(
                          "Home",
                          controller.heroKey,
                          context,
                          isActive: true,
                        ),
                        _buildMobileNavLink(
                          "About Us",
                          controller.aboutKey,
                          context,
                        ),
                        _buildMobileNavLink(
                          "Services",
                          controller.servicesKey,
                          context,
                        ),
                        _buildMobileNavLink(
                          "Why Logiqbit",
                          controller.whyUsKey,
                          context,
                        ),
                        _buildMobileNavLink(
                          "Portfolio",
                          controller.portfolioKey,
                          context,
                        ),
                        const SizedBox(height: 40),
                        AnimatedBorderButton(
                          text: "Contact Us",
                          onPressed: () {
                            Navigator.of(context).pop();
                            controller.scrollToSection(
                              controller.contactKey,
                              "Contact Us",
                            );
                          },
                          fillOnHover: true,
                          showMovingBorder: true,
                          backgroundColor: Colors.transparent,
                          textColor: AppColors.textWhite,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavLink(String title, GlobalKey key) {
    final controller = Get.find<HomeController>();
    return Obx(() {
      final isActive = controller.activeSection.value == title;
      return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primaryOrange.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(40),
            onTap: () => controller.scrollToSection(key, title),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                title,
                style: GoogleFonts.inter(
                  color: isActive
                      ? AppColors.primaryOrange
                      : AppColors.textLightGrey,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildMobileNavLink(
    String title,
    GlobalKey key,
    BuildContext context, {
    bool isActive = false,
  }) {
    final controller = Get.find<HomeController>();
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          controller.scrollToSection(key, title);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            title,
            style: GoogleFonts.inter(
              color: isActive ? AppColors.primaryOrange : AppColors.textWhite,
              fontWeight: FontWeight.w600,
              fontSize: 32,
              letterSpacing: -1,
            ),
          ),
        ),
      ),
    );
  }
}

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/logiqbit_svg.svg',
      height: 48,
      fit: BoxFit.contain,
    );
  }
}
