import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout(
      {super.key, required this.isMobile, required this.isDesktop});
  final Widget isMobile;
  final Widget isDesktop;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraits) {
          if (constraits.maxWidth < 720) {
            return isMobile;
          } else {
            return isDesktop;
          }
        },
      ),
    );
  }
}
