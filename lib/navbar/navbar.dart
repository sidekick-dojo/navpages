import 'package:flutter/material.dart';

import '../navpages/navpages.dart';

/// A customizable navigation bar widget.
///
/// Navbar provides a consistent navigation bar with title, back button
/// (when applicable), and action buttons. It automatically integrates
/// with the NavPages navigation system to show/hide the back button
/// based on navigation history.
///
/// Example:
/// ```dart
/// Navbar(
///   title: 'My Page',
///   actions: [
///     IconButton(icon: Icon(Icons.settings), onPressed: () {}),
///   ],
/// )
/// ```
class Navbar extends StatelessWidget {
  /// The title text to display in the navigation bar.
  final String title;

  /// Additional action widgets to display on the right side of the bar.
  ///
  /// These are typically icon buttons for actions like settings, search,
  /// or other page-specific functionality.
  final List<Widget> actions;

  /// The background color of the navigation bar.
  ///
  /// If null, uses the theme's secondary container color.
  final Color? backgroundColor;

  /// The foreground color for text and icons.
  ///
  /// If null, uses the theme's on secondary container color.
  final Color? foregroundColor;

  /// The height of the navigation bar.
  ///
  /// Defaults to 56 logical pixels, which is the standard
  /// height for Material Design app bars.
  final double height;

  /// Creates a Navbar widget.
  ///
  /// The [title] parameter is required. All other parameters are optional
  /// and will use theme defaults if not provided.
  const Navbar({
    super.key,
    this.title = '',
    this.actions = const [],
    this.backgroundColor,
    this.foregroundColor,
    this.height = 56,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = this.height;
    final foregroundColor =
        this.foregroundColor ?? theme.colorScheme.onSecondaryContainer;
    final backgroundColor =
        this.backgroundColor ?? theme.colorScheme.secondaryContainer;
    final navpages = NavPages.of(context);
    final canPop = navpages.canPop();
    final titleWidget = Text(
      title,
      style: theme.textTheme.titleLarge?.copyWith(color: foregroundColor),
    );

    bool centered = false;
    if (width < 768) {
      centered = true;
    }

    return Container(
      color: backgroundColor,
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          if (canPop)
            IconButton(
              onPressed: () => navpages.pop(),
              icon: Icon(Icons.arrow_back_rounded, color: foregroundColor),
            ),
          Expanded(child: centered ? Center(child: titleWidget) : titleWidget),
          ...actions,
        ],
      ),
    );
  }
}
