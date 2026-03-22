import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../../../core/values/app_colors.dart';
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
  int _currentIndex = 1;
  double _lastCardWidth = 600;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    double cardWidthWithSpacing = _lastCardWidth + 24; 
    int newIndex = ((_scrollController.offset / cardWidthWithSpacing).round() + 1);
    
    // Ensure index is within bounds
    int totalItems = _selectedCategory == 'Apps' ? _apps.length : _games.length;
    newIndex = newIndex.clamp(1, totalItems);

    if (newIndex != _currentIndex) {
      setState(() {
        _currentIndex = newIndex;
      });
    }
  }

  void _scroll(bool forward) {
    const double scrollAmount = 600;
    final double target =
        _scrollController.offset + (forward ? scrollAmount : -scrollAmount);
    _scrollController.animateTo(
      target.clamp(0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutQuart,
    );
  }

  void _setCategory(String category) {
    if (_selectedCategory == category) return;
    setState(() {
      _selectedCategory = category;
      _currentIndex = 1;
    });
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutQuart,
    );
  }

  // Dummy Data for Apps
  final List<Map<String, dynamic>> _apps = [
    {
      "category": "FINTECH SOLUTION",
      "title": "FinFlow Enterprise",
      "description":
          "A robust financial ecosystem for multi-national corporations. Secure, scalable, and featuring real-time global ledger synchronization.",
      "tags": ["FinOps", "Blockchain", "AI Insights"],
      "imageBgColor": const Color(0xFFF6F8FA),
      "imageUrl":
          "https://images.unsplash.com/photo-1563986768494-4dee2763ff0f?auto=format&fit=crop&q=80&w=800",
      "images": [
        "https://images.unsplash.com/photo-1563986768494-4dee2763ff0f?auto=format&fit=crop&q=80&w=800",
        "https://images.unsplash.com/photo-1551288049-bebda4e38f71?auto=format&fit=crop&q=80&w=800",
        "https://images.unsplash.com/photo-1460925895917-afdab827c52f?auto=format&fit=crop&q=80&w=800",
      ],
      "icon": Icons.account_balance_wallet,
    },
    {
      "category": "SUSTAINABILITY TECH",
      "title": "EcoTrack Systems",
      "description":
          "Intelligent carbon footprint monitoring for industrial logistics. Optimizing supply chains for a greener, more sustainable future.",
      "tags": ["IoT Integration", "Big Data", "SaaS"],
      "imageBgColor": const Color(0xFF65AEA9),
      "imageUrl":
          "https://images.unsplash.com/photo-1551288049-bebda4e38f71?auto=format&fit=crop&q=80&w=800",
      "images": [
        "https://images.unsplash.com/photo-1551288049-bebda4e38f71?auto=format&fit=crop&q=80&w=800",
        "https://images.unsplash.com/photo-1460925895917-afdab827c52f?auto=format&fit=crop&q=80&w=800",
      ],
      "icon": Icons.eco,
    },
    {
      "category": "HEALTHCARE AI",
      "title": "MediScan Pro",
      "description":
          "Next-generation diagnostic tool using advanced AI to analyze medical imagery with unprecedented accuracy and speed.",
      "tags": ["ML", "Diagnostics", "Big Data"],
      "imageBgColor": const Color(0xFFE8F4FD),
      "imageUrl":
          "https://images.unsplash.com/photo-1576091160550-217359f42f8c?auto=format&fit=crop&q=80&w=800",
      "images": [
        "https://images.unsplash.com/photo-1576091160550-217359f42f8c?auto=format&fit=crop&q=80&w=800",
      ],
      "icon": Icons.medical_services,
    },
    {
      "category": "EDTECH SOLUTION",
      "title": "EduLearn Interactive",
      "description":
          "A gamified learning platform for schools, providing personalized learning paths for K-12 students.",
      "tags": ["Interactive", "Gamification", "LMS"],
      "imageBgColor": const Color(0xFFFFF4E6),
      "imageUrl":
          "https://images.unsplash.com/photo-1503676260728-1c00da094a0b?auto=format&fit=crop&q=80&w=800",
      "images": [
        "https://images.unsplash.com/photo-1503676260728-1c00da094a0b?auto=format&fit=crop&q=80&w=800",
      ],
      "icon": Icons.school,
    },
    {
      "category": "LOGISTICS OPTIMIZER",
      "title": "RouteMaster AI",
      "description":
          "Dynamic route optimization for fleet management, reducing fuel consumption and improving delivery times.",
      "tags": ["AI", "GIS", "Fleet"],
      "imageBgColor": const Color(0xFFF1F0F0),
      "imageUrl":
          "https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?auto=format&fit=crop&q=80&w=800",
      "images": [
        "https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?auto=format&fit=crop&q=80&w=800",
      ],
      "icon": Icons.local_shipping,
    },
  ];

  // Dummy Data for Games
  final List<Map<String, dynamic>> _games = [
    {
      "category": "ACTION RPG",
      "title": "Neon Genesis",
      "description":
          "A fast-paced cyberpunk action RPG with deep narrative choices and next-gen graphics powered by Unreal Engine 5.",
      "tags": ["RPG", "Cyberpunk", "Multiplayer"],
      "imageBgColor": const Color(0xFF1E1E2C),
      "imageUrl":
          "https://images.unsplash.com/photo-1542751371-adc38448a05e?auto=format&fit=crop&q=80&w=800",
      "images": [
        "https://images.unsplash.com/photo-1542751371-adc38448a05e?auto=format&fit=crop&q=80&w=800",
        "https://images.unsplash.com/photo-1550745165-9bc0b252726f?auto=format&fit=crop&q=80&w=800",
      ],
      "icon": Icons.gamepad,
    },
    {
      "category": "PUZZLE ADVENTURE",
      "title": "Logic Realms",
      "description":
          "Mind-bending puzzles set in a surreal dreamscape. Challenge your intellect with physics-based environmental riddles.",
      "tags": ["Puzzle", "Indie", "Brain Teaser"],
      "imageBgColor": const Color(0xFFE8D5CA),
      "imageUrl":
          "https://images.unsplash.com/photo-1614294149010-950b698f72c0?auto=format&fit=crop&q=80&w=800",
      "images": [
        "https://images.unsplash.com/photo-1614294149010-950b698f72c0?auto=format&fit=crop&q=80&w=800",
      ],
      "icon": Icons.extension,
    },
    {
      "category": "STRATEGY SIM",
      "title": "Urban Architect",
      "description":
          "Build and manage a sustainable city of the future, balancing ecology, economy, and citizen happiness.",
      "tags": ["Strategy", "Simulation", "City Builder"],
      "imageBgColor": const Color(0xFF2D3436),
      "imageUrl":
          "https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&q=80&w=800",
      "images": [
        "https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&q=80&w=800",
      ],
      "icon": Icons.location_city,
    },
    {
      "category": "SPACE EXPLORATION",
      "title": "Star Voyager",
      "description":
          "Embark on an epic journey across the galaxy, discovering new worlds and uncovering ancient alien secrets.",
      "tags": ["Sci-Fi", "Exploration", "Open World"],
      "imageBgColor": const Color(0xFF0F172A),
      "imageUrl":
          "https://images.unsplash.com/photo-1614728263952-84ea206f99b6?auto=format&fit=crop&q=80&w=800",
      "images": [
        "https://images.unsplash.com/photo-1614728263952-84ea206f99b6?auto=format&fit=crop&q=80&w=800",
      ],
      "icon": Icons.rocket_launch,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    List<Map<String, dynamic>> currentData = _selectedCategory == 'Apps'
        ? _apps
        : _games;

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

                // Portfolio Layout mapping all currentData dynamically
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SingleChildScrollView(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          children: currentData.asMap().entries.map((entry) {
                            int idx = entry.key;
                            var data = entry.value;

                            double cardWidth = constraints.maxWidth;
                            if (constraints.maxWidth > 1100) {
                              cardWidth = (1200 - 24) / 2;
                              if (cardWidth > constraints.maxWidth / 2) {
                                cardWidth = (constraints.maxWidth - 24) / 2;
                              }
                            } else if (constraints.maxWidth > 700) {
                              cardWidth = constraints.maxWidth * 0.8;
                            }
                            
                            // Store for scroll indicator calculation
                            _lastCardWidth = cardWidth;

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
                  ],
                ),
                const SizedBox(height: 50),
                // Navigation Indicator and Buttons (Aligned to the Right)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8, bottom: 12),
                      child: RichText(
                        text: TextSpan(
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          children: [
                            TextSpan(
                              text: "$_currentIndex ",
                              style: const TextStyle(color: AppColors.primaryOrange),
                            ),
                            TextSpan(
                              text: "/ ${currentData.length}",
                              style: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _PortfolioNavButton(
                          icon: Icons.arrow_back_ios_new_rounded,
                          onTap: () => _scroll(false),
                        ),
                        const SizedBox(width: 16),
                        _PortfolioNavButton(
                          icon: Icons.arrow_forward_ios_rounded,
                          onTap: () => _scroll(true),
                        ),
                      ],
                    ),
                  ],
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
                    )
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
                  ? AppColors.backgroundBlack
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
  final Map<String, dynamic> data;
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
              color: const Color(0xFF16110F),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 40,
                  offset: const Offset(0, 20),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  bool isStacked = constraints.maxWidth < 600;

                  if (isStacked) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AspectRatio(
                          aspectRatio: 1.2,
                          child: _buildImageSection(
                            context,
                            isStacked: isStacked,
                          ),
                        ),
                        _buildContentSection(context, isMobile: true),
                      ],
                    );
                  }

                  return IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 2,
                          child: _buildImageSection(
                            context,
                            isStacked: isStacked,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: _buildContentSection(
                            context,
                            isMobile: isStacked,
                          ),
                        ),
                      ],
                    ),
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
      color: data['imageBgColor'],
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child:
              Container(
                    constraints: BoxConstraints(
                      maxWidth: isStacked ? 200 : 160,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 30,
                          offset: const Offset(0, 15),
                        ),
                      ],
                    ),
                    child: AspectRatio(
                      aspectRatio: 9 / 19.5,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF050505),
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color: const Color(0xFF1A1A1A),
                            width: 6,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(26),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                data['imageUrl'],
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: const Color(0xFF1A1A1A),
                                    child: const Icon(
                                      Icons.phone_iphone,
                                      color: Colors.white24,
                                      size: 30,
                                    ),
                                  );
                                },
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: Container(
                                    width: 60,
                                    height: 18,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF1A1A1A),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(12),
                                        bottomRight: Radius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .animate(onPlay: (anim) => anim.repeat(reverse: true))
                  .moveY(
                    begin: 0,
                    end: -8,
                    duration: const Duration(milliseconds: 2500),
                    curve: Curves.easeInOut,
                  ),
        ),
      ),
    );
  }

  Widget _buildContentSection(BuildContext context, {required bool isMobile}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20.0 : 36.0,
        vertical: isMobile ? 20.0 : 30.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF241C18),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.primaryOrange.withValues(alpha: 0.1),
                  ),
                ),
                child: Icon(
                  data['icon'],
                  color: AppColors.primaryOrange,
                  size: 16,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  data['category'],
                  style: GoogleFonts.inter(
                    color: AppColors.primaryOrange,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            data['title'],
            style: GoogleFonts.inter(
              color: AppColors.textWhite,
              fontSize: isMobile ? 26 : 32,
              fontWeight: FontWeight.w800,
              letterSpacing: -1,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            data['description'],
            style: GoogleFonts.inter(
              color: AppColors.textLightGrey.withValues(alpha: 0.7),
              fontSize: isMobile ? 14 : 15,
              height: 1.7,
            ),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: (data['tags'] as List<String>).map((tag) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
                child: Text(
                  tag,
                  style: GoogleFonts.inter(
                    color: AppColors.textLightGrey,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () => _showProjectDetails(context, data),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.primaryOrange.withValues(alpha: 0.4),
                  width: 1.5,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "View Details",
                    style: GoogleFonts.inter(
                      color: AppColors.primaryOrange,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.north_east_rounded,
                    size: 18,
                    color: AppColors.primaryOrange,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _showProjectDetails(BuildContext context, Map<String, dynamic> data) {
  showDialog(
    context: context,
    builder: (context) => ProjectDetailsDialog(data: data),
  );
}

class ProjectDetailsDialog extends StatelessWidget {
  final Map<String, dynamic> data;

  const ProjectDetailsDialog({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final List<String> images = data['images'] ?? [data['imageUrl']];

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 900),
        decoration: BoxDecoration(
          color: const Color(0xFF110D0B),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with Close Button
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: Colors.white70),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white.withValues(alpha: 0.05),
                      ),
                    ),
                  ],
                ),
              ),

              // Image Gallery
              SizedBox(
                height: 400,
                child: PageView.builder(
                  itemCount: images.length,
                  controller: PageController(viewportFraction: 0.85),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          images[index],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
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
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Project Info
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['title'],
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      data['category'],
                      style: GoogleFonts.inter(
                        color: AppColors.primaryOrange,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      data['description'],
                      style: GoogleFonts.inter(
                        color: Colors.white70,
                        fontSize: 16,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: (data['tags'] as List<String>).map((tag) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.1),
                            ),
                          ),
                          child: Text(
                            tag,
                            style: GoogleFonts.inter(
                              color: Colors.white54,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
