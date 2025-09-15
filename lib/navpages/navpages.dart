import 'dart:developer';

import 'package:flutter/material.dart';
import '../navrail/navrail.dart';
import 'navpage.dart';

export '../navbar/navbar.dart';
export 'navpage.dart';
export '../navrail/navrail.dart';

/// The direction in which the navigation pages are laid out.
enum NavPagesDirection {
  /// Horizontal layout (typically used for mobile)
  horizontal,

  /// Vertical layout (typically used for desktop)
  vertical,
}

enum NavPagesRailPosition {
  /// Left side (typically used for desktop)
  left,

  /// Right side (typically used for desktop)
  right,

  /// Top side (typically used for mobile)
  top,

  /// Bottom side (typically used for mobile)
  bottom,
}

/// A widget that manages multiple pages with integrated navigation controls.
///
/// NavPages provides a complete solution for managing multiple pages with
/// built-in navigation controls and responsive design. It automatically
/// adapts to different screen sizes and provides Navigator-like methods
/// for controlling page history.
///
/// Example:
/// ```dart
/// NavPages(
///   buttons: [
///     NavRailButton(label: 'Home', icon: Icons.home),
///     NavRailButton(label: 'Settings', icon: Icons.settings),
///   ],
///   children: [
///     NavPage(navbar: Navbar(title: 'Home'), child: HomePage()),
///     NavPage(navbar: Navbar(title: 'Settings'), child: SettingsPage()),
///   ],
/// )
/// ```
class NavPages extends StatefulWidget {
  /// The list of pages to display.
  ///
  /// Each page corresponds to a button in the navigation rail.
  /// The number of children should match the number of buttons.
  ///
  /// The preferred type is [NavPage].
  final List<Widget> children;

  /// The direction in which the navigation is laid out.
  ///
  /// Defaults to [NavPagesDirection.vertical] for desktop layouts.
  /// Automatically switches to horizontal on mobile devices.
  final NavPagesDirection direction;

  /// The position of the navigation rail.
  ///
  /// Defaults to [NavPagesRailPosition.left] for desktop layouts.
  /// Automatically switches to [NavPagesRailPosition.top] on mobile devices.
  final NavPagesRailPosition navrailPosition;

  /// The navigation buttons for the rail.
  ///
  /// These buttons control which page is displayed. Each button
  /// corresponds to a page in the [children] list.
  final List<NrButtonWidget> buttons;

  /// Additional action buttons for the navigation rail.
  ///
  /// These buttons are typically used for secondary actions like
  /// settings, help, or logout. They don't control page navigation.
  final List<NrButtonWidget> actions;

  /// Whether the navigation rail can be expanded/collapsed.
  ///
  /// When true, shows an expand/collapse button that allows users
  /// to toggle between compact and expanded views.
  final bool expandable;

  /// The initial expanded state of the navigation rail.
  ///
  /// Only applies when [expandable] is true.
  final bool expanded;

  /// The height of the expandable button.
  ///
  /// Only applies when [expandable] is true.
  final double expandableButtonHeight;

  /// The minimum width of the navigation rail.
  ///
  /// Applies when [expanded] is true.
  final double navrailMinWidth;

  /// The maximum width of the navigation rail.
  ///
  /// Applies when [expanded] is true.
  final double navrailMaxWidth;

  /// The minimum height of the navigation rail.
  ///
  /// Applies when [expanded] is true.
  final double navrailMinHeight;

  /// The maximum height of the navigation rail.
  ///
  /// Applies when [expanded] is true.
  final double navrailMaxHeight;

  /// Whether the navigation rail can be scrolled vertically.
  ///
  /// When true, shows a scrollable area for the navigation rail.
  final bool navrailVerticleScrolling;

  /// The leading widget for the navigation rail.
  ///
  /// Applies when [expanded] is true.
  final Widget? navrailLeading;

  /// The small leading widget for the navigation rail.
  ///
  /// Applies when [expanded] is false.
  final Widget? navrailSmallLeading;

  /// Whether the leading widget is on the top is true.
  final bool navrailLeadingOnTop;

  /// The header widget for the site.
  ///
  /// The display is dependent on [useFullHeader]; above the content when [useFullHeader] is false; above the
  /// everything when [useFullHeader] is true.
  final Widget? header;

