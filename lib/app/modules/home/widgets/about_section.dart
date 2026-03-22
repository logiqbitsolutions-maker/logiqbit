import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../../core/values/app_colors.dart';
import 'hover_card.dart';
import 'animated_counter.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> with TickerProviderStateMixin {
  late final AnimationController _leftController;
  late final AnimationController _rightController;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _leftController = AnimationController(vsync: this);
    _rightController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _leftController.dispose();
    _rightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('about_section_visibility_root'),
      onVisibilityChanged: (info) {
        if (!mounted) return;
        final visible = info.visibleFraction > 0.45; // Significantly higher threshold
        if (visible && !_hasAnimated) {
          _leftController.forward();
          _rightController.forward();
          _hasAnimated = true;
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width > 800 ? 80 : 40,
          horizontal: 24,
        ),
        decoration: BoxDecoration(
          color: Colors.transparent,
          backgroundBlendMode: BlendMode.srcOver,
          gradient: RadialGradient(
            center: const Alignment(-0.8, 0.8), // Bottom Left
            radius: 0.8,
            colors: [
              AppColors.primaryOrange.withValues(alpha: 0.05),
              Colors.transparent,
            ],
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isDesktop = constraints.maxWidth > 800;

                if (isDesktop) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 5, child: _buildLeftContent(isDesktop)),
                      const SizedBox(width: 80),
                      Expanded(flex: 5, child: _buildRightContent(isDesktop)),
                    ],
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLeftContent(isDesktop),
                    const SizedBox(height: 60),
                    _buildRightContent(isDesktop),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeftContent(bool isDesktop) {
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
                text: "About ",
                style: TextStyle(color: AppColors.textWhite),
              ),
              const TextSpan(
                text: "Logiqbit\n",
                style: TextStyle(color: AppColors.primaryOrange),
              ),
              const TextSpan(
                text: "Solutions",
                style: TextStyle(color: AppColors.textWhite),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Text(
          "Founded on the principles of logic and digital bit-level precision, Logiqbit Solutions is a full-service technology partner committed to solving complex business challenges with elegant digital products.",
          style: GoogleFonts.inter(
            color: AppColors.textLightGrey,
            fontSize: isDesktop ? 16 : 14,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "We bridge the gap between ambitious ideas and technical reality, delivering scalable software that drives growth and operational efficiency for modern enterprises.",
          style: GoogleFonts.inter(
            color: AppColors.textLightGrey,
            fontSize: isDesktop ? 16 : 14,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 48),
        if (isDesktop)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: _buildStatItem("50", "APPS DELIVERED", "+")),
              _buildDivider(),
              Flexible(child: _buildStatItem("1", "USERS REACHED", "K+")),
              _buildDivider(),
              Flexible(child: _buildStatItem("96", "CLIENT RETENTION", "%")),
              _buildDivider(),
              Flexible(child: _buildStatItem("5", "CLIENT RATING", "/5")),
            ],
          )
        else
          Wrap(
            spacing: 20,
            runSpacing: 24,
            children: [
              _buildStatItem("50", "APPS DELIVERED", "+"),
              _buildStatItem("1", "USERS REACHED", "K+"),
              _buildStatItem("96", "CLIENT RETENTION", "%"),
              _buildStatItem("5", "CLIENT RATING", "/5"),
            ],
          ),
      ],
    )
        .animate(controller: _leftController, autoPlay: false)
        .fadeIn(duration: 2000.ms, curve: Curves.easeOutCubic)
        .slideX(begin: -0.03, end: 0, curve: Curves.easeOutQuart);
  }

  Widget _buildRightContent(bool isDesktop) {
    return Column(
      children: [
        _buildAboutCard(
          icon: Icons.bolt_rounded,
          title: "Mission-Driven",
          description:
              "Accelerating innovation through reliable tech and strategic execution.",
          isDesktop: isDesktop,
        ),
        const SizedBox(height: 24),
        _buildAboutCard(
          icon: Icons.verified_user_outlined,
          title: "Quality Guaranteed",
          description:
              "Rigorous testing and peer reviews for every line of code we ship.",
          isDesktop: isDesktop,
        ),
      ],
    )
        .animate(controller: _rightController, autoPlay: false)
        .fadeIn(duration: 2000.ms, curve: Curves.easeOutCubic)
        .slideY(begin: 0.03, end: 0, curve: Curves.easeOutQuart);
  }

  Widget _buildDivider() {
    return Container(
      height: 30,
      width: 1.5,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white.withValues(alpha: 0.15),
    );
  }

  Widget _buildStatItem(String value, String label, String suffix) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedCounter(
          targetValue: double.tryParse(value) ?? 0,
          suffix: suffix,
          style: GoogleFonts.inter(
            color: AppColors.primaryOrange,
            fontSize: 32,
            fontWeight: FontWeight.w900,
            letterSpacing: -1.0,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.inter(
            color: AppColors.textLightGrey,
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildAboutCard({
    required IconData icon,
    required String title,
    required String description,
    required bool isDesktop,
  }) {
    return HoverCard(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(isDesktop ? 32 : 24),
        decoration: BoxDecoration(
          color: AppColors.cardBlack.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.08),
            width: 1.5,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primaryOrange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.primaryOrange.withValues(alpha: 0.15),
                  width: 1,
                ),
              ),
              child: Icon(
                icon,
                color: AppColors.primaryOrange,
                size: isDesktop ? 28 : 24,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      color: AppColors.textWhite,
                      fontSize: isDesktop ? 20 : 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    style: GoogleFonts.inter(
                      color: AppColors.textGrey,
                      fontSize: isDesktop ? 14 : 13,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MaxWidthContainer extends StatelessWidget {
  final Widget child;
  const MaxWidthContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: child,
      ),
    );
  }
}
