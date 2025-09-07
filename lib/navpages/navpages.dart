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
  final List<NavPage> children;

  /// The direction in which the navigation is laid out.
  ///
  /// Defaults to [NavPagesDirection.vertical] for desktop layouts.
  /// Automatically switches to horizontal on mobile devices.
  final NavPagesDirection direction;

  /// The navigation buttons for the rail.
  ///
  /// These buttons control which page is displayed. Each button
  /// corresponds to a page in the [children] list.
  final List<NavRailButton> buttons;

  /// Additional action buttons for the navigation rail.
  ///
  /// These buttons are typically used for secondary actions like
  /// settings, help, or logout. They don't control page navigation.
  final List<NavRailButton> actions;

  /// Whether the navigation rail can be expanded/collapsed.
  ///
  /// When true, shows an expand/collapse button that allows users
  /// to toggle between compact and expanded views.
  final bool expandable;

  /// The initial expanded state of the navigation rail.
  ///
  /// Only applies when [expandable] is true.
  final bool expanded;

  /// Creates a NavPages widget.
  ///
  /// The [children] parameter is required and should contain the pages
  /// to be displayed. The [buttons] parameter should contain navigation
  /// buttons corresponding to each page.
  const NavPages({
    super.key,
    this.children = const [],
    this.direction = NavPagesDirection.vertical,
    this.buttons = const [],
    this.actions = const [],
    this.expandable = false,
    this.expanded = true,
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
  final List<NavRailButton> _buttons = [];
  final List<NavRailButton> _actions = [];
  final List<Widget> _history = [];

  @override
  void initState() {
    super.initState();
    _buttons.addAll(
      widget.buttons.asMap().entries.map((entry) {
        return entry.value.copyWith(
          onTap: () {
            setState(() {
              _selectedIndex = entry.key;
            });
            pushReplacement(widget.children[entry.key].child!);
            entry.value.onTap?.call();
          },
        );
      }),
    );
    _actions.addAll(
      widget.actions.asMap().entries.map((entry) {
        return entry.value.copyWith(
          onTap: () {
            setState(() {
              _selectedActionIndex = entry.key;
            });
            entry.value.onTap?.call();
          },
        );
      }),
    );
    _history.add(widget.children[_selectedIndex].child!);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isMobile = size.width < 768;
    NavPagesDirection direction = widget.direction;
    bool expanded = widget.expanded;
    if (isMobile) {
      direction = NavPagesDirection.horizontal;
      expanded = false;
    }

    return direction == NavPagesDirection.vertical
        ? Row(
            children: [
              NavRail(
                direction: NavRailDirection.vertical,
                buttons: _buttons,
                expandable: widget.expandable,
                expanded: expanded,
                actions: _actions,
                selectedActionIndex: _selectedActionIndex,
              ),
              Expanded(child: _history[_selectedIndex]),
            ],
          )
        : Column(
            children: [
              NavRail(
                direction: NavRailDirection.horizontal,
                buttons: _buttons,
                expandable: widget.expandable,
                expanded: expanded,
                actions: _actions,
                selectedActionIndex: _selectedActionIndex,
              ),
              Expanded(child: _history[_selectedIndex]),
            ],
          );
  }

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
    if (_history.isEmpty) {
      return;
    }
    setState(() {
      _history.removeLast();
      _selectedIndex = _history.length - 1;
    });
  }

  /// Pushes a new page onto the navigation stack.
  ///
  /// Adds the given [page] to the navigation history and
  /// updates the selected index to the new page.
  ///
  /// The [page] parameter should be a widget that represents
  /// the content to be displayed.
  void push(Widget page) {
    setState(() {
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
  void pushReplacement(Widget page) {
    setState(() {
      _history.clear();
      _history.add(page);
      _selectedIndex = _history.length - 1;
    });
  }
}