  /// Whether to use the full header when direction is vertical.
  ///
  /// When true, the header is displayed above everything.
  final bool useFullHeader;

  /// The footer widget for the site.
  ///
  /// The display is dependent on [useFullFooter]; below the content when [useFullFooter] is false; below the
  /// everything when [useFullFooter] is true.
  final Widget? footer;

  /// Whether to use the full footer when direction is vertical.
  ///
  /// When true, the footer is displayed below everything.
  final bool useFullFooter;

  /// Whether to use the full screen.
  ///
  /// When true, the content is displayed in the full screen.
  final bool fullscreen;

  /// Whether to show the selected action index.
  ///
  /// When true, the selected action index is displayed.
  final bool showActionSelectedIndex;

  /// Whether to show the selected secondary action index.
  ///
  /// When true, the selected secondary action index is displayed.
  final bool showSecondaryActionSelectedIndex;

  /// Creates a NavPages widget.
  ///
  /// The [children] parameter is required and should contain the pages
  /// to be displayed. The [buttons] parameter should contain navigation
  /// buttons corresponding to each page.
  const NavPages({
    super.key,
    this.children = const [],
    this.direction = NavPagesDirection.vertical,
    this.navrailPosition = NavPagesRailPosition.left,
    this.buttons = const [],
    this.actions = const [],
    this.expandable = false,
    this.expanded = true,
    this.expandableButtonHeight = 40,
    this.navrailMinWidth = 0,
    this.navrailMaxWidth = 0,
    this.navrailMinHeight = 0,
    this.navrailMaxHeight = 0,
    this.navrailVerticleScrolling = false,
    this.navrailLeading,
    this.navrailSmallLeading,
    this.header,
    this.useFullHeader = false,
    this.footer,
    this.useFullFooter = false,
    this.navrailLeadingOnTop = false,
    this.fullscreen = false,
    this.showActionSelectedIndex = true,
    this.showSecondaryActionSelectedIndex = true,
  });

  @override
  State<NavPages> createState() => NavPagesState();

  /// Returns the [NavPagesState] associated with the nearest [NavPages] widget.
  ///
  /// This method is used to access the navigation state from descendant widgets.
  /// Throws a [FlutterError] if no [NavPages] widget is found in the widget tree.
  ///
  /// Example:
  /// ```dart
  /// final navPages = NavPages.of(context);
  /// navPages.push(AnotherPage());
  /// ```
  static NavPagesState of(BuildContext context) {
    NavPagesState? state = context.findAncestorStateOfType<NavPagesState>();

    assert(() {
      if (state == null) {
        throw FlutterError('NavPages not found in context');
      }
      return true;
    }());

    return state!;
  }

  /// Pops the current page from the navigation stack.
  ///
  /// This is equivalent to calling [NavPages.of(context).pop()].
  /// Does nothing if there are no pages to pop.
  ///
  /// Example:
  /// ```dart
  /// NavPages.pop(context);
  /// ```
  static void pop(BuildContext context) {
    of(context).pop();
  }

  /// Pushes a new page onto the navigation stack.
  ///
  /// This is equivalent to calling [NavPages.of(context).push(page)].
  /// The new page becomes the current page and can be popped later.
  ///
  /// Example:
  /// ```dart
  /// NavPages.push(context, AnotherPage());
  /// ```
  static void push(BuildContext context, Widget page) {
    of(context).push(page);
  }

  /// Returns whether the navigation stack can be popped.
  ///
  /// This is equivalent to calling [NavPages.of(context).canPop()].
  /// Returns true if there are pages in the stack that can be popped.
  ///
  /// Example:
  /// ```dart
  /// if (NavPages.canPop(context)) {
  ///   NavPages.pop(context);
  /// }
  /// ```
  static bool canPop(BuildContext context) {
    return of(context).canPop();
  }

  /// Replaces the current page with a new page.
  ///
  /// This is equivalent to calling [NavPages.of(context).pushReplacement(page)].
  /// Clears the navigation stack and sets the new page as the only page.
  ///
  /// Example:
  /// ```dart
  /// NavPages.pushReplacement(context, LoginPage());
  /// ```
  static void pushReplacement(BuildContext context, Widget page) {
    of(context).pushReplacement(page);
  }
}

