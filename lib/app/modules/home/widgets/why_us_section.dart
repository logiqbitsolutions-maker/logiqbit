import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/values/app_colors.dart';
import 'about_section.dart'; // For MaxWidthContainer
import 'hover_card.dart';

class WhyUsSection extends StatelessWidget {
  const WhyUsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // (Background Grid removed)

        Container(
          width: double.infinity,
          color: Colors.transparent,
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.width > 800 ? 100 : 60,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: MaxWidthContainer(
                  child: _buildFeatureSection(
                    MediaQuery.of(context).size.width < 800,
                    context,
                  ),
                ),
              ),
              const SizedBox(height: 120),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _buildReviewsHeader(
                  MediaQuery.of(context).size.width < 800,
                ),
              ),
              const SizedBox(height: 60),
              _buildHorizontalReviews(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureSection(bool isMobile, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(isMobile),
        const SizedBox(height: 60),
        _buildFeatureCards(context),
      ],
    );
  }

  Widget _buildHeader(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: GoogleFonts.inter(
              fontSize: isMobile ? 36 : 48,
              fontWeight: FontWeight.w800,
              height: 1.1,
              letterSpacing: -1.0,
            ),
            children: [
              const TextSpan(
                text: "Why Choose ",
                style: TextStyle(color: Colors.white),
              ),
              const TextSpan(
                text: "Logiqbit",
                style: TextStyle(color: AppColors.primaryOrange),
              ),
            ],
          ),
        ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.05, end: 0),
        const SizedBox(height: 24),
        SizedBox(
          width: 700,
          child: Text(
            "We deliver cutting-edge digital solutions with a focus on innovation, reliability, and measurable excellence for forward-thinking enterprises.",
            style: GoogleFonts.inter(
              color: AppColors.textGrey,
              fontSize: isMobile ? 14 : 16,
              height: 1.6,
            ),
          ),
        ).animate().fadeIn(duration: 800.ms, delay: 200.ms),
      ],
    );
  }

  Widget _buildFeatureCards(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final isTablet =
            constraints.maxWidth >= 600 && constraints.maxWidth < 1000;

        double spacing = 24;
        double width;
        if (isMobile) {
          width = constraints.maxWidth;
        } else if (isTablet) {
          width = (constraints.maxWidth - spacing) / 2;
        } else {
          width = (constraints.maxWidth - (spacing * 3)) / 4;
        }

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            _buildFeatureCard(
              icon: Icons.lightbulb_outline_rounded,
              title: "Innovation First",
              description:
                  "We leverage the latest AI and cloud architectures to ensure your business stays ahead of the competition.",
              delay: 0,
              isMobile: isMobile,
              width: width,
            ),
            _buildFeatureCard(
              icon: Icons.auto_graph_rounded,
              title: "Scalable Tech",
              description:
                  "Our modular systems are designed to expand seamlessly as your user base and data requirements grow.",
              delay: 100,
              isMobile: isMobile,
              width: width,
            ),
            _buildFeatureCard(
              icon: Icons.groups_rounded,
              title: "Expert Team",
              description:
                  "Access a pool of world-class developers and consultants with deep domain expertise in your industry.",
              delay: 200,
              isMobile: isMobile,
              width: width,
            ),
            _buildFeatureCard(
              icon: Icons.support_agent_rounded,
              title: "24/7 Support",
              description:
                  "Global monitoring systems and a dedicated response team ready to assist you at any hour.",
              delay: 300,
              isMobile: isMobile,
              width: width,
            ),
          ],
        );
      },
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required int delay,
    required bool isMobile,
    required double width,
  }) {
    return HoverCard(
          child: Container(
            width: width,
            padding: EdgeInsets.all(isMobile ? 24 : 32),
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
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryOrange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: AppColors.primaryOrange, size: 24),
                ),
                const SizedBox(height: 24),
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: isMobile ? 18 : 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF999999),
                    fontSize: isMobile ? 13 : 14,
                    height: 1.6,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 800.ms, delay: delay.ms)
        .slideY(begin: 0.1, end: 0);
  }

  Widget _buildReviewsHeader(bool isMobile) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: GoogleFonts.inter(
          fontSize: isMobile ? 36 : 48,
          fontWeight: FontWeight.w800,
          height: 1.1,
          letterSpacing: -1.0,
        ),
        children: [
          const TextSpan(
            text: "What Our ",
            style: TextStyle(color: Colors.white),
          ),
          const TextSpan(
            text: "Clients Say",
            style: TextStyle(color: AppColors.primaryOrange),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 1.seconds).slideY(begin: 0.2, end: 0);
  }

  Widget _buildHorizontalReviews(BuildContext context) {
    final List<_ReviewData> reviews = [
      _ReviewData(
        name: "Mylana",
        info: "Pomorskie Szkoły Rzemiosł • POLAND",
        quote:
            "They delivered exceptional results, combining strong technical expertise, clean and scalable code, and clear communication throughout the process.",
        tag: "(React JS / JavaScript)",
        imageUrl: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=150",
      ),
      _ReviewData(
        name: "SK Smaira",
        info: "Tech Leader • India",
        quote:
            "They delivered on time according to our requirement. We have new projects too; we will approach them if they can do on our budget.",
        imageUrl: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=150",
      ),
      _ReviewData(
        name: "Marcus Chen",
        info: "CTO, NEXACORP",
        quote:
            "Logiqbit transformed our legacy infrastructure into a high-performance cloud ecosystem. Their technical depth is unparalleled.",
        imageUrl: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&q=80&w=150",
      ),
      _ReviewData(
        name: "Sarah Jenkins",
        info: "Product Head, FinFlow",
        quote:
            "The level of scalability we've achieved with their modular architecture has allowed us to grow 3x without any downtime.",
        imageUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?auto=format&fit=crop&q=80&w=150",
      ),
      _ReviewData(
        name: "David Miller",
        info: "VP Ops, Global Retail",
        quote:
            "Their team doesn't just build code; they build business value. A strategic partner that actually understands ROI.",
        imageUrl: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&q=80&w=150",
      ),
      _ReviewData(
        name: "Anna Petrova",
        info: "Founder, GreenTech",
        quote:
            "Working with Logiqbit was a game-changer for our startup. They delivered a complex mobile app in record time.",
        imageUrl: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&q=80&w=150",
      ),
      _ReviewData(
        name: "James Wilson",
        info: "CEO, TechSphere",
        quote:
            "Logiqbit's team is not just a group of developers, but a group of thinkers. They understood our vision from day one.",
        imageUrl: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&q=80&w=150",
      ),
    ];

    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.transparent,
            Colors.black,
            Colors.black,
            Colors.transparent,
          ],
          stops: [0.0, 0.1, 0.9, 1.0],
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstIn,
      child: SizedBox(
        height: 280,
        child: _AutoScrollingRow(reviews: reviews, speed: 90),
      ),
    );
  }
}

