import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/values/app_colors.dart';
import 'about_section.dart'; // For MaxWidthContainer
import 'navbar.dart'; // For LogoWidget

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF000000), // Pure black for the premium look
      child: Column(
        children: [
          // Main Footer Content
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
            child: MaxWidthContainer(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isDesktop = constraints.maxWidth > 1000;

                  if (isDesktop) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 3, child: _buildBrandDescription()),
                        const SizedBox(width: 40),
                        Expanded(flex: 2, child: _buildColumn("Company", ["About", "Career", "Contact", "Privacy Policy", "Terms of Service"])),
                        Expanded(flex: 3, child: _buildColumn("Services", ["Artificial Intelligence", "Web Development", "Mobile Development", "Cloud Solutions", "UI/UX Design", "DevOps & Automation", "Digital Marketing & SEO"])),
                        Expanded(flex: 3, child: _buildColumn("Technologies", ["Frontend", "Backend", "Mobile", "Database", "Cloud & DevOps", "UI/UX", "Digital Marketing & SEO"])),
                      ],
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBrandDescription(),
                      const SizedBox(height: 48),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _buildColumn("Company", ["About", "Career", "Contact", "Privacy Policy", "Terms of Service"], isMobile: true)),
                          Expanded(child: _buildColumn("Services", ["Artificial Intelligence", "Web Development", "Mobile Development", "Cloud Solutions", "UI/UX Design", "DevOps & Automation", "Digital Marketing & SEO"], isMobile: true)),
                        ],
                      ),
                      const SizedBox(height: 48),
                      _buildColumn("Technologies", ["Frontend", "Backend", "Mobile", "Database", "Cloud & DevOps", "UI/UX", "Digital Marketing & SEO"], isMobile: true),
                    ],
                  );
                },
              ),
            ),
          ),

          // Bottom Bar
          Container(
            height: 1,
            color: Colors.white.withValues(alpha: 0.05),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            child: MaxWidthContainer(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isMobile = constraints.maxWidth < 600;
                  
                  final copyright = Text(
                    "© 2026 Logiqbit Solutions. All rights reserved.",
                    style: GoogleFonts.inter(
                      color: Colors.white38,
                      fontSize: 14,
                    ),
                  );

                  final socialIcons = Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _socialIcon(Icons.work_rounded), // LinkedIn
                      const SizedBox(width: 12),
                      _socialIcon(Icons.camera_alt_outlined), // Instagram
                      const SizedBox(width: 12),
                      _socialIcon(Icons.facebook_rounded),
                      const SizedBox(width: 12),
                      _socialIcon(Icons.close_rounded), // X (Twitter)
                    ],
                  );

                  final crafted = Text(
                    "Crafted with precision",
                    style: GoogleFonts.inter(
                      color: Colors.white38,
                      fontSize: 14,
                    ),
                  );

                  if (isMobile) {
                    return Column(
                      children: [
                        socialIcons,
                        const SizedBox(height: 24),
                        copyright,
                        const SizedBox(height: 8),
                        crafted,
                      ],
                    );
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      socialIcons,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          copyright,
                          const SizedBox(height: 4),
                          crafted,
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo
        const LogoWidget(),
        const SizedBox(height: 24),
        Text(
          "Innovative digital solutions tailored for your business success. We architect excellence for global industry leaders.",
          style: GoogleFonts.inter(
            color: Colors.white60,
            fontSize: 15,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 32),
        _contactItem(Icons.email_outlined, "contact@logiqbit.com"),
      ],
    );
  }

  Widget _contactItem(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.primaryOrange, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.inter(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildColumn(String title, List<String> links, {bool isMobile = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 24),
        if (title == "Technologies" && isMobile)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: links.length,
            itemBuilder: (context, index) => _buildLink(links[index]),
          )
        else
          ...links.map((link) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildLink(link),
          )),
      ],
    );
  }

  Widget _buildLink(String link) {
    return InkWell(
      onTap: () {},
      child: Text(
        link,
        style: GoogleFonts.inter(
          color: Colors.white54,
          fontSize: 15,
        ),
      ),
    );
  }

  // Remove _buildTechnologiesColumn as it is no longer used.

  Widget _socialIcon(IconData icon) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Icon(icon, color: Colors.white70, size: 18),
    );
  }
}
