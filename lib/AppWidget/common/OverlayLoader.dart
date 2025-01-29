import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';

class OverlayLoader {
  showLoader(context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    Loader.show(
      context,
      progressIndicator: Lottie.asset('assets/json/loader.json',
          fit: BoxFit.contain, height: screenHeight * 0.3),
      overlayColor: Colors.white.withOpacity(0.6),
    );
  }

  showTaskLoader(context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    Loader.show(
      context,
      progressIndicator: Lottie.asset('assets/json/loader.json',
          fit: BoxFit.contain, height: screenHeight * 0.3),
      overlayColor: Colors.white.withOpacity(0.2),
    );
  }

  hideLoader() {
    Loader.hide();
  }
}
