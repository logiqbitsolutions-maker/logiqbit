import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/values/app_colors.dart';
import '../controllers/home_controller.dart';
import 'about_section.dart'; // For MaxWidthContainer
import 'booking_calendar.dart';
import 'booking_dialog.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  String _selectedHelp = "AI Solutions";
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  bool _isSending = false;
  String? _nameError;
  String? _emailError;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    setState(() {
      _nameError = null;
      _emailError = null;
    });

    bool hasError = false;
    if (_nameController.text.trim().isEmpty) {
      _nameError = "Name is required";
      hasError = true;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (_emailController.text.trim().isEmpty || !emailRegex.hasMatch(_emailController.text.trim())) {
      _emailError = "Please enter a valid email address";
      hasError = true;
    }

    if (hasError) {
      setState(() {});
      return;
    }

    setState(() => _isSending = true);

    final controller = Get.find<HomeController>();
    await controller.saveInquiry(
      _nameController.text.trim(),
      _emailController.text.trim(),
      _selectedHelp,
      _subjectController.text.trim(),
    );

    if (mounted) {
      _nameController.clear();
      _emailController.clear();
      _subjectController.clear();
      setState(() => _isSending = false);
      
      // Delaying the dialog by a frame prevents GoogleFonts and layout assertions
      // occurring if this async callback resolves mid-frame.
      Future.delayed(const Duration(milliseconds: 100), () {
        if (!mounted) return;
        showDialog(
          context: context,
        builder: (context) => AlertDialog(
          backgroundColor: AppColors.cardBlack,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          contentPadding: const EdgeInsets.all(32),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primaryOrange.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle, color: AppColors.primaryOrange, size: 48),
              ),
              const SizedBox(height: 24),
              Text(
                "Message Sent!",
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Thank you for reaching out. Our team will get back to you shortly.",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: AppColors.textLightGrey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryOrange,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text("Done", style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      );
      });
    }
  }

  void _showBookingDialog(DateTime date) {
    final controller = Get.find<HomeController>();
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.8),
      builder: (context) => BookingDialog(
        selectedDate: date,
        onBookingConfirmed: controller.addBooking,
      ),
    );
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
                final isMobile = constraints.maxWidth < 600;
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
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 40),
      decoration: BoxDecoration(
        color: AppColors.cardBlack,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.06),
          width: 1,
        ),
      ),
      child: BookingCalendar(
        showBack: false,
        onBack: () {},
        onDateSelected: _showBookingDialog,
      ),
    );
  }

  Widget _buildRightForm() {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Container(
          padding: EdgeInsets.all(isMobile ? 24 : 48),
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
              if (!isMobile)
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        label: "YOUR NAME",
                        hint: "John Doe",
                        controller: _nameController,
                        errorText: _nameError,
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: _buildTextField(
                        label: "BUSINESS EMAIL",
                        hint: "john@company.com",
                        controller: _emailController,
                        errorText: _emailError,
                      ),
                    ),
                  ],
                )
              else ...[
                _buildTextField(
                  label: "YOUR NAME",
                  hint: "John Doe",
                  controller: _nameController,
                  errorText: _nameError,
                ),
                const SizedBox(height: 24),
                _buildTextField(
                  label: "BUSINESS EMAIL",
                  hint: "john@company.com",
                  controller: _emailController,
                  errorText: _emailError,
                ),
              ],
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
    String? errorText,
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
            errorText: errorText,
            errorStyle: GoogleFonts.inter(color: Colors.redAccent, fontSize: 12),
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
          isExpanded: true,
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
                    "AI Solutions",
                    "Web Development",
                    "Mobile App",
                    "Game Development",
                    "General Inquiry",
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
