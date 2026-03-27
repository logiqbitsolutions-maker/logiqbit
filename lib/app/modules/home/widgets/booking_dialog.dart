import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/values/app_colors.dart';
import '../../../data/models/booking_model.dart';

class BookingDialog extends StatefulWidget {
  final DateTime selectedDate;
  final Function(BookingModel)? onBookingConfirmed;

  const BookingDialog({
    super.key,
    required this.selectedDate,
    this.onBookingConfirmed,
  });

  @override
  State<BookingDialog> createState() => _BookingDialogState();
}

class _BookingDialogState extends State<BookingDialog> {
  String? _selectedTime;
  bool _isSuccess = false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _detailsController = TextEditingController();
  String? _selectedService;
  bool _isBooking = false;

  // Inline validation errors
  String? _nameError;
  String? _emailError;
  String? _phoneError;
  String? _serviceError;

  // Time slots: 8 AM → 12 AM, 3 per row
  final List<Map<String, dynamic>> _timeSlots = [
    {"label": "07:00 PM", "period": "evening"},
    {"label": "08:00 PM", "period": "evening"},
    {"label": "09:00 PM", "period": "night"},
    {"label": "10:00 PM", "period": "night"},
    {"label": "11:00 PM", "period": "night"},
    {"label": "12:00 AM", "period": "night"},
  ];

  final List<Map<String, dynamic>> _services = [
    {"label": "AI Solutions", "icon": Icons.auto_awesome_rounded},
    {"label": "Web Development", "icon": Icons.language_rounded},
    {"label": "Mobile App", "icon": Icons.phone_iphone_rounded},
    {"label": "Game Development", "icon": Icons.sports_esports_rounded},
    {"label": "Cloud Architecture", "icon": Icons.cloud_rounded},
    {"label": "Digital Strategy", "icon": Icons.trending_up_rounded},
    {"label": "UI/UX Design", "icon": Icons.palette_rounded},
  ];

