import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/values/app_colors.dart';

class AdvancedExecutionBlueprint extends StatefulWidget {
  const AdvancedExecutionBlueprint({super.key});

  @override
  State<AdvancedExecutionBlueprint> createState() =>
      _AdvancedExecutionBlueprintState();
}

class _AdvancedExecutionBlueprintState extends State<AdvancedExecutionBlueprint> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 900;
        if (isDesktop) {
          return _buildDesktopLayout(constraints);
        }
        return _buildMobileLayout(constraints);
      },
    );
  }

  Widget _buildDesktopLayout(BoxConstraints constraints) {
    final stepWidth = constraints.maxWidth / 5; // Updated for 5 steps

    return Stack(
      alignment: Alignment.topLeft,
      children: [
        // Static Base Line
        Positioned(
          top: 36,
          left: stepWidth / 2,
          right: stepWidth / 2,
          child: Container(
            height: 1,
            color: Colors.white.withValues(alpha: 0.1),
          ),
        ),

        // Step Boxes (Row)
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(5, (index) {
            return Expanded(
              child: _buildStep(
                index,
                _getStepTitle(index),
                _getStepDescription(index),
                false,
                _getStepNumber(index),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BoxConstraints constraints) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        // Static Vertical Connecting Line
        Positioned(
          top: 28, // Center of first 56x56 circle
          bottom: 120, // Approximate center of last circle (depends on last card height)
          child: Container(
            width: 1.5,
            color: Colors.white.withValues(alpha: 0.1),
          ),
        ),

        // Step Boxes
        Column(
          children: List.generate(5, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: _buildStep(
                index,
                _getStepTitle(index),
                _getStepDescription(index),
                true,
                _getStepNumber(index),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildStep(
    int index,
    String title,
    String description,
    bool isMobile,
    String number,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: isMobile ? 56 : 72,
          height: isMobile ? 56 : 72,
          decoration: BoxDecoration(
            color: AppColors.cardBlack.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.08),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryOrange.withValues(alpha: 0.1),
                blurRadius: 15,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Center(
            child: Text(
              number,
              style: GoogleFonts.inter(
                color: AppColors.primaryOrange,
                fontSize: isMobile ? 16 : 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: AppColors.textWhite,
            fontSize: isMobile ? 18 : 20,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          description,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: const Color(0xFFF9F9F9).withValues(alpha: 0.6),
            fontSize: 14,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  String _getStepNumber(int index) => "0${index + 1}";
  String _getStepTitle(int index) {
    switch (index) {
      case 0:
        return "Audit & Plan";
      case 1:
        return "UX/UI Prototype";
      case 2:
        return "Build MVP";
      case 3:
        return "Agile Sprints";
      case 4:
        return "Scale & Ship";
      default:
        return "";
    }
  }

  String _getStepDescription(int index) {
    switch (index) {
      case 0:
        return "Deep dive into requirements, architecture planning, and strategic scoping.";
      case 1:
        return "Rapid high-fidelity prototyping and user validation before a single line of code.";
      case 2:
        return "Transforming concepts into a functional Minimum Viable Product to fast-track market entry and feedback.";
      case 3:
        return "High-velocity development cycles with continuous integration and testing.";
      case 4:
        return "Zero-downtime deployment with intensive monitoring and optimization.";
      default:
        return "";
    }
  }
}
