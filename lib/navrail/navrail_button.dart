import 'package:flutter/material.dart';

import 'navrail.dart';

/// The position of the label relative to the icon in a [NavRailButton].
enum NavRailButtonLabelPosition {
  /// Label appears above the icon
  top,

  /// Label appears below the icon
  bottom,

  /// Label appears to the left of the icon
  left,

  /// Label appears to the right of the icon
  right,
}

/// A button widget for use in navigation rails.
///
/// NavRailButton provides a customizable button with icon and label support.
/// It automatically adapts to different states (selected/unselected) and
/// screen sizes (mobile/desktop). The button can be expanded or collapsed
/// based on the navigation rail's state.
///
/// Example:
/// ```dart
/// NavRailButton(
///   label: 'Home',
///   icon: Icons.home,
///   onTap: () => print('Home tapped'),
/// )
/// ```
class NavRailButton extends StatelessWidget {
  /// The text label to display on the button.
  ///
  /// If null, only the icon will be shown. The label is typically
  /// hidden when the button is not expanded.
  final String? label;

  /// The icon to display on the button.
  ///
  /// If null, only the label will be shown (if provided).
  final IconData? icon;

  /// The callback function to execute when the button is tapped.
  final Function()? onTap;

  /// Whether the button is in expanded state.
  ///
  /// When true, the label is visible. When false, only the icon
  /// is shown (unless on mobile where labels may still be visible).
  final bool expanded;

  /// Whether the button is currently selected.
  ///
  /// Selected buttons typically have different colors to indicate
  /// the current page or active state.
  final bool selected;

  /// The width of the button.
  ///
  /// If null or 0, uses default width based on expanded state.
  final double? width;

  /// The height of the button.
  ///
  /// If null or 0, uses default height based on expanded state.
  final double? height;

  /// The color to use when the button is selected.
  ///
  /// If null, uses theme-based colors.
  final Color? selectedColor;

  /// The background color to use when the button is selected.
  ///
  /// If null, uses theme-based colors.
  final Color? selectedBackgroundColor;

  /// The color to use when the button is not selected.
  ///
  /// If null, uses theme-based colors.
  final Color? unselectedColor;

  /// The background color to use when the button is not selected.
  ///
  /// If null, uses theme-based colors.
  final Color? unselectedBackgroundColor;

  /// The border radius for the button's background.
  ///
  /// If null, uses a default border radius of 4 pixels.
  final BorderRadius? borderRadius;

  /// The direction of the navigation rail this button belongs to.
  ///
  /// This affects the layout of the icon and label.
  final NavRailDirection direction;

  /// The position of the label relative to the icon.
  ///
  /// Defaults to [NavRailButtonLabelPosition.bottom] for vertical
  /// navigation rails and [NavRailButtonLabelPosition.right] for
  /// horizontal navigation rails.
  final NavRailButtonLabelPosition labelPosition;

