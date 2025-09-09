import 'package:flutter/material.dart';

import 'navrail_button.dart';

export 'navrail_button.dart';

/// The direction in which the navigation rail is laid out.
enum NavRailDirection {
  /// Horizontal layout (typically used for mobile)
  horizontal,

  /// Vertical layout (typically used for desktop)
  vertical,
}

/// A navigation rail widget that provides navigation buttons and actions.
///
/// NavRail is the core component used by [NavPages] to display navigation
/// buttons. It supports both horizontal and vertical layouts, expandable
/// states, and mobile-responsive behavior with overflow handling.
///
/// Example:
/// ```dart
/// NavRail(
///   direction: NavRailDirection.vertical,
///   buttons: [
///     NavRailButton(label: 'Home', icon: Icons.home),
///     NavRailButton(label: 'Settings', icon: Icons.settings),
///   ],
///   expandable: true,
/// )
/// ```
class NavRail extends StatefulWidget {
  /// The buttons to display in the navigation rail.
  ///
  /// If null, uses the buttons from the [NavRailButtonsProvider].
  final List<NavRailButton> buttons;

  /// The actions to display in the navigation rail.
  ///
  /// If null, uses the actions from the [NavRailActionsProvider].
  final List<NavRailButton> actions;

  /// The index of the currently selected action button.
  ///
  /// Used to highlight which action button is active.
  /// -1 indicates no action is selected.
  final int selectedActionIndex;

  /// Whether the navigation rail can be expanded/collapsed.
  ///
  /// When true, shows an expand/collapse button that allows
  /// users to toggle between compact and expanded views.
  final bool expandable;

  /// The initial expanded state of the navigation rail.
  ///
  /// Only applies when [expandable] is true.
  final bool expanded;

  /// The minimum width of the navigation rail.
  ///
  /// Used when the rail is in collapsed state.
  /// If 0, uses default minimum width.
  final double minWidth;

  /// The maximum width of the navigation rail.
  ///
  /// Used when the rail is in expanded state.
  /// If 0, uses default maximum width.
  final double maxWidth;

  /// The minimum height of the navigation rail.
  ///
  /// Used when the rail is in collapsed state (horizontal layout).
  /// If 0, uses default minimum height.
  final double minHeight;

  /// The maximum height of the navigation rail.
  ///
  /// Used when the rail is in expanded state (horizontal layout).
  /// If 0, uses default maximum height.
  final double maxHeight;

  /// The direction in which the navigation rail is laid out.
  ///
  /// [NavRailDirection.vertical] for desktop layouts,
  /// [NavRailDirection.horizontal] for mobile layouts.
  final NavRailDirection direction;

  /// The position of labels relative to icons in buttons.
  ///
  /// If null, uses default positioning based on [direction].
  final NavRailButtonLabelPosition? labelPosition;

  /// The background color of the navigation rail.
  ///
  /// If null, uses the theme's primary color.
  final Color? backgroundColor;

  /// The foreground color for text and icons.
  ///
  /// If null, uses the theme's on primary color.
  final Color? foregroundColor;

  /// The color to use for selected buttons.
  ///
  /// If null, uses theme-based colors.
  final Color? selectedColor;

  /// The background color for selected buttons.
  ///
  /// If null, uses theme-based colors.
  final Color? selectedBackgroundColor;

  /// The color to use for unselected buttons.
  ///
  /// If null, uses theme-based colors.
  final Color? unselectedColor;

  /// The background color for unselected buttons.
  ///
  /// If null, uses theme-based colors.
  final Color? unselectedBackgroundColor;

  /// Creates a NavRail widget.
  ///
  /// The [buttons] parameter is required. All other parameters are optional
  /// and will use appropriate defaults.
  const NavRail({
    super.key,
    this.buttons = const [],
    this.actions = const [],
    this.selectedActionIndex = 0,
    this.expandable = false,
    this.expanded = false,
    this.minWidth = 0,
    this.maxWidth = 0,
    this.minHeight = 0,
    this.maxHeight = 0,
    this.direction = NavRailDirection.vertical,
    this.labelPosition,
    this.backgroundColor,
    this.foregroundColor,
    this.selectedColor,
    this.selectedBackgroundColor,
    this.unselectedColor,
    this.unselectedBackgroundColor,
  });

  @override
  State<NavRail> createState() => NavRailState();
}

