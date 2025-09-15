import 'package:flutter/material.dart';

import 'navrail.dart';

abstract class NrButtonWidget extends StatelessWidget {
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

  /// Whether to display when selected.
  ///
  /// When true, the selected button is displayed. When false, the button is not displayed.
  final bool showSelected;

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

  const NrButtonWidget({
    super.key,
    this.label,
    this.icon,
    this.onTap,
    this.expanded = false,
    this.selected = false,
    this.showSelected = true,
    this.width,
    this.height,
    this.selectedColor,
    this.selectedBackgroundColor,
    this.unselectedColor,
    this.unselectedBackgroundColor,
    this.borderRadius,
    this.direction = NavRailDirection.vertical,
    this.labelPosition = NavRailButtonLabelPosition.bottom,
  });

  NrButtonWidget copyWith({
    String? label,
    IconData? icon,
    Function()? onTap,
    bool? expanded,
    bool? selected,
    bool? showSelected,
    double? width,
    double? height,
    Color? selectedColor,
    Color? selectedBackgroundColor,
    Color? unselectedColor,
    Color? unselectedBackgroundColor,
    BorderRadius? borderRadius,
    NavRailDirection? direction,
    NavRailButtonLabelPosition? labelPosition,
  });

  @override
  Widget build(BuildContext context);
}