/// The state class for [NavPages].
///
/// This class manages the navigation state, including the current page,
/// navigation history, and button interactions.
class NavPagesState extends State<NavPages> {
  int _selectedIndex = 0;
  int _selectedActionIndex = -1;
  List<NrButtonWidget> _buttons = [];
  List<NrButtonWidget> _actions = [];
  final List<Widget> _history = [];
  final List<Widget> _dynamicHistory = [];
  final GlobalKey<NavRailState> _navRailKey = GlobalKey();
  NavPagesDirection _direction = NavPagesDirection.vertical;
  NavPagesRailPosition _position = NavPagesRailPosition.left;
  bool _fullscreen = false;
  bool _headerFullscreen = false;
  bool _footerFullscreen = false;
  bool _showActionSelectedIndex = true;
  bool _showSecondaryActionSelectedIndex = true;

  @override
  void initState() {
    super.initState();
    _fullscreen = widget.fullscreen;
    _direction = widget.direction;
    _position = widget.navrailPosition;
    _headerFullscreen = widget.useFullHeader;
    _footerFullscreen = widget.useFullFooter;
    _showActionSelectedIndex = widget.showActionSelectedIndex;
    _showSecondaryActionSelectedIndex = widget.showSecondaryActionSelectedIndex;
    _buttons = widget.buttons.asMap().entries.map((entry) {
      return entry.value.copyWith(
        onTap: () {
          setState(() {
            _selectedIndex = entry.key;
          });
          pushReplacement(widget.children[entry.key]);
          entry.value.onTap?.call();
        },
      );
    }).toList();
    _actions = widget.actions.asMap().entries.map((entry) {
      return entry.value.copyWith(
        onTap: () {
          setState(() {
            _selectedActionIndex = entry.key;
          });
          entry.value.onTap?.call();
        },
      );
    }).toList();
    log('[initState] _history: $_history');
    _history.add(widget.children[_selectedIndex]);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isMobile = size.width < 768;
    NavPagesDirection direction = _direction;
    bool expanded = widget.expanded;
    if (isMobile) {
      direction = NavPagesDirection.horizontal;
      expanded = false;
    }

    if (_fullscreen) {
      return _history[_selectedIndex];
    }

    final navRail = NavRail(
      key: _navRailKey,
      direction: direction == NavPagesDirection.vertical
          ? NavRailDirection.vertical
          : NavRailDirection.horizontal,
      buttons: _buttons,
      actions: _actions,
      expandable: widget.expandable,
      expanded: expanded,
      expandableButtonHeight: widget.expandableButtonHeight,
      selectedActionIndex: _selectedActionIndex,
      showActionSelectedIndex: _showActionSelectedIndex,
      showSecondaryActionSelectedIndex: _showSecondaryActionSelectedIndex,
      minWidth: widget.navrailMinWidth,
      maxWidth: widget.navrailMaxWidth,
      minHeight: widget.navrailMinHeight,
      maxHeight: widget.navrailMaxHeight,
      verticleScrolling: widget.navrailVerticleScrolling,
      leading: widget.navrailLeading,
      smallLeading: widget.navrailSmallLeading,
      leadingOnTop: widget.navrailLeadingOnTop,
    );

    return direction == NavPagesDirection.vertical
        ? _headerFullscreen || _footerFullscreen
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ?widget.header,
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_position == NavPagesRailPosition.left ||
                              _position == NavPagesRailPosition.top)
                            navRail,
                          !_footerFullscreen
                              ? Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(child: _history[_selectedIndex]),
                                      ?widget.footer,
                                    ],
                                  ),
                                )
                              : Expanded(child: _history[_selectedIndex]),
                          if (_position == NavPagesRailPosition.right ||
                              _position == NavPagesRailPosition.bottom)
                            navRail,
                        ],
                      ),
                    ),
                    if (_footerFullscreen) ?widget.footer,
                  ],
                )
              : Row(
                  children: [
                    if (_position == NavPagesRailPosition.left ||
                        _position == NavPagesRailPosition.top)
                      navRail,
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ?widget.header,
                          Expanded(child: _history[_selectedIndex]),
                          ?widget.footer,
                        ],
                      ),
                    ),
                    if (_position == NavPagesRailPosition.right ||
                        _position == NavPagesRailPosition.bottom)
                      navRail,
                  ],
                )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_headerFullscreen) ?widget.header,
              if (_position == NavPagesRailPosition.left ||
                  _position == NavPagesRailPosition.top)
                navRail,
              if (!_headerFullscreen) ?widget.header,
              Expanded(child: _history[_selectedIndex]),
              if (!_footerFullscreen) ?widget.footer,
              if (_position == NavPagesRailPosition.right ||
                  _position == NavPagesRailPosition.bottom)
                navRail,
              if (_footerFullscreen) ?widget.footer,
            ],
          );
  }

  /// Sets the buttons for the navigation rail.
  ///
  /// The [buttons] parameter should be a list of [NrButtonWidget] widgets.
  void setButtons(List<NrButtonWidget> buttons) {
    setState(() {
      _buttons = buttons;
    });
  }

  /// Sets the actions for the navigation rail.
  ///
  /// The [actions] parameter should be a list of [NrButtonWidget] widgets.
  void setActions(List<NrButtonWidget> actions) {
    _navRailKey.currentState?.setActions(actions);
  }

  /// Sets the secondary actions for the navigation rail.
  ///
  /// The [actions] parameter should be a list of [NrButtonWidget] widgets.
  void setSecondaryActions(List<NrButtonWidget> actions) {
    _navRailKey.currentState?.setSecondaryActions(actions);
  }

  /// Sets the direction for the navigation pages.
  ///
  /// This method updates the direction for the navigation pages using
  /// the [NavPagesDirection] enum.
  ///
  /// The [direction] parameter should be a [NavPagesDirection] enum.
  void setDirection(NavPagesDirection direction) {
    setState(() {
      _direction = direction;
    });
  }

  /// Returns the [NavPagesDirection] for the navigation pages.
  NavPagesDirection get direction => _direction;

  /// Sets the position for the navigation pages.
  ///
  /// The [position] parameter should be a [NavPagesRailPosition] enum.
  void setPosition(NavPagesRailPosition position) {
    setState(() {
      _position = position;
      switch (position) {
        case NavPagesRailPosition.left:
          _direction = NavPagesDirection.vertical;
          break;
        case NavPagesRailPosition.right:
          _direction = NavPagesDirection.vertical;
          break;
        case NavPagesRailPosition.top:
          _direction = NavPagesDirection.horizontal;
          break;
        case NavPagesRailPosition.bottom:
          _direction = NavPagesDirection.horizontal;
          break;
      }
    });
  }

  /// Returns the [NavPagesRailPosition] for the navigation pages.
  NavPagesRailPosition get position => _position;

  /// Returns whether the navigation stack can be popped.
  ///
  /// Returns true if there are pages in the navigation history
  /// that can be popped (i.e., more than one page in the stack).
  bool canPop() {
    return _history.isNotEmpty && _history.length > 1;
  }

  /// Pops the current page from the navigation stack.
  ///
  /// Removes the last page from the navigation history and
  /// updates the selected index to the previous page.
  /// Does nothing if the history is empty.
  void pop() {
    if (_history.length <= 1) {
      return;
    }
    setState(() {
      _navRailKey.currentState?.setSecondaryActions([]);
      _history.removeLast();
      _selectedIndex = _history.length - 1;
      if (_dynamicHistory.length > 1) {
        _dynamicHistory.removeLast();
      } else if (_dynamicHistory.length == 1) {
        _dynamicHistory.clear();
        _fullscreen = false;
      }
    });
  }

  /// Pushes a new page onto the navigation stack.
  ///
  /// Adds the given [page] to the navigation history and
  /// updates the selected index to the new page.
  ///
  /// The [page] parameter should be a widget that represents
  /// the content to be displayed.
  void push(Widget page, {bool fullscreen = false}) {
    setState(() {
      if (_fullscreen || fullscreen) {
        _dynamicHistory.add(page);
        _fullscreen = true;
      }
      if (_dynamicHistory.isEmpty) {
        _fullscreen = false;
      }
      _navRailKey.currentState?.setSecondaryActions([]);
      _history.add(page);
      _selectedIndex = _history.length - 1;
    });
  }

  /// Replaces the current page with a new page.
  ///
  /// Clears the entire navigation history and sets the given
  /// [page] as the only page in the stack. This is useful
  /// for scenarios like login/logout where you want to reset
  /// the navigation state.
  void pushReplacement(Widget page, {bool fullscreen = false}) {
    setState(() {
      _dynamicHistory.clear();
      if (_fullscreen || fullscreen) {
        _dynamicHistory.add(page);
        _fullscreen = true;
      }
      if (_dynamicHistory.isEmpty) {
        _fullscreen = false;
      }
      _navRailKey.currentState?.setSecondaryActions([]);
      _history.clear();
      _history.add(page);
      _selectedIndex = _history.length - 1;
    });
  }

  /// Toggles the fullscreen mode.
  ///
  /// This method toggles the fullscreen mode and updates the navigation
  /// history accordingly.
  ///
  /// If the fullscreen mode is enabled, it removes the current page from
  /// the history and pushes a new page with fullscreen mode enabled.
  ///
  /// If the fullscreen mode is disabled, it removes the current page from
  /// the history and pushes a new page with fullscreen mode disabled.
  void toggleFullscreen() {
    !_fullscreen ? enterFullscreen() : exitFullscreen();
  }

  /// Enters the fullscreen mode.
  ///
  /// This method enters the fullscreen mode and updates the navigation
  /// history accordingly.
  ///
  /// It removes the current page from the history and pushes a new page
  /// with fullscreen mode enabled.
  void enterFullscreen() {
    if (_fullscreen) {
      return;
    }
    final page = _history[_selectedIndex];
    setState(() {
      _dynamicHistory.add(page);
      _fullscreen = true;
    });
  }

  /// Exits the fullscreen mode.
  ///
  /// This method exits the fullscreen mode and updates the navigation
  /// history accordingly.
  ///
  /// It removes the current page from the history and pushes a new page
  /// with fullscreen mode disabled.
  void exitFullscreen() {
    setState(() {
      _dynamicHistory.clear();
      _fullscreen = false;
    });
  }

  /// Returns the [bool]fullscreen state for the navigation pages..
  bool get fullscreen => _fullscreen;

  /// Toggles the header fullscreen mode.
  void toggleHeaderFullscreen() {
    _headerFullscreen ? disableHeaderFullscreen() : enableHeaderFullscreen();
  }

  /// Enables the header fullscreen mode.
  void enableHeaderFullscreen() {
    setState(() {
      _headerFullscreen = true;
    });
  }

  /// Disables the header fullscreen mode.
  void disableHeaderFullscreen() {
    setState(() {
      _headerFullscreen = false;
    });
  }

  /// Returns the [bool] header fullscreen state for the navigation pages.
  bool get headerFullscreen => _headerFullscreen;

  /// Toggles the footer fullscreen mode.
  void toggleFooterFullscreen() {
    _footerFullscreen ? disableFooterFullscreen() : enableFooterFullscreen();
  }

  /// Enables the footer fullscreen mode.
  void enableFooterFullscreen() {
    setState(() {
      _footerFullscreen = true;
    });
  }

  /// Disables the footer fullscreen mode.
  void disableFooterFullscreen() {
    setState(() {
      _footerFullscreen = false;
    });
  }

  /// Returns the [bool] footer fullscreen state for the navigation pages.
  bool get footerFullscreen => _footerFullscreen;

  /// Toggles the action selected index.
  void toggleActionSelectedIndex() {
    _showActionSelectedIndex
        ? disableActionSelectedIndex()
        : enableActionSelectedIndex();
  }

  /// Enables the action selected index.
  void enableActionSelectedIndex() {
    setState(() {
      _showActionSelectedIndex = true;
    });
  }

  /// Disables the action selected index.
  void disableActionSelectedIndex() {
    setState(() {
      _showActionSelectedIndex = false;
    });
  }

  /// Returns the [bool] action selected index state for the navigation pages.
  bool get showActionSelectedIndex => _showActionSelectedIndex;

  /// Toggles the secondary action selected index.
  void toggleSecondaryActionSelectedIndex() {
    _showSecondaryActionSelectedIndex
        ? disableSecondaryActionSelectedIndex()
        : enableSecondaryActionSelectedIndex();
  }

  /// Enables the secondary action selected index.
  void enableSecondaryActionSelectedIndex() {
    setState(() {
      _showSecondaryActionSelectedIndex = true;
    });
  }

  /// Disables the secondary action selected index.
  void disableSecondaryActionSelectedIndex() {
    setState(() {
      _showSecondaryActionSelectedIndex = false;
    });
  }

  /// Returns the [bool] secondary action selected index state for the navigation pages.
  bool get showSecondaryActionSelectedIndex =>
      _showSecondaryActionSelectedIndex;
}
