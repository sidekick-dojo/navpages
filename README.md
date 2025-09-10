# NavPages

A flexible Flutter package for creating responsive navigation pages with integrated navigation rails and sidebars. NavPages provides a complete solution for managing multiple pages with built-in navigation controls and responsive design.

![NavPages Demo](https://raw.githubusercontent.com/sidekick-dojo/navpages/main/demo.gif)

## Features

- **Multi-page Management**: Handle multiple pages internally with automatic state management
- **Responsive Navigation**: Provides Navigation Rail/Sidebar that adapts to screen size (vertical on desktop, horizontal on mobile)
- **Expandable Design**: Optional expandable navigation with customizable widths and heights
- **Navigation Controls**: Includes `.of(context)` method with Navigator-like methods (`pop`, `canPop`, `push`, `pushReplacement`) to control page history
- **Customizable Styling**: Full control over colors, dimensions, and visual appearance
- **Action Buttons**: Support for additional action buttons in the navigation rail
- **Mobile Optimization**: Automatic mobile layout with overflow handling and menu systems

## Getting Started

Add the package to your Flutter app:

```bash
dart pub add navpages
```

## Basic Usage

```dart
import 'package:flutter/material.dart';
import 'package:navpages/navpages.dart';

class SamplePage extends StatelessWidget {
  const SamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Hello, Pages!'),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NavPages Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        body: NavPages(
          buttons: [
            NavRailButton(
              label: 'Home',
              icon: Icons.home,
            ),
            NavRailButton(
              label: 'Settings',
              icon: Icons.settings,
            ),
          ],
          children: [
            NavPage(
              navbar: Navbar(title: 'Home'),
              child: const SamplePage(),
            ),
            NavPage(
              navbar: Navbar(title: 'Settings'),
              child: const SamplePage(),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}
```

## Advanced Usage

### Expandable Navigation

```dart
NavPages(
  expandable: true,
  expanded: true,
  buttons: [
    NavRailButton(label: 'Dashboard', icon: Icons.dashboard),
    NavRailButton(label: 'Analytics', icon: Icons.analytics),
    NavRailButton(label: 'Reports', icon: Icons.assessment),
  ],
  children: [
    NavPage(navbar: Navbar(title: 'Dashboard'), child: DashboardPage()),
    NavPage(navbar: Navbar(title: 'Analytics'), child: AnalyticsPage()),
    NavPage(navbar: Navbar(title: 'Reports'), child: ReportsPage()),
  ],
)
```

### With Action Buttons

```dart
NavPages(
  buttons: [
    NavRailButton(label: 'Home', icon: Icons.home),
    NavRailButton(label: 'Profile', icon: Icons.person),
  ],
  actions: [
    NavRailButton(label: 'Settings', icon: Icons.settings),
    NavRailButton(label: 'Help', icon: Icons.help),
  ],
  children: [
    NavPage(navbar: Navbar(title: 'Home'), child: HomePage()),
    NavPage(navbar: Navbar(title: 'Profile'), child: ProfilePage()),
  ],
)
```

### Custom Styling

```dart
NavPages(
  buttons: [
    NavRailButton(
      label: 'Custom',
      icon: Icons.star,
      selectedColor: Colors.amber,
      selectedBackgroundColor: Colors.amber.withOpacity(0.2),
    ),
  ],
  children: [
    NavPage(
      navbar: Navbar(
        title: 'Custom Page',
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      child: CustomPage(),
    ),
  ],
)
```

### Navigation Control

```dart
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              // Navigate to a new page
              NavPages.push(context, AnotherPage());
            },
            child: Text('Go to Another Page'),
          ),
          ElevatedButton(
            onPressed: () {
              // Check if we can go back
              if (NavPages.canPop(context)) {
                NavPages.pop(context);
              }
            },
            child: Text('Go Back'),
          ),
        ],
      ),
    );
  }
}
```

## API Reference

### NavPages

The main widget that manages multiple pages and navigation.

#### Properties

- `children` (List<NavPage>): List of pages to display
- `buttons` (List<NavRailButton>): Navigation buttons for the rail
- `actions` (List<NavRailButton>): Action buttons (optional)
- `direction` (NavPagesDirection): Layout direction (horizontal/vertical)
- `expandable` (bool): Whether the navigation can be expanded
- `expanded` (bool): Initial expanded state

#### Static Methods

- `NavPages.of(BuildContext context)`: Get the NavPagesState instance
- `NavPages.pop(BuildContext context)`: Pop the current page
- `NavPages.push(BuildContext context, Widget page)`: Push a new page
- `NavPages.canPop(BuildContext context)`: Check if navigation can pop
- `NavPages.pushReplacement(BuildContext context, Widget page)`: Replace current page

### NavPage

Represents a single page within the NavPages widget.

#### Properties

- `navbar` (Navbar?): Optional navigation bar for the page
- `child` (Widget?): The main content widget

### NavRailButton

A button component for the navigation rail.

#### Properties

- `label` (String?): Button label text
- `icon` (IconData?): Button icon
- `onTap` (Function()?): Tap callback
- `expanded` (bool): Whether the button is in expanded state
- `selected` (bool): Whether the button is selected
- `width` (double?): Custom width
- `height` (double?): Custom height
- `selectedColor` (Color?): Color when selected
- `selectedBackgroundColor` (Color?): Background color when selected
- `unselectedColor` (Color?): Color when not selected
- `unselectedBackgroundColor` (Color?): Background color when not selected
- `labelPosition` (NavRailButtonLabelPosition): Position of the label relative to icon

### Navbar

A customizable navigation bar widget.

#### Properties

- `title` (String): Title text
- `actions` (List<Widget>): Action widgets (optional)
- `backgroundColor` (Color?): Background color
- `foregroundColor` (Color?): Text and icon color
- `height` (double): Bar height

### NavRail

The navigation rail component (used internally by NavPages).

#### Properties

- `buttons` (List<NavRailButton>): Navigation buttons
- `actions` (List<NavRailButton>): Action buttons
- `direction` (NavRailDirection): Layout direction
- `expandable` (bool): Whether expandable
- `expanded` (bool): Expanded state
- `minWidth` (double): Minimum width
- `maxWidth` (double): Maximum width
- `minHeight` (double): Minimum height
- `maxHeight` (double): Maximum height
- `labelPosition` (NavRailButtonLabelPosition?): Label position
- Various color properties for customization

## Responsive Behavior

NavPages automatically adapts to different screen sizes:

- **Desktop/Tablet (>768px)**: Vertical navigation rail on the left
- **Mobile (<768px)**: Horizontal navigation bar at the top
- **Overflow handling**: Extra buttons are moved to a "More" menu on mobile
- **Action buttons**: Moved to a menu on mobile, displayed inline on desktop

## Customization

### Colors

All color properties support theme integration and can be customized:

```dart
NavPages(
  // Custom colors will be applied to NavRail
  children: [
    NavPage(
      navbar: Navbar(
        title: 'Custom',
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      child: MyPage(),
    ),
  ],
)
```

### Dimensions

Control the size of navigation elements:

```dart
NavRailButton(
  width: 60,
  height: 60,
  label: 'Custom Size',
  icon: Icons.star,
)
```

## Examples

Check out the `example/` directory for complete sample applications demonstrating various use cases.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Additional Information

For more information about this package, visit:
- [GitHub Repository](https://github.com/sidekick-dojo/navpages)
- [Pub.dev Package](https://pub.dev/packages/navpages)

To contribute to the package, file issues, or get support, please visit our GitHub repository.
