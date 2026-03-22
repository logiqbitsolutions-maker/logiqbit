import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final ScrollController scrollController = ScrollController();

  final GlobalKey heroKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey servicesKey = GlobalKey();
  final GlobalKey whyUsKey = GlobalKey();
  final GlobalKey integrationsKey = GlobalKey();
  final GlobalKey portfolioKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  final RxDouble scrollOpacity = 0.0.obs;
  final RxDouble scrollProgress = 1.0.obs;
  final RxString activeSection = "Home".obs;

  void updateScrollOpacity(double pixels) {
    scrollOpacity.value = (pixels / 100).clamp(0, 1);
  }

  void scrollToSection(GlobalKey key, String sectionName) {
    activeSection.value = sectionName;
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  void onInit() {
    super.onInit();

    // 2. Listener set karya pachi turant ek var calculate karo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateProgress();
    });

    scrollController.addListener(() {
      _calculateProgress();
      if (scrollController.hasClients) {
        updateScrollOpacity(scrollController.position.pixels);
      }
    });
  }

  void _calculateProgress() {
    if (scrollController.hasClients) {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;

      // Agar page scroll thai shake tem nathi (maxScroll == 0), to progress 1.0 rakho
      if (maxScroll <= 0) {
        scrollProgress.value = 1.0;
        return;
      }

      // Logic: Top par 1.0, Bottom par 0.0
      double progress = 1.0 - (currentScroll / maxScroll);
      scrollProgress.value = progress.clamp(0.0, 1.0);
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
