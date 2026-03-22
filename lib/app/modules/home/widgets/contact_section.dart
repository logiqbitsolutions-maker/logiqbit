import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/values/app_colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'about_section.dart'; // For MaxWidthContainer
import 'animated_border_button.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  String _selectedHelp = "General Inquiry";
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  bool _isSending = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _subjectController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    setState(() => _isSending = true);

    try {
      final response = await http.post(
        Uri.parse('/api/send-email'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': _nameController.text,
          'email': _emailController.text,
          'subject': _selectedHelp,
          'message': _subjectController.text,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Message sent! We'll get back to you soon."),
            backgroundColor: AppColors.primaryOrange,
          ),
        );
        _nameController.clear();
        _emailController.clear();
        _subjectController.clear();
      } else {
        throw Exception('Failed to send message');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}"), backgroundColor: Colors.red),
      );
    } finally {
      setState(() => _isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.backgroundBlack,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: MaxWidthContainer(
        child: Column(
          children: [
            // Intro Section
            LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 800;
                return Column(
                  children: [
                    RichText(
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
                            text: "Get In ",
                            style: TextStyle(color: Colors.white),
                          ),
                          const TextSpan(
                            text: "Touch",
                            style: TextStyle(color: AppColors.primaryOrange),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                SizedBox(
                  width: 600,
                  child: Text(
                    "Have a vision you'd like to bring to life? We're here to help you navigate the journey. Reach out to us for any inquiries, and let's collaborate.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: AppColors.textLightGrey.withValues(alpha: 0.7),
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),
                ),
                  ],
                );
              },
            ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.1, end: 0),
            const SizedBox(height: 64),
            LayoutBuilder(
              builder: (context, constraints) {
                final isDesktop = constraints.maxWidth > 800;
                if (isDesktop) {
                  return IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(flex: 5, child: _buildLeftCard()),
                        const SizedBox(width: 32),
                        Expanded(flex: 7, child: _buildRightForm()),
                      ],
                    ),
                  );
                }
                return Column(
                  children: [
                    _buildLeftCard(),
                    const SizedBox(height: 32),
                    _buildRightForm(),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 56),
      decoration: BoxDecoration(
        color: AppColors.primaryOrange,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Elevate Your\nTech Presence",
                style: GoogleFonts.inter(
                  color: AppColors.textWhite,
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  height: 1.1,
                  letterSpacing: -1.5,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Turn your ideas into reality with our expert team. Let's build something extraordinary together.",
                style: GoogleFonts.inter(
                  color: AppColors.textWhite.withValues(alpha: 0.8),
                  fontSize: 16,
                  height: 1.6,
                ),
              ),
            ],
          ),
          const SizedBox(height: 48),
          // Book a Free Call button (white)
          AnimatedBorderButton(
            text: "Book a Free Call",
            icon: Icons.arrow_outward,
            onPressed: () {},
            fillOnHover: false,
            backgroundColor: Colors.transparent,
            textColor: AppColors.textWhite,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.05, end: 0);
  }

  Widget _buildRightForm() {
    return Container(
          padding: const EdgeInsets.all(48),
          decoration: BoxDecoration(
            color: AppColors.cardBlack,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.06),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row 1: Name + Email
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      label: "YOUR NAME",
                      hint: "John Doe",
                      controller: _nameController,
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: _buildTextField(
                      label: "BUSINESS EMAIL",
                      hint: "john@company.com",
                      controller: _emailController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Row 2: Help dropdown
              _buildDropdown(),
              const SizedBox(height: 24),
              // Row 3: Subject
              _buildTextField(
                label: "SUBJECT",
                hint: "Tell us about your project...",
                maxLines: 4,
                controller: _subjectController,
              ),
              const SizedBox(height: 36),
              // Submit button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSending ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryOrange,
                    foregroundColor: AppColors.textWhite,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: _isSending
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          "Send Message",
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: 200.ms, duration: 800.ms)
        .slideX(begin: 0.05, end: 0);
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: AppColors.textDarkGrey,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          style: GoogleFonts.inter(color: AppColors.textWhite, fontSize: 15),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(
              color: AppColors.textDarkGrey,
              fontSize: 15,
            ),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.04),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColors.primaryOrange.withValues(alpha: 0.5),
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "HOW CAN WE HELP?",
          style: GoogleFonts.inter(
            color: AppColors.textDarkGrey,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedHelp,
          dropdownColor: const Color(0xFF1A1A1A),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.textDarkGrey,
          ),
          style: GoogleFonts.inter(color: AppColors.textWhite, fontSize: 15),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.04),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColors.primaryOrange.withValues(alpha: 0.5),
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
          items:
              [
                    "General Inquiry",
                    "Custom Software Development",
                    "Digital Strategy",
                    "Cloud Architecture",
                    "Partnership",
                  ]
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: GoogleFonts.inter(
                          color: AppColors.textWhite,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  )
                  .toList(),
          onChanged: (val) {
            if (val != null) setState(() => _selectedHelp = val);
          },
        ),
      ],
    );
  }
}