  bool get _canSubmit =>
      _selectedTime != null &&
      _nameController.text.trim().isNotEmpty &&
      _emailController.text.trim().isNotEmpty &&
      _phoneController.text.trim().isNotEmpty &&
      _selectedService != null;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() => setState(() => _nameError = null));
    _emailController.addListener(() => setState(() => _emailError = null));
    _phoneController.addListener(() => setState(() => _phoneError = null));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  Future<void> _submitBooking() async {
    bool valid = true;
    setState(() {
      _nameError = _nameController.text.trim().isEmpty
          ? "Please enter your name"
          : null;
      
      final email = _emailController.text.trim();
      final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
      if (email.isEmpty) {
        _emailError = "Please enter your email";
      } else if (!emailRegex.hasMatch(email)) {
        _emailError = "Please enter a valid email";
      } else {
        _emailError = null;
      }

      _phoneError = _phoneController.text.trim().isEmpty
          ? "Please enter your phone number"
          : null;
      _serviceError = _selectedService == null
          ? "Please select a service"
          : null;
    });

    if (_nameError != null || _emailError != null || _phoneError != null || _serviceError != null) {
      valid = false;
    }
    if (!valid) return;

    setState(() => _isBooking = true);
    
    final booking = BookingModel(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      service: _selectedService!,
      bookingDate: widget.selectedDate,
      timeSlot: _selectedTime!,
      details: _detailsController.text.trim(),
    );

    // Keep the artificial delay for UX (to show the spinner)
    await Future.delayed(const Duration(milliseconds: 800));
    
    if (mounted) {
      // Pass the booking data upwards immediately
      widget.onBookingConfirmed?.call(booking);
      
      setState(() {
        _isBooking = false;
        _isSuccess = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWide = constraints.maxWidth >= 720;
          final screenW = MediaQuery.of(context).size.width;
          return Container(
                width: isWide ? 920 : screenW - 40,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.9,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF111111),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.07),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.7),
                      blurRadius: 80,
                      spreadRadius: 20,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: _isSuccess
                      ? _buildSuccess()
                      : _buildMainLayout(isWide),
                ),
              )
              .animate()
              .fadeIn(duration: 350.ms)
              .scale(
                begin: const Offset(0.96, 0.96),
                end: const Offset(1, 1),
                curve: Curves.easeOutBack,
              );
        },
      ),
    );
  }

  Widget _buildMainLayout(bool isWide) {
    if (!isWide) {
      return Column(
        children: [
          _buildTopBar(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDateChip(),
                  const SizedBox(height: 28),
                  _buildTimeSection(),
                  const SizedBox(height: 32),
                  _buildFormSection(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          _buildBottomBar(),
        ],
      );
    }

    return Column(
      children: [
        _buildTopBar(),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left: Date + Time
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D0D0D),
                    border: Border(
                      right: BorderSide(
                        color: Colors.white.withValues(alpha: 0.06),
                      ),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(36),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDateChip(),
                        const SizedBox(height: 36),
                        _buildTimeSection(),
                      ],
                    ),
                  ),
                ),
              ),
              // Right: Form
              Expanded(
                flex: 7,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(36),
                  child: _buildFormSection(),
                ),
              ),
            ],
          ),
        ),
        _buildBottomBar(),
      ],
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white.withValues(alpha: 0.06)),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.primaryOrange,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            "Book a Consultation",
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.close, color: Colors.white60, size: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateChip() {
    final months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    final days = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday",
    ];
    final d = widget.selectedDate;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.primaryOrange.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primaryOrange.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.primaryOrange,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                "${d.day}",
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                days[d.weekday - 1],
                style: GoogleFonts.inter(
                  color: Colors.white54,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "${months[d.month - 1]} ${d.day}, ${d.year}",
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.schedule_rounded,
              color: AppColors.primaryOrange,
              size: 17,
            ),
            const SizedBox(width: 8),
            Text(
              "Choose a Time",
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          "Available 8 AM – 12 AM (IST)",
          style: GoogleFonts.inter(color: Colors.white38, fontSize: 11),
        ),
        const SizedBox(height: 18),
        // 3-column grid
        LayoutBuilder(
          builder: (ctx, cst) {
            const gap = 10.0;
            final w = (cst.maxWidth - gap * 2) / 3;
            return Wrap(
              spacing: gap,
              runSpacing: gap,
              children: _timeSlots.map((slot) {
                final label = slot["label"] as String;
                final isNight = slot["period"] == "night";
                final selected = _selectedTime == label;
                return GestureDetector(
                  onTap: () => setState(() => _selectedTime = label),
                  child: AnimatedContainer(
                    duration: 180.ms,
                    width: w,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.primaryOrange
                          : Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: selected
                            ? AppColors.primaryOrange
                            : isNight
                            ? Colors.deepPurple.withValues(alpha: 0.3)
                            : Colors.white.withValues(alpha: 0.08),
                      ),
                      boxShadow: selected
                          ? [
                              BoxShadow(
                                color: AppColors.primaryOrange.withValues(
                                  alpha: 0.3,
                                ),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : [],
                    ),
                    child: Column(
                      children: [
                        Text(
                          label,
                          style: GoogleFonts.inter(
                            color: selected
                                ? Colors.white
                                : Colors.white.withValues(alpha: 0.8),
                            fontSize: 12,
                            fontWeight: selected
                                ? FontWeight.w700
                                : FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildFormSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _fieldLabel("Full Name"),
        _field(
          "John Doe",
          _nameController,
          icon: Icons.person_outline_rounded,
          error: _nameError,
        ),
        const SizedBox(height: 20),
        _fieldLabel("Email Address"),
        _field(
          "john@example.com",
          _emailController,
          icon: Icons.email_outlined,
          error: _emailError,
        ),
        const SizedBox(height: 20),
        _fieldLabel("Phone Number"),
        _field(
          "+91 98765 43210",
          _phoneController,
          icon: Icons.phone_outlined,
          error: _phoneError,
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            const Icon(
              Icons.dashboard_customize_rounded,
              color: AppColors.primaryOrange,
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              "Service of Interest",
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        if (_serviceError != null) ...[
          const SizedBox(height: 6),
          _errorText(_serviceError!),
        ],
        const SizedBox(height: 14),
        _buildServicePicker(),
        const SizedBox(height: 20),
        _fieldLabel("Project Details (Optional)"),
        _field(
          "Tell us what you'd like to discuss...",
          _detailsController,
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _fieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: Colors.white.withValues(alpha: 0.6),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _field(
    String hint,
    TextEditingController ctrl, {
    int maxLines = 1,
    IconData? icon,
    String? error,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: ctrl,
          maxLines: maxLines,
          onChanged: (_) => setState(() {}),
          style: GoogleFonts.inter(color: Colors.white, fontSize: 14),
          decoration: InputDecoration(
            prefixIcon: icon != null
                ? Icon(
                    icon,
                    color: error != null
                        ? Colors.redAccent.withValues(alpha: 0.6)
                        : Colors.white30,
                    size: 19,
                  )
                : null,
            hintText: hint,
            hintStyle: GoogleFonts.inter(color: Colors.white24, fontSize: 14),
            filled: true,
            fillColor: error != null
                ? Colors.red.withValues(alpha: 0.04)
                : Colors.white.withValues(alpha: 0.04),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: error != null
                    ? Colors.redAccent.withValues(alpha: 0.5)
                    : Colors.white.withValues(alpha: 0.08),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: error != null
                    ? Colors.redAccent
                    : AppColors.primaryOrange,
                width: 1.5,
              ),
            ),
          ),
        ),
        if (error != null) ...[const SizedBox(height: 6), _errorText(error)],
      ],
    );
  }

  Widget _errorText(String msg) {
    return Row(
      children: [
        const Icon(
          Icons.error_outline_rounded,
          color: Colors.redAccent,
          size: 13,
        ),
        const SizedBox(width: 5),
        Text(
          msg,
          style: GoogleFonts.inter(
            color: Colors.redAccent,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ).animate().fadeIn(duration: 200.ms).slideY(begin: -0.3, end: 0);
  }

  Widget _buildServicePicker() {
    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = 10.0;
        final chipW = (constraints.maxWidth - gap) / 2;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: _services.map((s) {
            final label = s["label"] as String;
            final icon = s["icon"] as IconData;
            final sel = _selectedService == label;
            return GestureDetector(
              onTap: () => setState(() {
                _selectedService = label;
                _serviceError = null;
              }),
              child: AnimatedContainer(
                duration: 180.ms,
                width: chipW,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: sel
                      ? AppColors.primaryOrange.withValues(alpha: 0.12)
                      : Colors.white.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: sel
                        ? AppColors.primaryOrange.withValues(alpha: 0.7)
                        : Colors.white.withValues(alpha: 0.1),
                    width: sel ? 1.5 : 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      icon,
                      size: 14,
                      color: sel
                          ? AppColors.primaryOrange
                          : Colors.white.withValues(alpha: 0.5),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        label,
                        style: GoogleFonts.inter(
                          color: sel
                              ? AppColors.primaryOrange
                              : Colors.white.withValues(alpha: 0.7),
                          fontSize: 12,
                          fontWeight: sel ? FontWeight.w700 : FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildBottomBar() {
    final ready = _canSubmit;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF0D0D0D),
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.06)),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.lock_outline_rounded, color: Colors.white24, size: 13),
          const SizedBox(width: 6),
          const Flexible(
            child: Text(
              "Secure & private",
              style: TextStyle(color: Colors.white24, fontSize: 11),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 12),
          AnimatedContainer(
            duration: 300.ms,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              boxShadow: ready && !_isBooking
                  ? [
                      BoxShadow(
                        color: AppColors.primaryOrange.withValues(alpha: 0.35),
                        blurRadius: 18,
                        offset: const Offset(0, 6),
                      ),
                    ]
                  : [],
            ),
            child: SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: ready && !_isBooking ? _submitBooking : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryOrange,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.white.withValues(alpha: 0.06),
                  disabledForegroundColor: Colors.white24,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: _isBooking
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        "Confirm Booking",
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccess() {
    final months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    final d = widget.selectedDate;
    final dateStr = "${d.day} ${months[d.month - 1]} ${d.year}";

    return Stack(
      children: [
        // Glow decoration
        Positioned(
          top: -60,
          left: -60,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.green.withValues(alpha: 0.06),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 64),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Animated check
                Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green.withValues(alpha: 0.08),
                        border: Border.all(
                          color: Colors.green.withValues(alpha: 0.25),
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        color: Colors.green,
                        size: 46,
                      ),
                    )
                    .animate()
                    .scale(duration: 500.ms, curve: Curves.elasticOut)
                    .fadeIn(),
                const SizedBox(height: 32),

                Text(
                  "Booking Confirmed!",
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.2, end: 0),
                const SizedBox(height: 10),
                Text(
                  "We'll see you soon. Check your inbox for the calendar invite.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.45),
                    fontSize: 14,
                    height: 1.6,
                  ),
                ).animate(delay: 300.ms).fadeIn(),
                const SizedBox(height: 36),

                // Booking summary card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.03),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.07),
                    ),
                  ),
                  child: Column(
                    children: [
                      _summaryRow(
                        Icons.calendar_today_rounded,
                        "Date",
                        dateStr,
                      ),
                      _divider(),
                      _summaryRow(
                        Icons.schedule_rounded,
                        "Time",
                        _selectedTime ?? "",
                      ),
                      _divider(),
                      _summaryRow(
                        Icons.dashboard_customize_rounded,
                        "Service",
                        _selectedService ?? "",
                      ),
                      _divider(),
                      _summaryRow(
                        Icons.person_outline_rounded,
                        "Name",
                        _nameController.text,
                      ),
                    ],
                  ),
                ).animate(delay: 400.ms).fadeIn().slideY(begin: 0.1, end: 0),
                const SizedBox(height: 32),

                const SizedBox(height: 8),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: Colors.white.withValues(alpha: 0.12),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      "Back to Site",
                      style: GoogleFonts.inter(
                        color: Colors.white60,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ).animate(delay: 600.ms).fadeIn(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _summaryRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryOrange, size: 16),
          const SizedBox(width: 12),
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.white38,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() =>
      Divider(color: Colors.white.withValues(alpha: 0.05), height: 1);
}
