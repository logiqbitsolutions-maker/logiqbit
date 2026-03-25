import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../../../core/values/app_colors.dart';
import '../../../data/models/project_model.dart';
import '../../../data/project_data.dart';
import '../controllers/home_controller.dart';
import 'about_section.dart'; // For MaxWidthContainer
import 'hover_card.dart';

class PortfolioSection extends StatefulWidget {
  const PortfolioSection({super.key});

  @override
  State<PortfolioSection> createState() => _PortfolioSectionState();
}

class _PortfolioSectionState extends State<PortfolioSection> {
  String _selectedCategory = 'Apps';
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    setState(() {}); // Force rebuild for indicator
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _setCategory(String category) {
    if (_selectedCategory == category) return;
    setState(() {
      _selectedCategory = category;
    });
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutQuart,
      );
    }
  }

  // Data sourced from project_data.dart
  final List<ProjectModel> _apps = ProjectData.apps;
  final List<ProjectModel> _games = ProjectData.games;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    List<ProjectModel> currentData =
        _selectedCategory == 'Apps' ? _apps : _games;

    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 600;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 40 : 80,
            horizontal: 24,
          ),
          color: AppColors.backgroundBlack,
          child: MaxWidthContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row: Title left, Tabs right
                if (constraints.maxWidth > 800)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [_buildTitle(isMobile), _buildTabs()],
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTitle(isMobile),
                      const SizedBox(height: 32),
                      _buildTabs(),
                    ],
                  ),
                SizedBox(height: isMobile ? 40 : 60),

                // Portfolio Layout
                if (isMobile)
                  Center(
                    child: Column(
                      children: currentData.asMap().entries.map((entry) {
                        int idx = entry.key;
                        var data = entry.value;

                        // Mobile card width: smaller and centered
                        double cardWidth = (constraints.maxWidth - 48) * 0.9;

                        return Container(
                          width: cardWidth,
                          margin: const EdgeInsets.only(bottom: 24),
                          child: PortfolioCard(
                            data: data,
                            delay: idx * 100,
                            controller: controller,
                          ),
                        );
                      }).toList(),
                    ),
                  )
                else
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.transparent,
                          Colors.black,
                          Colors.black,
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.05, 0.95, 1.0],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.dstIn,
                    child: ScrollConfiguration(
                      behavior: const MaterialScrollBehavior().copyWith(
                        dragDevices: {
                          PointerDeviceKind.mouse,
                          PointerDeviceKind.touch,
                          PointerDeviceKind.trackpad,
                          PointerDeviceKind.stylus,
                        },
                      ),
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                          child: Row(
                            children: currentData.asMap().entries.map((entry) {
                              int idx = entry.key;
                              var data = entry.value;

                              double cardWidth = constraints.maxWidth;
                              if (constraints.maxWidth > 900) {
                                cardWidth = (1200 - 48) / 3.3; // Allow next card to peek
                              } else if (constraints.maxWidth > 600) {
                                cardWidth = constraints.maxWidth * 0.75; // Tablet peek
                              }

                              return Container(
                                width: cardWidth,
                                margin: const EdgeInsets.only(right: 24),
                                child: PortfolioCard(
                                  data: data,
                                  delay: idx * 100,
                                  controller: controller,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),

                if (!isMobile)
                  // Horizontal Scroll Progress Indicator
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Center(
                      child: Container(
                        width: 200,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            double progress = 0;
                            if (_scrollController.hasClients &&
                                _scrollController.position.maxScrollExtent >
                                    0) {
                              progress = (_scrollController.offset /
                                      _scrollController
                                          .position.maxScrollExtent)
                                  .clamp(0.0, 1.0);
                            }
                            return Stack(
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 100),
                                  width: constraints.maxWidth * progress,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryOrange,
                                    borderRadius: BorderRadius.circular(2),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.primaryOrange
                                            .withValues(alpha: 0.3),
                                        blurRadius: 10,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitle(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
              text: TextSpan(
                style: GoogleFonts.inter(
                  fontSize: isMobile ? 36 : 48,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                  letterSpacing: -1,
                ),
                children: [
                  const TextSpan(
                    text: "Our ",
                    style: TextStyle(color: Colors.white),
                  ),
                  const TextSpan(
                    text: "Portfolio",
                    style: TextStyle(color: AppColors.primaryOrange),
                  ),
                ],
              ),
            )
            .animate()
            .fadeIn(duration: 800.ms, delay: 100.ms)
            .slideY(begin: 0.2, end: 0),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Text(
            "Explore our curated collection of digital experiences and innovative solutions. We architect excellence for global industry leaders.",
            style: GoogleFonts.inter(
              color: AppColors.textLightGrey,
              fontSize: isMobile ? 14 : 16,
              height: 1.6,
            ),
          ),
        ).animate().fadeIn(delay: 400.ms, duration: 600.ms),
      ],
    );
  }

  Widget _buildTabs() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surfaceBlack,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _TabButton(
            title: "Apps",
            isSelected: _selectedCategory == 'Apps',
            onTap: () => _setCategory('Apps'),
          ),
          _TabButton(
            title: "Games",
            isSelected: _selectedCategory == 'Games',
            onTap: () => _setCategory('Games'),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms, duration: 600.ms);
  }
}

class _PortfolioNavButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _PortfolioNavButton({required this.icon, required this.onTap});

  @override
  State<_PortfolioNavButton> createState() => _PortfolioNavButtonState();
}