/// The state class for [NavRail].
///
/// This class manages the internal state of the navigation rail,
/// including button interactions, expansion state, and mobile
/// responsive behavior.
class NavRailState extends State<NavRail> {
  int _selectedButtonIndex = 0;
  int _selectedActionIndex = -1;
  bool _expanded = false;
  final _buttonsMenuController = MenuController();
  final _actionsMenuController = MenuController();
  List<NavRailButton> _buttons = [];
  List<NavRailButton> _permanentActions = [];
  List<NavRailButton> _temporaryActions = [];

  @override
  void initState() {
    super.initState();
    _expanded = widget.expanded;
    _selectedActionIndex = widget.selectedActionIndex;
    _buttons = widget.buttons;
    _permanentActions = widget.actions;
    _temporaryActions = [];
  }

  /// Toggles the expanded state of the navigation rail.
  ///
  /// This method is called when the expand/collapse button is tapped.
  /// It updates the internal state and triggers a rebuild.
  void _toggleExpanded() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = widget.backgroundColor ?? theme.colorScheme.primary;
    final foregroundColor =
        widget.foregroundColor ?? theme.colorScheme.onPrimary;
    final selectedColor = widget.selectedColor ?? backgroundColor;
    final unselectedColor = widget.unselectedColor ?? foregroundColor;
    final selectedBackgroundColor =
        widget.selectedBackgroundColor ?? theme.colorScheme.primaryContainer;
    final unselectedBackgroundColor =
        widget.unselectedBackgroundColor ?? Colors.transparent;

    final size = MediaQuery.sizeOf(context);
    final isMobile = size.width < 768;
    double width = size.width;
    double height = size.height;
    double buttonWidth = 0;
    double buttonHeight = 0;
    NavRailButtonLabelPosition labelPosition =
        widget.labelPosition ??
        (widget.direction == NavRailDirection.horizontal
            ? NavRailButtonLabelPosition.bottom
            : NavRailButtonLabelPosition.left);

    if (widget.direction == NavRailDirection.horizontal) {
      height = _expanded
          ? (widget.maxHeight == 0 ? 80 : widget.maxHeight)
          : (widget.minHeight == 0 ? 80 : widget.minHeight);
      buttonWidth = _expanded ? 120 : 40;
      buttonHeight = height;
    } else {
      width = _expanded
          ? (widget.maxWidth == 0 ? 120 : widget.maxWidth)
          : (widget.minWidth == 0 ? 40 : widget.minWidth);
      buttonWidth = width;
      buttonHeight = 40;
    }

    final buttons = _buttons
        .asMap()
        .entries
        .map(
          (entry) => entry.value.copyWith(
            onTap: () async {
              setState(() {
                _selectedButtonIndex = entry.key;
              });
              await entry.value.onTap?.call();
            },
            expanded: _expanded,
            selected: entry.key == _selectedButtonIndex,
            selectedColor: selectedColor,
            unselectedColor: unselectedColor,
            selectedBackgroundColor: selectedBackgroundColor,
            unselectedBackgroundColor: unselectedBackgroundColor,
            width: buttonWidth,
            height: buttonHeight,
            labelPosition: labelPosition,
          ),
        )
        .toList();

    final moreButtons = <NavRailButton>[];

    final actions = _permanentActions
        .asMap()
        .entries
        .map(
          (entry) => entry.value.copyWith(
            onTap: () async {
              setState(() {
                _selectedActionIndex = entry.key;
              });
              await entry.value.onTap?.call();
            },
            expanded: _expanded,
            selected: entry.key == _selectedActionIndex,
            selectedColor: selectedColor,
            unselectedColor: unselectedColor,
            selectedBackgroundColor: selectedBackgroundColor,
            unselectedBackgroundColor: unselectedBackgroundColor,
            width: buttonWidth,
            height: buttonHeight,
            labelPosition: labelPosition,
          ),
        )
        .toList();

    final temporaryActions = _temporaryActions
        .asMap()
        .entries
        .map(
          (entry) => entry.value.copyWith(
            onTap: () async {
              setState(() {
                _selectedActionIndex = entry.key;
              });
              await entry.value.onTap?.call();
            },
            expanded: _expanded,
            selected: entry.key == _selectedActionIndex,
            selectedColor: selectedColor,
            unselectedColor: unselectedColor,
            selectedBackgroundColor: selectedBackgroundColor,
            unselectedBackgroundColor: unselectedBackgroundColor,
            width: buttonWidth,
            height: buttonHeight,
            labelPosition: labelPosition,
          ),
        )
        .toList();

