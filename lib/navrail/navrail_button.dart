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
class NavRailButton extends NrButtonWidget {
  /// Creates a NavRailButton widget.
  ///
  /// At least one of [label] or [icon] should be provided.
  /// The [onTap] callback is optional but typically provided.
  const NavRailButton({
    super.key,
    super.label,
    super.icon,
    super.onTap,
    super.expanded = false,
    super.selected = false,
    super.showSelected = true,
    super.width = 0,
    super.height = 0,
    super.selectedColor,
    super.selectedBackgroundColor,
    super.unselectedBackgroundColor,
    super.unselectedColor,
    super.borderRadius,
    super.direction = NavRailDirection.vertical,
    super.labelPosition = NavRailButtonLabelPosition.bottom,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = (selected && showSelected)
        ? selectedBackgroundColor
        : unselectedBackgroundColor;
    final tooltipBackgroundColor = Color.lerp(
      selectedBackgroundColor ?? Colors.black,
      Colors.black,
      0.5,
    )!.withValues(alpha: 0.8);

    double width = this.width ?? 40;
    double height = this.height ?? 40;
    height =
        labelPosition == NavRailButtonLabelPosition.top ||
            labelPosition == NavRailButtonLabelPosition.bottom
        ? height + 24
        : height;

    MainAxisAlignment mainAxisAlignment = direction == NavRailDirection.vertical
        ? expanded
              ? MainAxisAlignment.start
              : MainAxisAlignment.center
        : MainAxisAlignment.center;
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center;

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
    final color = (selected && showSelected) ? selectedColor : unselectedColor;
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
  @override
  NavRailButton copyWith({
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
  }) => NavRailButton(
    label: label ?? this.label,
    icon: icon ?? this.icon,
    onTap: onTap ?? this.onTap,
    expanded: expanded ?? this.expanded,
    selected: selected ?? this.selected,
    showSelected: showSelected ?? this.showSelected,
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
    direction: direction ?? this.direction,
  );
}