class _PortfolioNavButtonState extends State<_PortfolioNavButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(30),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: _isHovered
                  ? AppColors.primaryOrange
                  : Colors.white.withValues(alpha: 0.1),
              width: 1.5,
            ),
            color: _isHovered
                ? AppColors.primaryOrange.withValues(alpha: 0.1)
                : AppColors.surfaceBlack,
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primaryOrange.withValues(alpha: 0.2),
                      blurRadius: 15,
                      spreadRadius: -2,
                    ),
                  ]
                : [],
          ),
          child: Icon(
            widget.icon,
            color: _isHovered ? AppColors.primaryOrange : Colors.white70,
            size: 20,
          ),
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryOrange : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            title,
            style: GoogleFonts.inter(
              color: isSelected
                  ? Colors.white
                  : AppColors.textLightGrey,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

class PortfolioCard extends StatelessWidget {
  final ProjectModel data;
  final int delay;
  final HomeController controller;

  const PortfolioCard({
    super.key,
    required this.data,
    required this.controller,
    this.delay = 0,
  });

  @override
  Widget build(BuildContext context) {
    return HoverCard(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(
                0xFF0D0D0D,
              ), // Deeper dark background to match reference
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.5),
                  blurRadius: 40,
                  offset: const Offset(0, 20),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  bool isMobile = constraints.maxWidth < 600;

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AspectRatio(
                        aspectRatio: isMobile ? 1.8 : 1.5,
                        child: _buildImageSection(context, isStacked: true),
                      ),
                      _buildContentSection(context, isMobile: isMobile),
                    ],
                  );
                },
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: delay),
          duration: 800.ms,
        )
        .scale(
          begin: const Offset(0.98, 0.98),
          end: const Offset(1, 1),
          curve: Curves.easeOutBack,
        );
  }

  Widget _buildImageSection(BuildContext context, {required bool isStacked}) {
    return Container(
      width: double.infinity,
      color: data.imageBgColor,
      child: ClipRRect(
        child: data.imageUrl.startsWith('assets/')
            ? Image.asset(
                data.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _buildErrorPlaceholder(),
              )
            : Image.network(
                data.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _buildErrorPlaceholder(),
              ),
      ),
    );
  }

  Widget _buildErrorPlaceholder() {
    return Container(
      color: const Color(0xFF1A1A1A),
      child: const Icon(
        Icons.image_not_supported_outlined,
        color: Colors.white24,
        size: 30,
      ),
    );
  }

  Widget _buildContentSection(BuildContext context, {required bool isMobile}) {
    return Padding(
      padding: EdgeInsets.all(isMobile ? 20.0 : 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1512), // Deep warm dark for icon bg
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.primaryOrange.withValues(alpha: 0.15),
                  ),
                ),
                child: Icon(
                  data.icon,
                  color: AppColors.primaryOrange,
                  size: 18,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  data.category,
                  style: GoogleFonts.inter(
                    color: AppColors.primaryOrange,
                    fontSize: 13,
                    fontWeight: FontWeight.w900, // Extra bold like reference
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 20 : 32),
          Text(
            data.title,
            style: GoogleFonts.inter(
              color: AppColors.textWhite,
              fontSize: isMobile ? 18 : 22,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.8,
              height: 1.1,
            ),
          ),
          SizedBox(height: isMobile ? 16 : 24),
          Wrap(
            spacing: 12,
            runSpacing: 10,
            children: (data.tags).map((tag) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A), // Darker pill bg
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
                child: Text(
                  tag,
                  style: GoogleFonts.inter(
                    color: Colors.white70,
                    fontSize: isMobile ? 9 : 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: isMobile ? 24 : 40),
          InkWell(
            onTap: () => _showProjectDetails(context, data),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.primaryOrange.withValues(alpha: 0.6),
                  width: 1.5,
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "View Details",
                      style: GoogleFonts.inter(
                        color: AppColors.primaryOrange,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons
                          .north_east_rounded, // Better arrow for reference look
                      size: 20,
                      color: AppColors.primaryOrange,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _showProjectDetails(BuildContext context, ProjectModel data) {
  showDialog(
    context: context,
    builder: (context) => ProjectDetailsDialog(data: data),
  );
}

class ProjectDetailsDialog extends StatelessWidget {
  final ProjectModel data;

  const ProjectDetailsDialog({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width >= 1000;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 600),
        tween: Tween(begin: 0.0, end: 1.0),
        curve: Curves.easeOutQuart,
        builder: (context, value, child) {
          return Transform.scale(
            scale: 0.95 + (0.05 * value),
            child: Opacity(
              opacity: value,
              child: child,
            ),
          );
        },
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 1200,
            maxHeight: MediaQuery.of(context).size.height * 0.9,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF0A0705),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.8),
                blurRadius: 40,
                spreadRadius: -10,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: isDesktop ? _buildDesktopLayout(context) : _buildMobileLayout(context),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Left Side: Content (Fixed/Scrollable scroll)
        Expanded(
          flex: 4,
          child: Container(
            padding: const EdgeInsets.all(48),
            decoration: BoxDecoration(
              border: Border(right: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const SizedBox(height: 60),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildProjectMeta(),
                        const SizedBox(height: 48),
                        _buildDescription(),
                        const SizedBox(height: 48),
                        _buildTechStack(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Right Side: Showcase (Big Gallery)
        Expanded(
          flex: 6,
          child: Container(
            color: Colors.black.withValues(alpha: 0.2),
            child: _buildGallery(isDesktop: true),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: _buildHeader(context),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: _buildProjectMeta(),
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 380, // Fixed height for mobile gallery
            child: _buildGallery(isDesktop: false),
          ),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDescription(),
                const SizedBox(height: 32),
                _buildTechStack(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.category.toUpperCase(),
                style: GoogleFonts.inter(
                  color: AppColors.primaryOrange,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                data.title,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  height: 1.1,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close_rounded, color: Colors.white, size: 24),
          style: IconButton.styleFrom(
            backgroundColor: Colors.white.withValues(alpha: 0.1),
            padding: const EdgeInsets.all(12),
          ),
        ),
      ],
    );
  }

  Widget _buildProjectMeta() {
    return Row(
      children: [
        _metaItem("PLATFORM", "Mobile App"),
        const SizedBox(width: 40),
        _metaItem("YEAR", "2024"),
        const SizedBox(width: 40),
        _metaItem("STATUS", "Completed"),
      ],
    );
  }

  Widget _metaItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white38,
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "OVERVIEW",
          style: GoogleFonts.inter(
            color: Colors.white38,
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          data.description,
          style: GoogleFonts.inter(
            color: Colors.white70,
            fontSize: 16,
            height: 1.8,
          ),
        ),
      ],
    );
  }

  Widget _buildTechStack() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "TECH STACK",
          style: GoogleFonts.inter(
            color: Colors.white38,
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: data.tags.map((tag) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
            ),
            child: Text(
              tag,
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildGallery({required bool isDesktop}) {
    return ScrollConfiguration(
      behavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.trackpad,
          PointerDeviceKind.stylus,
        },
      ),
      child: ListView.separated(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 48 : 24,
          vertical: isDesktop ? 60 : 20,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: data.images.length,
        separatorBuilder: (context, index) => SizedBox(width: isDesktop ? 40 : 20),
        itemBuilder: (context, index) {
          return HoverScaleWidget(
            child: Container(
              width: isDesktop ? 340 : 260,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.6),
                    blurRadius: 30,
                    spreadRadius: -5,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: data.images[index].startsWith('assets/')
                    ? Image.asset(
                        data.images[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            _buildErrorPlaceholder(),
                      )
                    : Image.network(
                        data.images[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            _buildErrorPlaceholder(),
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
  Widget _buildErrorPlaceholder() {
    return Container(
      color: const Color(0xFF1A1A1A),
      width: double.infinity,
      height: double.infinity,
      child: const Icon(
        Icons.image_not_supported_outlined,
        color: Colors.white24,
        size: 50,
      ),
    );
  }
}

class HoverScaleWidget extends StatefulWidget {
  final Widget child;
  const HoverScaleWidget({super.key, required this.child});

  @override
  State<HoverScaleWidget> createState() => _HoverScaleWidgetState();
}

class _HoverScaleWidgetState extends State<HoverScaleWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()..scale(_isHovered ? 1.05 : 1.0),
        child: widget.child,
      ),
    );
  }
}