    final allActions = [...temporaryActions, ...actions];

    if (isMobile) {
      if (_expanded) {
        var count = _expanded
            ? (width ~/ buttonWidth) - 12
            : (width ~/ buttonWidth) - 10;
        if (count < 2) {
          count = 2;
        }
        if (buttons.length > count) {
          final subbuttons = buttons.sublist(0, count);
          moreButtons.addAll(buttons.sublist(count));
          buttons.clear();
          buttons.addAll(subbuttons);
        }
      } else {
        var count = (width ~/ buttonWidth) - 10;
        if (count < 2) {
          count = 3;
        }
        if (buttons.length > count) {
          final subbuttons = buttons.sublist(0, count);
          moreButtons.addAll(buttons.sublist(count));
          buttons.clear();
          buttons.addAll(subbuttons);
        }
      }
    }

    return Container(
      width: width,
      height: height,
      color: backgroundColor,
      child: widget.direction == NavRailDirection.horizontal
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.expandable
                    ? InkWell(
                        onTap: _toggleExpanded,
                        child: Container(
                          decoration: BoxDecoration(
                            color: theme.colorScheme.secondaryContainer,
                          ),
                          width: buttonWidth,
                          height: buttonHeight,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 4,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                _expanded
                                    ? Icons.keyboard_arrow_up_rounded
                                    : Icons.keyboard_arrow_down_rounded,
                                color: theme.colorScheme.onSecondaryContainer,
                              ),
                              if (_expanded)
                                Text(
                                  'Collapse',
                                  style: TextStyle(
                                    color:
                                        theme.colorScheme.onSecondaryContainer,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
                ...buttons,
                if (moreButtons.isNotEmpty)
                  Container(
                    margin: EdgeInsets.all(4),
                    width: _expanded ? buttonWidth / 2 : buttonWidth,
                    height: buttonHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: theme.colorScheme.inversePrimary.withValues(
                        alpha: 0.5,
                      ),
                    ),
                    child: MenuAnchor(
                      controller: _buttonsMenuController,
                      builder: (context, showMenu, _) => IconButton(
                        onPressed: () => _buttonsMenuController.isOpen
                            ? _buttonsMenuController.close()
                            : _buttonsMenuController.open(),
                        icon: Icon(
                          _buttonsMenuController.isOpen
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          color: foregroundColor,
                        ),
                        tooltip: 'More',
                      ),
                      menuChildren: moreButtons
                          .map(
                            (button) => MenuItemButton(
                              onPressed: () => button.onTap?.call(),
                              leadingIcon: Icon(button.icon),
                              child: Text(button.label ?? ''),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                if (isMobile) ...[
                  Spacer(),
                  MenuAnchor(
                    controller: _actionsMenuController,
                    builder: (context, showMenu, _) => IconButton(
                      onPressed: () => _actionsMenuController.isOpen
                          ? _actionsMenuController.close()
                          : _actionsMenuController.open(),
                      icon: Icon(
                        Icons.more_vert_rounded,
                        color: foregroundColor,
                      ),
                      tooltip: 'Actions',
                    ),
                    menuChildren: allActions
                        .map(
                          (action) => MenuItemButton(
                            onPressed: action.onTap,
                            leadingIcon: Icon(action.icon),
                            child: Text(action.label ?? ''),
                          ),
                        )
                        .toList(),
                  ),
                ],
                if (!isMobile) ...allActions,
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.expandable
                    ? InkWell(
                        onTap: _toggleExpanded,
                        child: Container(
                          decoration: BoxDecoration(
                            color: theme.colorScheme.secondaryContainer,
                          ),
                          width: buttonWidth,
                          height: buttonHeight,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 4,
                            mainAxisAlignment: _expanded
                                ? MainAxisAlignment.start
                                : MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                _expanded
                                    ? Icons.keyboard_arrow_left_rounded
                                    : Icons.keyboard_arrow_right_rounded,
                                color: theme.colorScheme.onSecondaryContainer,
                              ),
                              if (_expanded)
                                Text(
                                  'Collapse',
                                  style: TextStyle(
                                    color:
                                        theme.colorScheme.onSecondaryContainer,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
                ...buttons,
                Spacer(),
                ...allActions,
              ],
            ),
    );
  }

  void setActions(List<NavRailButton> actions) {
    setState(() {
      _temporaryActions = actions;
    });
  }
}