class _AutoScrollingRow extends StatefulWidget {
  final List<_ReviewData> reviews;
  final double speed;

  const _AutoScrollingRow({required this.reviews, required this.speed});

  @override
  State<_AutoScrollingRow> createState() => _AutoScrollingRowState();
}

class _AutoScrollingRowState extends State<_AutoScrollingRow> {
  late ScrollController _scrollController;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startScrolling());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _startScrolling() async {
    while (mounted) {
      if (!_isHovered && _scrollController.hasClients) {
        final double maxExtent = _scrollController.position.maxScrollExtent;
        final double currentExtent = _scrollController.offset;

        if (currentExtent >= maxExtent) {
          _scrollController.jumpTo(0);
        }

        final double remainingDistance = maxExtent - _scrollController.offset;
        if (remainingDistance > 0) {
          final int remainingDuration =
              (remainingDistance * 1000 / widget.speed).toInt();

          await _scrollController
              .animateTo(
                maxExtent,
                duration: Duration(milliseconds: remainingDuration),
                curve: Curves.linear,
              )
              .catchError((_) {});
        }
      }
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
    if (isHovered) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.offset,
          duration: const Duration(milliseconds: 10),
          curve: Curves.linear,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<_ReviewData> doubledReviews = [
      ...widget.reviews,
      ...widget.reviews,
      ...widget.reviews,
    ];

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: doubledReviews.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SizedBox(
              width: 320,
              child: _ReviewCard(data: doubledReviews[index]),
            ),
          );
        },
      ),
    );
  }
}

class _ReviewData {
  final String name;
  final String info;
  final String quote;
  final String? tag;
  final String? imageUrl;

  _ReviewData({
    required this.name,
    required this.info,
    required this.quote,
    this.tag,
    this.imageUrl,
  });
}

class _ReviewCard extends StatelessWidget {
  final _ReviewData data;

  const _ReviewCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      child: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(20),
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
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF1E2330),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: data.imageUrl != null
                        ? Image.network(
                            data.imageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                              Icons.person,
                              color: Colors.white24,
                              size: 20,
                            ),
                          )
                        : const Icon(
                            Icons.person,
                            color: Colors.white24,
                            size: 20,
                          ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.name,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        data.info,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF6B7280),
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (data.tag != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: Text(
                  data.tag!,
                  style: GoogleFonts.inter(
                    color: AppColors.primaryOrange.withValues(alpha: 0.8),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            Expanded(
              child: Text(
                data.quote,
                style: GoogleFonts.inter(
                  color: const Color(0xFFE5E7EB),
                  fontSize: 13,
                  height: 1.4,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 10),
            const Icon(
              Icons.format_quote_rounded,
              color: AppColors.primaryOrange,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}

// Removed _GridBackground and _GridPainter as they are no longer used.
