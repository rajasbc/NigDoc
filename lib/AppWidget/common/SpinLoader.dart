import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../AppWidget/common/Colors.dart'as custom_color;

class SpinLoader extends StatefulWidget {
  const SpinLoader({super.key});

  @override
  State<SpinLoader> createState() => _SpinLoaderState();
}

class _SpinLoaderState extends State<SpinLoader> {
  @override
  Widget build(BuildContext context) {
    return SpinKitDualRing(
      color: custom_color.appcolor,
      size: 20,
    );
  }
}