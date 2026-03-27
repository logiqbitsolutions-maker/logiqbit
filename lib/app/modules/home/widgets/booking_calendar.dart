import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/values/app_colors.dart';

class BookingCalendar extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final VoidCallback onBack;
  final bool showBack;

  const BookingCalendar({
    super.key,
    required this.onDateSelected,
    required this.onBack,
    this.showBack = true,
  });

  @override
  State<BookingCalendar> createState() => _BookingCalendarState();
}

class _BookingCalendarState extends State<BookingCalendar> {
  late DateTime _focusedDay;
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (widget.showBack) ...[
                  IconButton(
                    onPressed: widget.onBack,
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 12),
                ],
                Text(
                  "Select a Date",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 32),
        _buildCalendarHeader(),
        const SizedBox(height: 24),
        _buildCalendarGrid(),
        const SizedBox(height: 48),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _selectedDay == null
                ? null
                : () => widget.onDateSelected(_selectedDay!),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryOrange,
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.white.withValues(alpha: 0.1),
              disabledForegroundColor: Colors.white.withValues(alpha: 0.3),
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: Text(
              "Confirm Date",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Removed _buildTimeSlotsGrid

  Widget _buildCalendarHeader() {
    final months = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${months[_focusedDay.month - 1]} ${_focusedDay.year}",
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          children: [
            _buildChevronButton(
              Icons.chevron_left,
              () {
                setState(() {
                  _focusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1);
                });
              },
              _focusedDay.month > DateTime.now().month || _focusedDay.year > DateTime.now().year,
            ),
            const SizedBox(width: 8),
            _buildChevronButton(
              Icons.chevron_right,
              () {
                setState(() {
                  _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + 1);
                });
              },
              true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildChevronButton(IconData icon, VoidCallback onPressed, bool enabled) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        onPressed: enabled ? onPressed : null,
        icon: Icon(icon, color: enabled ? Colors.white : Colors.white.withValues(alpha: 0.3)),
        padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final daysInMonth = DateTime(_focusedDay.year, _focusedDay.month + 1, 0).day;
    final firstDayOfMonth = DateTime(_focusedDay.year, _focusedDay.month, 1).weekday;
    
    // weekday returns 1 for Monday, 7 for Sunday. 
    // Let's adjust for Sun-Sat grid (0 for Sun)
    final offset = firstDayOfMonth % 7;

    final weekDays = ["S", "M", "T", "W", "T", "F", "S"];

    final numWeeks = ((daysInMonth + offset) / 7).ceil();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: weekDays.map((day) => Expanded(
            child: Center(
              child: Text(
                day,
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          )).toList(),
        ),
        const SizedBox(height: 16),
        Column(
          children: List.generate(numWeeks, (weekIndex) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: List.generate(7, (dayIndex) {
                  final index = weekIndex * 7 + dayIndex;
                  if (index < offset || index >= daysInMonth + offset) {
                    return const Expanded(child: SizedBox.shrink());
                  }
                  
                  final day = index - offset + 1;
                  final date = DateTime(_focusedDay.year, _focusedDay.month, day);
                  final isPast = date.isBefore(DateTime.now().subtract(const Duration(days: 1))) && 
                                 !(date.year == DateTime.now().year && date.month == DateTime.now().month && date.day == DateTime.now().day);
                  final isSelected = _selectedDay?.year == date.year && 
                                     _selectedDay?.month == date.month && 
                                     _selectedDay?.day == date.day;
                  final isToday = date.year == DateTime.now().year && 
                                  date.month == DateTime.now().month && 
                                  date.day == DateTime.now().day;

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: GestureDetector(
                        onTap: isPast ? null : () {
                          setState(() {
                            _selectedDay = date;
                          });
                        },
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.primaryOrange : (isToday ? Colors.white.withValues(alpha: 0.1) : Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                              border: isToday && !isSelected ? Border.all(color: Colors.white.withValues(alpha: 0.3)) : null,
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Text(
                                  day.toString(),
                                  style: GoogleFonts.inter(
                                    color: isSelected ? Colors.white : (isPast ? Colors.white.withValues(alpha: 0.2) : Colors.white),
                                    fontSize: 14,
                                    fontWeight: isSelected || isToday ? FontWeight.w700 : FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            );
          }),
        ),
      ],
    );
  }
}
