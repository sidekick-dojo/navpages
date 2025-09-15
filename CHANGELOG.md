# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.5.1] - 2025-09-15

### Fixed
- Fixed navbar direction regression for mobile responses

## [1.5.0] - 2025-09-15

### Added
- Position NavRail to `top`, `bottom`, `left`, `right` for NavPages
- Dynamically set the NavRail position for NavPages
- Support for `footer` inclusion for NavPages
- `useFullFooter` to push the footer below the NavRail for NavPages
- Dynamically enable, disable, or toggle `useFullHeader` for NavPages
- Dynamically enable, disable, or toggle `useFullFooter` for NavPages
- Support for showing or hiding the selected action for NavRail, via NavPages or directly
- Support for showing or hiding the selected secondary action for NavRail, via NavPages or directly
- Dynamically enable, disable, or toggle `showActionSelectionIndex` for NavPages
- Dynamically enable, disable, or toggle `showSecondaryActionSelectedIndex` for NavPages

### Fixed
- Simplified the build layout logic for NavPages
- Support to get `fullscreen` status for NavPages
- Secondary actions no longer display selected when equal to the selected action index
- Layout bug where NavPage was not properly sized

## [1.4.1] - 2025-09-12

### Updated
- Updated demo gif with new features

## [1.4.0] - 2025-09-12

### Added
- Support for NavPages `pop`, `push`, and `pushReplacement` now support total fullscreen mode when toggled

### Fixed
- `NavPages.pop()` no longer exits fullscreen mode by default

## [1.3.11] - 2025-09-12

### Added
- Fullscreen mode to remove chrome frame around page
- Toggle Fullscreen mode
- Support plain widgets for NavPages children

## [1.3.0] - 2025-09-10

### Added
- Added NrButtonWidget class for custom buttons
- NavRailButton now extends NrButtonWidget

### Fixed
- Removed errant selected secondary action

## [1.2.12] - 2025-09-10
- Removed dead code branch

## [1.2.11] - 2025-09-10

### Fixed
- Exapandable Button Height, to work in horizontal direction

## [1.2.10] - 2025-09-10

### Added
- Exapandable Button Height, to better match navbar height as needed

## [1.2.9] - 2025-09-10

### Fixed
- Centering issue with horizontal expanded buttons

## [1.2.8] - 2025-09-10

### Fixed
- Buttons overflow bug when in horizontal mode

## [1.2.7] - 2025-09-10
- Updated demo gif for documentation

## [1.2.6] - 2025-09-10

### Added
- Added the ability to move the leading above or below the collapse button

## [1.2.5] - 2025-09-10

### Added
- Added Leading for expanded NavRail state
- Added Small Leading for collapsed NavRail state
- Added Header for NavPages
- Added ability to have Header across the full top

## [1.2.4] - 2025-09-10
- Removed any reference to Riverpod

## [1.2.3] - 2025-09-10
- Updated documentation

## [1.2.2] - 2025-09-10
- Cleaned up nav buttons look and feel

## [1.2.1] - 2025-09-10
- Removed 'Collapse' keyword in favor of tooltip
- Added setSecondary function to NavRail
- Improved design around secondary actions on NavRail

## [1.2.0] - 2025-09-09

### Fixed
- Remove Riverpod
- Add temporary actions
- Use global keys for adding temporary actions
- Fix Expandable bug


## [1.1.2] - 2025-09-08
- Remove actions on push
- Remove actions on pushReplace

## [1.1.1] - 2025-09-08
- Added capability to set navrail minWidth
- Added capability to set navrail maxWidth
- Added capability to set navrail minHeight
- Added capability to set navrail maxHeight

## [1.1.0] - 2025-09-08
- Added ability to set buttons from the `NavPages.of(context)`
- Added ability to set actions from the `NavPages.of(context)`

## [1.0.1] - 2025-09-07

### Fixed
- Fixed number of items in horizontal mode for tablets

## [1.0.0] - 2025-09-07

### Added
- Initial release of NavPages package
- **NavPages** - Main widget for managing multiple pages with integrated navigation
- **NavPage** - Individual page widget with optional navigation bar
- **NavRailButton** - Customizable button component for navigation rails
- **NavRail** - Navigation rail component with expandable support
- **Navbar** - Customizable navigation bar with back button integration
- **Responsive Design** - Automatic adaptation between desktop and mobile layouts
- **Navigation Controls** - Navigator-like methods (`push`, `pop`, `canPop`, `pushReplacement`)
- **Expandable Navigation** - Collapsible navigation rail with customizable dimensions
- **Action Buttons** - Support for secondary actions in navigation rail
- **Mobile Optimization** - Overflow handling and menu systems for mobile devices
- **Theme Integration** - Full Material Design theme support
- **Customizable Styling** - Complete control over colors, dimensions, and appearance
- **Example Application** - Complete sample app demonstrating all features
- **Comprehensive Documentation** - Full API reference and usage examples
- **Dartdoc Comments** - Complete documentation for all classes and methods

### Features
- Multi-page management with automatic state handling
- Responsive navigation that adapts to screen size
- Expandable/collapsible navigation rail
- Programmatic navigation control
- Customizable colors and styling
- Mobile-optimized layout with overflow handling
- Action buttons for secondary functionality
- Integration with Flutter's navigation system
- Material Design 3 support
- Comprehensive example application

### Technical Details
- Built with Flutter SDK ^3.9.0
- Supports Flutter >=1.17.0
- Uses Material Design 3 components
- Responsive breakpoint at 768px width
- Automatic mobile/desktop layout switching
- State management with built-in navigation history
- Theme-aware color system
- Customizable dimensions and styling
