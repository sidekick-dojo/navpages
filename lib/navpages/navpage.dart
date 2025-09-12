import 'package:flutter/material.dart';

import '../navbar/navbar.dart';

/// A widget that represents a single page within a [NavPages] widget.
///
/// NavPage combines a navigation bar (optional) with page content.
/// It provides a consistent structure for pages within the navigation system.
///
/// Example:
/// ```dart
/// NavPage(
///   navbar: Navbar(title: 'My Page'),
///   child: MyPageContent(),
/// )
/// ```
class NavPage extends StatelessWidget {
  /// The navigation bar to display at the top of the page.
  ///
  /// If null, no navigation bar will be shown. The navbar typically
  /// contains the page title and action buttons.
  final Navbar? navbar;

  /// The main content widget for the page.
  ///
  /// This widget will be displayed below the navbar (if present)
  /// and will fill the remaining space.
  final Widget? child;

  /// Whether to display the page in fullscreen mode.
  ///
  /// If true, the page will be displayed in fullscreen mode.
  final bool fullscreen;

  /// Creates a NavPage widget.
  ///
  /// The [child] parameter is optional but typically provided.
  /// The [navbar] parameter is also optional.
  const NavPage({super.key, this.navbar, this.child, this.fullscreen = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ?navbar,
        if (child != null) Expanded(child: child!),
      ],
    );
  }
}