  /// Creates a NavRailButton widget.
  ///
  /// At least one of [label] or [icon] should be provided.
  /// The [onTap] callback is optional but typically provided.
  const NavRailButton({
    super.key,
    this.label,
    this.icon,
    this.onTap,
    this.expanded = false,
    this.selected = false,
    this.width = 0,
    this.height = 0,
    this.selectedColor,
    this.selectedBackgroundColor,
    this.unselectedBackgroundColor,
    this.unselectedColor,
    this.borderRadius,
    this.direction = NavRailDirection.vertical,
    this.labelPosition = NavRailButtonLabelPosition.bottom,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = selected
        ? selectedBackgroundColor
        : unselectedBackgroundColor;
    final tooltipBackgroundColor = Color.lerp(
      selectedBackgroundColor ?? Colors.black,
      Colors.black,
      0.5,
    )!.withValues(alpha: 0.8);

    final screenSize = MediaQuery.sizeOf(context);
    bool isMobile = screenSize.width < 768;
    double width = this.width ?? 40;
    double height = this.height ?? 40;
    if (isMobile) {
      width = expanded ? width : width * 2;
      height = expanded ? height : height * 2;
    }
    height =
        labelPosition == NavRailButtonLabelPosition.top ||
            labelPosition == NavRailButtonLabelPosition.bottom
        ? height + 24
        : height;

    MainAxisAlignment mainAxisAlignment = expanded
        ? (direction == NavRailDirection.vertical
              ? (isMobile ? MainAxisAlignment.center : MainAxisAlignment.start)
              : MainAxisAlignment.center)
        : (direction == NavRailDirection.vertical
              ? (isMobile ? MainAxisAlignment.center : MainAxisAlignment.start)
              : MainAxisAlignment.start);
    CrossAxisAlignment crossAxisAlignment = expanded
        ? (direction == NavRailDirection.vertical
              ? CrossAxisAlignment.center
              : (isMobile
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start))
        : (direction == NavRailDirection.vertical
              ? (isMobile
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start)
              : CrossAxisAlignment.center);

    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: width,
        height: height,
        child: Tooltip(
          message: label ?? '',
          decoration: BoxDecoration(
            color: tooltipBackgroundColor,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Container(
            margin: EdgeInsets.all(4),
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: borderRadius ?? BorderRadius.circular(4),
              color: backgroundColor ?? Colors.transparent,
            ),
            child: direction == NavRailDirection.vertical
                ? labelPosition == NavRailButtonLabelPosition.top ||
                          labelPosition == NavRailButtonLabelPosition.bottom
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: mainAxisAlignment,
                          spacing: expanded ? 4 : 0,
                          crossAxisAlignment: crossAxisAlignment,
                          children: _buildLabel(context),
                        )
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: mainAxisAlignment,
                          spacing: expanded ? 4 : 0,
                          crossAxisAlignment: crossAxisAlignment,
                          children: _buildLabel(context),
                        )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: mainAxisAlignment,
                    crossAxisAlignment: crossAxisAlignment,
                    spacing: expanded ? 4 : 0,
                    children: _buildLabel(context),
                  ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildLabel(BuildContext context) {
    final theme = Theme.of(context);
    final color = selected ? selectedColor : unselectedColor;
    final style = theme.textTheme.labelMedium!.copyWith(color: color);
    final label = this.label != null
        ? Text(this.label ?? '', style: style)
        : SizedBox.shrink();
    final icon = this.icon != null
        ? Icon(this.icon, color: color)
        : SizedBox.shrink();
    final children = <Widget>[];

    switch (labelPosition) {
      case NavRailButtonLabelPosition.top || NavRailButtonLabelPosition.right:
        children.addAll([expanded ? label : SizedBox.shrink(), icon]);
        return children;
      case NavRailButtonLabelPosition.bottom || NavRailButtonLabelPosition.left:
        children.addAll([icon, expanded ? label : SizedBox.shrink()]);
        return children;
    }
  }

  /// Creates a copy of this NavRailButton with the given fields replaced.
  ///
  /// This method is used internally by the navigation system to update
  /// button properties based on state changes (selected, expanded, etc.).
  ///
  /// All parameters are optional and will use the current values if not provided.
  NavRailButton copyWith({
    String? label,
    IconData? icon,
    VoidCallback? onTap,
    bool? expanded,
    bool? selected,
    double? width,
    double? height,
    Color? selectedColor,
    Color? selectedBackgroundColor,
    Color? unselectedColor,
    Color? unselectedBackgroundColor,
    BorderRadius? borderRadius,
    NavRailButtonLabelPosition? labelPosition,
  }) => NavRailButton(
    label: label ?? this.label,
    icon: icon ?? this.icon,
    onTap: onTap ?? this.onTap,
    expanded: expanded ?? this.expanded,
    selected: selected ?? this.selected,
    width: width ?? this.width,
    height: height ?? this.height,
    selectedColor: selectedColor ?? this.selectedColor,
    selectedBackgroundColor:
        selectedBackgroundColor ?? this.selectedBackgroundColor,
    unselectedColor: unselectedColor ?? this.unselectedColor,
    unselectedBackgroundColor:
        unselectedBackgroundColor ?? this.unselectedBackgroundColor,
    borderRadius: borderRadius ?? this.borderRadius,
    labelPosition: labelPosition ?? this.labelPosition,
    key: key,
  );
}
