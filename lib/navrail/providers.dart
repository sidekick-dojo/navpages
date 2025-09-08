import 'package:riverpod/riverpod.dart';

import 'navrail_button.dart';

/// A [Notifier] that manages the list of navigation rail buttons.
///
/// This provider is responsible for holding and updating the list of
/// [NavRailButton]s that are displayed in the navigation rail. It exposes
/// a method [setButtons] to update the list of buttons, which notifies
/// listeners of any changes.
///
/// Usage:
/// ```dart
/// ref.read(navRailButtonsProvider.notifier).setButtons(newButtonsList);
/// ```
class NavRailButtonsProvider extends Notifier<List<NavRailButton>> {
  @override
  List<NavRailButton> build() {
    return [];
  }

  /// Sets the list of navigation rail buttons.
  ///
  /// This method updates the state with the provided [buttons] list,
  /// triggering a rebuild for any listeners.
  void setButtons(List<NavRailButton> buttons) {
    state = buttons;
  }
}

/// A [NotifierProvider] for [NavRailButtonsProvider].
///
/// Provides access to the current list of navigation rail buttons and
/// allows updating them via the notifier.
final navRailButtonsProvider =
    NotifierProvider<NavRailButtonsProvider, List<NavRailButton>>(
      () => NavRailButtonsProvider(),
    );

/// A [Notifier] that manages the list of navigation rail action buttons.
///
/// This provider is responsible for holding and updating the list of
/// [NavRailButton]s that are used as actions (typically secondary actions)
/// in the navigation rail. It exposes a method [setActions] to update
/// the list of action buttons.
///
/// Usage:
/// ```dart
/// ref.read(navRailActionsProvider.notifier).setActions(newActionsList);
/// ```
class NavRailActionsProvider extends Notifier<List<NavRailButton>> {
  @override
  List<NavRailButton> build() {
    return [];
  }

  /// Sets the list of navigation rail action buttons.
  ///
  /// This method updates the state with the provided [actions] list,
  /// triggering a rebuild for any listeners.
  void setActions(List<NavRailButton> actions) {
    state = actions;
  }
}

/// A [NotifierProvider] for [NavRailActionsProvider].
///
/// Provides access to the current list of navigation rail action buttons and
/// allows updating them via the notifier.
final navRailActionsProvider =
    NotifierProvider<NavRailActionsProvider, List<NavRailButton>>(
      () => NavRailActionsProvider(),
    );
