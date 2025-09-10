# NavPages

A flexible Flutter package for creating responsive navigation pages with integrated navigation rails and sidebars. NavPages provides a complete solution for managing multiple pages with built-in navigation controls and responsive design.

![NavPages Demo](https://raw.githubusercontent.com/sidekick-dojo/navpages/main/demo.gif)

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Basic Usage](#basic-usage)
- [Advanced Usage](#advanced-usage)
- [API Reference](#api-reference)
- [Responsive Behavior](#responsive-behavior)
- [Customization](#customization)
- [Performance](#performance)
- [Troubleshooting](#troubleshooting)
- [Migration Guide](#migration-guide)
- [Examples](#examples)
- [Contributing](#contributing)
- [License](#license)

## Features

- **🎯 Multi-page Management**: Handle multiple pages internally with automatic state management and seamless transitions
- **📱 Responsive Navigation**: Provides Navigation Rail/Sidebar that automatically adapts to screen size (vertical on desktop, horizontal on mobile)
- **🔧 Expandable Design**: Optional expandable navigation with customizable widths and heights for better space utilization
- **🧭 Navigation Controls**: Includes `.of(context)` method with Navigator-like methods (`pop`, `canPop`, `push`, `pushReplacement`) to control page history
- **🎨 Customizable Styling**: Full control over colors, dimensions, and visual appearance with theme integration
- **⚡ Action Buttons**: Support for additional action buttons in the navigation rail with flexible positioning
- **📲 Mobile Optimization**: Automatic mobile layout with overflow handling and intuitive menu systems
- **♿ Accessibility**: Full accessibility support with proper semantic labels and keyboard navigation
- **🎛️ Leading Widgets**: Support for custom leading widgets in both expanded and collapsed navigation states with flexible positioning
- **📋 Header Support**: Optional header widget that can span the full width or be positioned above content
- **📜 Scrollable Navigation**: Optional vertical scrolling for navigation rails with many items
- **🔄 Secondary Actions**: Dynamic secondary action buttons that can be set programmatically

## Installation

Add NavPages to your `pubspec.yaml` file:

```yaml
dependencies:
  navpages: ^1.2.5
```

Then run:

```bash
flutter pub get
```

### Requirements

- Flutter SDK: `>=1.17.0`
- Dart SDK: `^3.9.0`

## Quick Start

Create a simple multi-page app with navigation in just a few steps:

```dart
import 'package:flutter/material.dart';
import 'package:navpages/navpages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NavPages Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NavPages(
        // Define navigation buttons
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
        // Define corresponding pages
        children: [
          NavPage(
            navbar: Navbar(title: 'Home'),
            child: const HomeContent(),
          ),
          NavPage(
            navbar: Navbar(title: 'Settings'),
            child: const SettingsContent(),
          ),
        ],
      ),
    );
  }
}

// Sample page content
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.home, size: 64, color: Colors.deepPurple),
          SizedBox(height: 16),
          Text(
            'Welcome to Home!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('This is your home page content.'),
        ],
      ),
    );
  }
}

class SettingsContent extends StatelessWidget {
  const SettingsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.settings, size: 64, color: Colors.deepPurple),
          SizedBox(height: 16),
          Text(
            'Settings',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Configure your app settings here.'),
        ],
      ),
    );
  }
}
```

## Basic Usage

The basic usage section above shows the simplest way to get started. Here are some additional patterns you might find useful:

### Minimal Setup

For the simplest possible setup, you can omit the navbar:

```dart
NavPages(
  buttons: [
    NavRailButton(label: 'Page 1', icon: Icons.pageview),
    NavRailButton(label: 'Page 2', icon: Icons.pages),
  ],
  children: [
    NavPage(child: const Text('Page 1 Content')),
    NavPage(child: const Text('Page 2 Content')),
  ],
)
```

### With Custom Callbacks

You can add custom tap handlers to navigation buttons:

```dart
NavPages(
  buttons: [
    NavRailButton(
      label: 'Home',
      icon: Icons.home,
      onTap: () {
        // Custom logic when home button is tapped
        print('Home button tapped!');
      },
    ),
  ],
  children: [
    NavPage(child: const HomePage()),
  ],
)
```

## Advanced Usage

### Expandable Navigation

Create a collapsible navigation rail that saves space on smaller screens:

```dart
NavPages(
  expandable: true,        // Enable expandable functionality
  expanded: true,          // Start in expanded state
  buttons: [
    NavRailButton(label: 'Dashboard', icon: Icons.dashboard),
    NavRailButton(label: 'Analytics', icon: Icons.analytics),
    NavRailButton(label: 'Reports', icon: Icons.assessment),
    NavRailButton(label: 'Users', icon: Icons.people),
  ],
  children: [
    NavPage(
      navbar: Navbar(title: 'Dashboard'),
      child: const DashboardPage(),
    ),
    NavPage(
      navbar: Navbar(title: 'Analytics'),
      child: const AnalyticsPage(),
    ),
    NavPage(
      navbar: Navbar(title: 'Reports'),
      child: const ReportsPage(),
    ),
    NavPage(
      navbar: Navbar(title: 'Users'),
      child: const UsersPage(),
    ),
  ],
)
```

**Benefits of Expandable Navigation:**
- Saves horizontal space when collapsed
- Shows labels when expanded for better UX
- Automatically handles mobile layouts

### With Action Buttons

Separate primary navigation from secondary actions:

```dart
NavPages(
  // Primary navigation buttons
  buttons: [
    NavRailButton(label: 'Home', icon: Icons.home),
    NavRailButton(label: 'Profile', icon: Icons.person),
    NavRailButton(label: 'Messages', icon: Icons.message),
  ],
  // Secondary action buttons (appear at bottom on desktop, in menu on mobile)
  actions: [
    NavRailButton(label: 'Settings', icon: Icons.settings),
    NavRailButton(label: 'Help', icon: Icons.help),
    NavRailButton(label: 'Logout', icon: Icons.logout),
  ],
  children: [
    NavPage(navbar: Navbar(title: 'Home'), child: const HomePage()),
    NavPage(navbar: Navbar(title: 'Profile'), child: const ProfilePage()),
    NavPage(navbar: Navbar(title: 'Messages'), child: const MessagesPage()),
  ],
)
```

### Dynamic Secondary Actions

Secondary actions can be dynamically updated using the `setSecondaryActions()` method. These actions are temporary and are automatically cleared when navigating between pages:

```dart
class DynamicSecondaryActions extends StatefulWidget {
  const DynamicSecondaryActions({super.key});

  @override
  State<DynamicSecondaryActions> createState() => _DynamicSecondaryActionsState();
}

class _DynamicSecondaryActionsState extends State<DynamicSecondaryActions> {
  @override
  Widget build(BuildContext context) {
    return NavPages(
      buttons: [
        NavRailButton(label: 'Dashboard', icon: Icons.dashboard),
        NavRailButton(label: 'Analytics', icon: Icons.analytics),
      ],
      children: [
        NavPage(
          navbar: Navbar(title: 'Dashboard'),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  // Add context-specific secondary actions
                  NavPages.of(context).setSecondaryActions([
                    NavRailButton(
                      label: 'Export Data',
                      icon: Icons.download,
                      onTap: () => _exportData(),
                    ),
                    NavRailButton(
                      label: 'Refresh',
                      icon: Icons.refresh,
                      onTap: () => _refreshData(),
                    ),
                  ]);
                },
                child: Text('Add Dashboard Actions'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Clear secondary actions
                  NavPages.of(context).setSecondaryActions([]);
                },
                child: Text('Clear Actions'),
              ),
            ],
          ),
        ),
        NavPage(
          navbar: Navbar(title: 'Analytics'),
          child: ElevatedButton(
            onPressed: () {
              // Different actions for analytics page
              NavPages.of(context).setSecondaryActions([
                NavRailButton(
                  label: 'Generate Report',
                  icon: Icons.assessment,
                  onTap: () => _generateReport(),
                ),
                NavRailButton(
                  label: 'Share',
                  icon: Icons.share,
                  onTap: () => _shareReport(),
                ),
              ]);
            },
            child: Text('Add Analytics Actions'),
          ),
        ),
      ],
    );
  }

  void _exportData() {
    // Export data logic
  }

  void _refreshData() {
    // Refresh data logic
  }

  void _generateReport() {
    // Generate report logic
  }

  void _shareReport() {
    // Share report logic
  }
}
```

**Key Points about Secondary Actions:**
- Secondary actions are temporary and context-specific
- They are automatically cleared when navigating between pages
- Use them for page-specific actions that don't belong in the main navigation
- They appear at the bottom of the navigation rail on desktop and in the actions menu on mobile

### Custom Styling

Customize colors, dimensions, and appearance:

```dart
NavPages(
  buttons: [
    NavRailButton(
      label: 'Custom',
      icon: Icons.star,
      // Custom colors for selected state
      selectedColor: Colors.amber,
      selectedBackgroundColor: Colors.amber.withOpacity(0.2),
      // Custom colors for unselected state
      unselectedColor: Colors.grey,
      unselectedBackgroundColor: Colors.transparent,
      // Custom dimensions
      width: 80,
      height: 60,
    ),
  ],
  children: [
    NavPage(
      navbar: Navbar(
        title: 'Custom Page',
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        height: 80, // Custom navbar height
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      child: const CustomPage(),
    ),
  ],
)
```

### Navigation Control

Programmatically control navigation between pages:

```dart
class NavigationExample extends StatelessWidget {
  const NavigationExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              // Push a new page onto the stack
              NavPages.push(context, const DetailPage());
            },
            child: const Text('Go to Detail Page'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Replace current page with a new one
              NavPages.pushReplacement(context, const ReplacementPage());
            },
            child: const Text('Replace Current Page'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Check if we can go back before popping
              if (NavPages.canPop(context)) {
                NavPages.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Cannot go back')),
                );
              }
            },
            child: const Text('Go Back'),
          ),
        ],
      ),
    );
  }
}
```

### Dynamic Navigation

Create navigation that responds to user interactions:

```dart
class DynamicNavigationExample extends StatefulWidget {
  const DynamicNavigationExample({super.key});

  @override
  State<DynamicNavigationExample> createState() => _DynamicNavigationExampleState();
}

class _DynamicNavigationExampleState extends State<DynamicNavigationExample> {
  int _currentIndex = 0;
  final List<String> _tabs = ['Home', 'Profile', 'Settings'];

  @override
  Widget build(BuildContext context) {
    return NavPages(
      buttons: _tabs.asMap().entries.map((entry) {
        int index = entry.key;
        String label = entry.value;
        return NavRailButton(
          label: label,
          icon: _getIconForTab(label),
          selected: index == _currentIndex,
          onTap: () {
            setState(() {
              _currentIndex = index;
            });
          },
        );
      }).toList(),
      children: _tabs.map((tab) {
        return NavPage(
          navbar: Navbar(title: tab),
          child: _buildTabContent(tab),
        );
      }).toList(),
    );
  }

  IconData _getIconForTab(String tab) {
    switch (tab) {
      case 'Home': return Icons.home;
      case 'Profile': return Icons.person;
      case 'Settings': return Icons.settings;
      default: return Icons.help;
    }
  }

  Widget _buildTabContent(String tab) {
    return Center(
      child: Text('Content for $tab'),
    );
  }
}
```

### With Leading Widgets and Header

Add custom leading widgets and headers to enhance your navigation:

```dart
NavPages(
  // Custom leading widgets for different states
  navrailLeading: Container(
    padding: const EdgeInsets.all(8),
    child: Column(
      children: [
        Icon(Icons.business, size: 32),
        Text('My App', style: TextStyle(fontSize: 12)),
      ],
    ),
  ),
  navrailSmallLeading: Container(
    padding: const EdgeInsets.all(8),
    child: Icon(Icons.business, size: 24),
  ),
  
  // Optional header widget
  header: Container(
    height: 60,
    color: Colors.blue,
    child: Row(
      children: [
        Icon(Icons.notifications, color: Colors.white),
        Spacer(),
        Text('Welcome to My App', style: TextStyle(color: Colors.white)),
        Spacer(),
        Icon(Icons.account_circle, color: Colors.white),
      ],
    ),
  ),
  
  // Use full header (spans above navigation rail)
  useFullHeader: true,
  
  buttons: [
    NavRailButton(label: 'Dashboard', icon: Icons.dashboard),
    NavRailButton(label: 'Analytics', icon: Icons.analytics),
    NavRailButton(label: 'Reports', icon: Icons.assessment),
  ],
  children: [
    NavPage(child: const DashboardPage()),
    NavPage(child: const AnalyticsPage()),
    NavPage(child: const ReportsPage()),
  ],
)
```

### Leading Widget Positioning

Control where leading widgets appear in the navigation rail:

```dart
// Leading widgets at the top (default: false)
NavPages(
  navrailLeadingOnTop: true,  // Leading widgets appear at the top
  navrailLeading: Container(
    padding: const EdgeInsets.all(8),
    child: Column(
      children: [
        Icon(Icons.business, size: 32),
        Text('My App', style: TextStyle(fontSize: 12)),
      ],
    ),
  ),
  navrailSmallLeading: Container(
    padding: const EdgeInsets.all(8),
    child: Icon(Icons.business, size: 24),
  ),
  buttons: [
    NavRailButton(label: 'Home', icon: Icons.home),
    NavRailButton(label: 'Profile', icon: Icons.person),
  ],
  children: [
    NavPage(child: const HomePage()),
    NavPage(child: const ProfilePage()),
  ],
)

// Leading widgets after expand/collapse button (default: false)
NavPages(
  navrailLeadingOnTop: false,  // Leading widgets appear after expand button
  navrailLeading: Container(
    padding: const EdgeInsets.all(8),
    child: Column(
      children: [
        Icon(Icons.business, size: 32),
        Text('My App', style: TextStyle(fontSize: 12)),
      ],
    ),
  ),
  navrailSmallLeading: Container(
    padding: const EdgeInsets.all(8),
    child: Icon(Icons.business, size: 24),
  ),
  expandable: true,  // Must be true to see the difference
  buttons: [
    NavRailButton(label: 'Home', icon: Icons.home),
    NavRailButton(label: 'Profile', icon: Icons.person),
  ],
  children: [
    NavPage(child: const HomePage()),
    NavPage(child: const ProfilePage()),
  ],
)
```

**Layout Order with `leadingOnTop: true`:**
1. Leading widget (expanded/collapsed)
2. Expand/collapse button
3. Navigation buttons
4. Action buttons

**Layout Order with `leadingOnTop: false` (default):**
1. Expand/collapse button
2. Leading widget (expanded/collapsed)
3. Navigation buttons
4. Action buttons

### With Scrollable Navigation

Enable vertical scrolling for navigation rails with many items:

```dart
NavPages(
  // Enable vertical scrolling
  navrailVerticleScrolling: true,
  
  // Many navigation buttons
  buttons: List.generate(20, (index) {
    return NavRailButton(
      label: 'Page ${index + 1}',
      icon: Icons.pageview,
    );
  }),
  
  children: List.generate(20, (index) {
    return NavPage(
      navbar: Navbar(title: 'Page ${index + 1}'),
      child: Center(child: Text('Content for Page ${index + 1}')),
    );
  }),
)
```

### Dynamic Secondary Actions

Use secondary actions that can be updated programmatically:

```dart
class SecondaryActionsExample extends StatefulWidget {
  const SecondaryActionsExample({super.key});

  @override
  State<SecondaryActionsExample> createState() => _SecondaryActionsExampleState();
}

class _SecondaryActionsExampleState extends State<SecondaryActionsExample> {
  @override
  Widget build(BuildContext context) {
    return NavPages(
      buttons: [
        NavRailButton(label: 'Home', icon: Icons.home),
        NavRailButton(label: 'Profile', icon: Icons.person),
      ],
      children: [
        NavPage(
          navbar: Navbar(title: 'Home'),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  // Add secondary actions dynamically
                  NavPages.of(context).setSecondaryActions([
                    NavRailButton(
                      label: 'Quick Action 1',
                      icon: Icons.star,
                      onTap: () => print('Quick Action 1'),
                    ),
                    NavRailButton(
                      label: 'Quick Action 2',
                      icon: Icons.favorite,
                      onTap: () => print('Quick Action 2'),
                    ),
                  ]);
                },
                child: Text('Add Secondary Actions'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Clear secondary actions
                  NavPages.of(context).setSecondaryActions([]);
                },
                child: Text('Clear Secondary Actions'),
              ),
            ],
          ),
        ),
        NavPage(child: const ProfilePage()),
      ],
    );
  }
}
```

## API Reference

### NavPages

The main widget that manages multiple pages and navigation. This is the core component that orchestrates the entire navigation system.

#### Constructor Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `children` | `List<NavPage>` | `[]` | List of pages to display. Each page corresponds to a navigation button |
| `buttons` | `List<NavRailButton>` | `[]` | Navigation buttons for the rail. Must match the order of `children` |
| `actions` | `List<NavRailButton>?` | `null` | Optional action buttons (appear at bottom on desktop, in menu on mobile) |
| `direction` | `NavPagesDirection` | `NavPagesDirection.vertical` | Layout direction (horizontal/vertical) |
| `expandable` | `bool` | `false` | Whether the navigation can be expanded/collapsed |
| `expanded` | `bool` | `false` | Initial expanded state (only applies when `expandable` is true) |
| `navrailMinWidth` | `double` | `0` | Minimum width of the navigation rail |
| `navrailMaxWidth` | `double` | `0` | Maximum width of the navigation rail |
| `navrailMinHeight` | `double` | `0` | Minimum height of the navigation rail |
| `navrailMaxHeight` | `double` | `0` | Maximum height of the navigation rail |
| `navrailVerticleScrolling` | `bool` | `false` | Whether the navigation rail can be scrolled vertically |
| `navrailLeading` | `Widget?` | `null` | Leading widget for expanded navigation rail state |
| `navrailSmallLeading` | `Widget?` | `null` | Leading widget for collapsed navigation rail state |
| `navrailLeadingOnTop` | `bool` | `false` | Whether leading widgets appear at the top of the navigation rail |
| `header` | `Widget?` | `null` | Optional header widget for the site |
| `useFullHeader` | `bool` | `false` | Whether to use full header when direction is vertical |

#### Static Methods

| Method | Description | Parameters | Returns |
|--------|-------------|------------|---------|
| `NavPages.of(BuildContext context)` | Get the NavPagesState instance for the current context | `context` - BuildContext | `NavPagesState?` |
| `NavPages.pop(BuildContext context)` | Pop the current page from the navigation stack | `context` - BuildContext | `void` |
| `NavPages.push(BuildContext context, Widget page)` | Push a new page onto the navigation stack | `context` - BuildContext<br>`page` - Widget to push | `void` |
| `NavPages.canPop(BuildContext context)` | Check if navigation can pop (has previous pages) | `context` - BuildContext | `bool` |
| `NavPages.pushReplacement(BuildContext context, Widget page)` | Replace current page with a new one | `context` - BuildContext<br>`page` - Widget to replace with | `void` |

#### NavPagesState Methods

| Method | Description | Parameters | Returns |
|--------|-------------|------------|---------|
| `setButtons(List<NavRailButton> buttons)` | Update navigation buttons dynamically | `buttons` - List of NavRailButton widgets | `void` |
| `setActions(List<NavRailButton> actions)` | Update action buttons dynamically | `actions` - List of NavRailButton widgets | `void` |
| `setSecondaryActions(List<NavRailButton> actions)` | Set secondary action buttons dynamically | `actions` - List of NavRailButton widgets | `void` |
| `setDirection(NavPagesDirection direction)` | Change navigation direction | `direction` - NavPagesDirection enum | `void` |
| `push(Widget page)` | Push a new page onto the stack | `page` - Widget to push | `void` |
| `pop()` | Pop current page from stack | None | `void` |
| `canPop()` | Check if navigation can pop | None | `bool` |
| `pushReplacement(Widget page)` | Replace current page | `page` - Widget to replace with | `void` |

#### Example Usage

```dart
// Basic usage
NavPages(
  buttons: [
    NavRailButton(label: 'Home', icon: Icons.home),
    NavRailButton(label: 'Profile', icon: Icons.person),
  ],
  children: [
    NavPage(child: const HomePage()),
    NavPage(child: const ProfilePage()),
  ],
)

// With expandable navigation
NavPages(
  expandable: true,
  expanded: true,
  buttons: [/* ... */],
  children: [/* ... */],
)

// Programmatic navigation
void navigateToDetail(BuildContext context) {
  NavPages.push(context, const DetailPage());
}

void goBack(BuildContext context) {
  if (NavPages.canPop(context)) {
    NavPages.pop(context);
  }
}
```

### NavPage

Represents a single page within the NavPages widget. Each NavPage corresponds to one navigation button.

#### Constructor Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `navbar` | `Navbar?` | `null` | Optional navigation bar for the page |
| `child` | `Widget?` | `null` | The main content widget for this page |
| `key` | `Key?` | `null` | Widget key for identification |

#### Example Usage

```dart
// Simple page without navbar
NavPage(
  child: const Center(
    child: Text('Simple Page Content'),
  ),
)

// Page with navbar
NavPage(
  navbar: Navbar(
    title: 'My Page',
    actions: [
      IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () {},
      ),
    ],
  ),
  child: const MyPageContent(),
)
```

### NavRailButton

A button component for the navigation rail. Provides customizable appearance and behavior.

#### Constructor Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `label` | `String?` | `null` | Button label text (shown when expanded) |
| `icon` | `IconData?` | `null` | Button icon |
| `onTap` | `Function()?` | `null` | Tap callback function |
| `expanded` | `bool` | `false` | Whether the button is in expanded state |
| `selected` | `bool` | `false` | Whether the button is currently selected |
| `width` | `double?` | `null` | Custom width override |
| `height` | `double?` | `null` | Custom height override |
| `selectedColor` | `Color?` | `null` | Color when selected (uses theme if null) |
| `selectedBackgroundColor` | `Color?` | `null` | Background color when selected |
| `unselectedColor` | `Color?` | `null` | Color when not selected (uses theme if null) |
| `unselectedBackgroundColor` | `Color?` | `null` | Background color when not selected |
| `labelPosition` | `NavRailButtonLabelPosition` | `NavRailButtonLabelPosition.right` | Position of label relative to icon |

#### Example Usage

```dart
// Basic button
NavRailButton(
  label: 'Home',
  icon: Icons.home,
)

// Custom styled button
NavRailButton(
  label: 'Custom',
  icon: Icons.star,
  selectedColor: Colors.amber,
  selectedBackgroundColor: Colors.amber.withOpacity(0.2),
  width: 80,
  height: 60,
  onTap: () {
    print('Custom button tapped!');
  },
)

// Button with custom label position
NavRailButton(
  label: 'Settings',
  icon: Icons.settings,
  labelPosition: NavRailButtonLabelPosition.bottom,
)
```

### Navbar

A customizable navigation bar widget that appears at the top of each page.

#### Constructor Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `title` | `String` | Required | Title text displayed in the navbar |
| `actions` | `List<Widget>?` | `null` | Optional action widgets (typically IconButtons) |
| `backgroundColor` | `Color?` | `null` | Background color (uses theme if null) |
| `foregroundColor` | `Color?` | `null` | Text and icon color (uses theme if null) |
| `height` | `double` | `56.0` | Height of the navbar |
| `leading` | `Widget?` | `null` | Optional leading widget (typically back button) |
| `centerTitle` | `bool` | `true` | Whether to center the title |

#### Example Usage

```dart
// Simple navbar
Navbar(title: 'My Page')

// Navbar with actions
Navbar(
  title: 'Dashboard',
  actions: [
    IconButton(
      icon: const Icon(Icons.notifications),
      onPressed: () {},
    ),
    IconButton(
      icon: const Icon(Icons.search),
      onPressed: () {},
    ),
  ],
)

// Custom styled navbar
Navbar(
  title: 'Custom Page',
  backgroundColor: Colors.blue,
  foregroundColor: Colors.white,
  height: 80,
  actions: [
    IconButton(
      icon: const Icon(Icons.more_vert),
      onPressed: () {},
    ),
  ],
)
```

### NavRail

The navigation rail component (used internally by NavPages). Can be used standalone for custom implementations.

#### Constructor Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `buttons` | `List<NavRailButton>` | `[]` | Navigation buttons |
| `actions` | `List<NavRailButton>?` | `null` | Action buttons |
| `direction` | `NavRailDirection` | `NavRailDirection.vertical` | Layout direction |
| `expandable` | `bool` | `false` | Whether expandable |
| `expanded` | `bool` | `false` | Expanded state |
| `minWidth` | `double` | `72.0` | Minimum width |
| `maxWidth` | `double` | `256.0` | Maximum width |
| `minHeight` | `double` | `72.0` | Minimum height |
| `maxHeight` | `double` | `256.0` | Maximum height |
| `labelPosition` | `NavRailButtonLabelPosition?` | `null` | Label position override |
| `backgroundColor` | `Color?` | `null` | Background color |
| `selectedColor` | `Color?` | `null` | Selected button color |
| `unselectedColor` | `Color?` | `null` | Unselected button color |
| `selectedBackgroundColor` | `Color?` | `null` | Selected button background |
| `unselectedBackgroundColor` | `Color?` | `null` | Unselected button background |
| `verticleScrolling` | `bool` | `false` | Whether the navigation rail can be scrolled vertically |
| `leading` | `Widget?` | `null` | Leading widget for expanded navigation rail state |
| `smallLeading` | `Widget?` | `null` | Leading widget for collapsed navigation rail state |
| `leadingOnTop` | `bool` | `false` | Whether leading widgets appear at the top of the navigation rail |

#### Example Usage

```dart
// Standalone navigation rail
NavRail(
  buttons: [
    NavRailButton(label: 'Home', icon: Icons.home),
    NavRailButton(label: 'Profile', icon: Icons.person),
  ],
  expandable: true,
  expanded: true,
)
```

### Enums

#### NavPagesDirection
- `NavPagesDirection.vertical` - Vertical layout (default)
- `NavPagesDirection.horizontal` - Horizontal layout

#### NavRailDirection
- `NavRailDirection.vertical` - Vertical rail (default)
- `NavRailDirection.horizontal` - Horizontal rail

#### NavRailButtonLabelPosition
- `NavRailButtonLabelPosition.right` - Label to the right of icon (default)
- `NavRailButtonLabelPosition.bottom` - Label below icon
- `NavRailButtonLabelPosition.left` - Label to the left of icon
- `NavRailButtonLabelPosition.top` - Label above icon

## Responsive Behavior

NavPages automatically adapts to different screen sizes and orientations, providing an optimal user experience across all devices.

### Breakpoints and Layouts

| Screen Size | Layout | Navigation Position | Behavior |
|-------------|--------|-------------------|----------|
| **Desktop (>768px)** | Vertical | Left side | Full navigation rail with labels |
| **Tablet (768px - 1024px)** | Vertical | Left side | Collapsible rail, labels on hover |
| **Mobile (<768px)** | Horizontal | Top | Compact horizontal bar with overflow menu |

### Desktop Layout (>768px)

```
┌─────────────────────────────────────────┐
│ [🏠] Home    │  ┌─────────────────────┐  │
│ [👤] Profile │  │                     │  │
│ [⚙️] Settings│  │     Page Content     │  │
│ [❓] Help    │  │                     │  │
│              │  │                     │  │
│              │  │                     │  │
└─────────────────────────────────────────┘
```

**Features:**
- Vertical navigation rail on the left
- Full labels visible when expanded
- Smooth expand/collapse animations
- Action buttons at the bottom of the rail

### Mobile Layout (<768px)

```
┌─────────────────────────────────────────┐
│ [🏠] [👤] [⚙️] [⋯] More                │
├─────────────────────────────────────────┤
│                                         │
│           Page Content                  │
│                                         │
│                                         │
└─────────────────────────────────────────┘
```

**Features:**
- Horizontal navigation bar at the top
- Overflow buttons moved to "More" menu
- Action buttons accessible via menu
- Touch-optimized button sizes

### Responsive Configuration

```dart
NavPages(
  // Automatically responsive - no configuration needed
  buttons: [
    NavRailButton(label: 'Home', icon: Icons.home),
    NavRailButton(label: 'Profile', icon: Icons.person),
    NavRailButton(label: 'Settings', icon: Icons.settings),
    NavRailButton(label: 'Help', icon: Icons.help),
    NavRailButton(label: 'About', icon: Icons.info),
  ],
  actions: [
    NavRailButton(label: 'Logout', icon: Icons.logout),
  ],
  children: [
    // Your pages here
  ],
)
```

### Custom Responsive Behavior

You can customize the responsive behavior by wrapping NavPages in a LayoutBuilder:

```dart
LayoutBuilder(
  builder: (context, constraints) {
    bool isMobile = constraints.maxWidth < 768;
    
    return NavPages(
      expandable: !isMobile, // Only expandable on desktop
      expanded: !isMobile,   // Start expanded on desktop
      buttons: [
        NavRailButton(
          label: 'Home',
          icon: Icons.home,
          // Smaller buttons on mobile
          width: isMobile ? 48 : null,
          height: isMobile ? 48 : null,
        ),
        // ... other buttons
      ],
      children: [
        // Your pages
      ],
    );
  },
)
```

### Orientation Changes

NavPages handles orientation changes gracefully:

- **Portrait**: Optimized for vertical scrolling
- **Landscape**: Maximizes horizontal space usage
- **Automatic**: Transitions smoothly between orientations

## Performance

NavPages is optimized for performance and provides several features to ensure smooth operation.

### Built-in Optimizations

- **Lazy Loading**: Pages are only built when they become active
- **Memory Management**: Automatic cleanup of unused page states
- **Animation Optimization**: Hardware-accelerated animations
- **Widget Reuse**: Efficient widget recycling for better performance

### Best Practices

#### 1. Optimize Page Content

```dart
// ✅ Good: Use const constructors where possible
NavPage(
  child: const MyPageContent(), // const constructor
)

// ❌ Avoid: Rebuilding unnecessary widgets
NavPage(
  child: MyPageContent(), // Will rebuild on every navigation
)
```

#### 2. Minimize Navigation Buttons

```dart
// ✅ Good: Reasonable number of buttons
NavPages(
  buttons: [
    NavRailButton(label: 'Home', icon: Icons.home),
    NavRailButton(label: 'Profile', icon: Icons.person),
    NavRailButton(label: 'Settings', icon: Icons.settings),
  ],
  children: [/* ... */],
)

// ❌ Avoid: Too many buttons (consider using actions)
NavPages(
  buttons: [
    // 10+ buttons can impact performance
  ],
)
```

#### 3. Use Actions for Secondary Navigation

```dart
// ✅ Good: Separate primary and secondary actions
NavPages(
  buttons: [
    NavRailButton(label: 'Home', icon: Icons.home),
    NavRailButton(label: 'Profile', icon: Icons.person),
  ],
  actions: [
    NavRailButton(label: 'Settings', icon: Icons.settings),
    NavRailButton(label: 'Help', icon: Icons.help),
  ],
  children: [/* ... */],
)
```

#### 4. Optimize Page Content

```dart
// ✅ Good: Use ListView.builder for large lists
class OptimizedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1000,
      itemBuilder: (context, index) {
        return ListTile(title: Text('Item $index'));
      },
    );
  }
}

// ❌ Avoid: Creating all items at once
class UnoptimizedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(1000, (index) {
        return ListTile(title: Text('Item $index'));
      }),
    );
  }
}
```

### Performance Monitoring

Monitor your app's performance using Flutter's built-in tools:

```dart
// Enable performance overlay in debug mode
void main() {
  runApp(
    MaterialApp(
      home: const MyApp(),
      debugShowPerformanceOverlay: true, // Debug only
    ),
  );
}
```

### Memory Usage

NavPages automatically manages memory by:

- **Page Lifecycle**: Pages are disposed when not in use
- **State Cleanup**: Automatic cleanup of page states
- **Widget Disposal**: Proper disposal of widgets and controllers

### Animation Performance

All animations are optimized for 60fps:

- **Hardware Acceleration**: Uses GPU for smooth animations
- **Efficient Transitions**: Optimized page transition animations
- **Reduced Jank**: Minimized frame drops during navigation

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

## Troubleshooting

Here are solutions to common issues you might encounter when using NavPages.

### Common Issues

#### 1. Navigation Buttons Not Working

**Problem**: Tapping navigation buttons doesn't switch pages.

**Solution**: Ensure the number of buttons matches the number of children:

```dart
// ✅ Correct: Same number of buttons and children
NavPages(
  buttons: [
    NavRailButton(label: 'Home', icon: Icons.home),
    NavRailButton(label: 'Profile', icon: Icons.person),
  ],
  children: [
    NavPage(child: const HomePage()),
    NavPage(child: const ProfilePage()),
  ],
)

// ❌ Incorrect: Mismatched counts
NavPages(
  buttons: [
    NavRailButton(label: 'Home', icon: Icons.home),
    NavRailButton(label: 'Profile', icon: Icons.person),
  ],
  children: [
    NavPage(child: const HomePage()),
    // Missing second page!
  ],
)
```

#### 2. Pages Not Displaying Correctly

**Problem**: Pages appear blank or don't render properly.

**Solution**: Check that your page widgets are properly constructed:

```dart
// ✅ Good: Proper widget structure
NavPage(
  child: const Center(
    child: Text('Page Content'),
  ),
)

// ❌ Avoid: Null or invalid child
NavPage(
  child: null, // This will cause issues
)
```

#### 3. Navigation State Not Persisting

**Problem**: Navigation state resets when the widget rebuilds.

**Solution**: Use keys to maintain state:

```dart
NavPages(
  key: const ValueKey('main_navigation'), // Add a key
  buttons: [/* ... */],
  children: [/* ... */],
)
```

#### 4. Mobile Layout Issues

**Problem**: Navigation doesn't adapt properly on mobile devices.

**Solution**: Ensure you're not overriding responsive behavior:

```dart
// ✅ Good: Let NavPages handle responsiveness
NavPages(
  buttons: [/* ... */],
  children: [/* ... */],
)

// ❌ Avoid: Forcing desktop layout on mobile
NavPages(
  expandable: true,
  expanded: true, // This might cause issues on mobile
  buttons: [/* ... */],
  children: [/* ... */],
)
```

#### 5. Performance Issues

**Problem**: App becomes slow with many pages or complex content.

**Solutions**:

- Use `const` constructors where possible
- Implement lazy loading for heavy content
- Limit the number of navigation buttons (use actions for secondary items)

```dart
// ✅ Good: Optimized page content
class OptimizedPage extends StatelessWidget {
  const OptimizedPage({super.key}); // const constructor

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Optimized Content'),
    );
  }
}

// ❌ Avoid: Rebuilding on every navigation
class UnoptimizedPage extends StatelessWidget {
  UnoptimizedPage({super.key}); // No const constructor

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Content'), // Will rebuild unnecessarily
    );
  }
}
```

### Debug Mode

Enable debug mode to see additional information:

```dart
NavPages(
  // Add debug information
  buttons: [/* ... */],
  children: [/* ... */],
  // Enable debug mode in development
  // debugMode: true, // If available in your version
)
```

### Getting Help

If you're still experiencing issues:

1. **Check the example app**: Run the example in the `example/` directory
2. **Review the API documentation**: Ensure you're using the correct properties
3. **Check Flutter version**: Ensure you're using a compatible Flutter version
4. **File an issue**: Report bugs on the [GitHub repository](https://github.com/sidekick-dojo/navpages/issues)

## Migration Guide

This guide helps you migrate between different versions of NavPages.

### Migrating to v1.2.5

#### New Features

1. **Leading Widgets**: Added support for custom leading widgets in both expanded and collapsed navigation states
   - `navrailLeading`: Widget shown when navigation rail is expanded
   - `navrailSmallLeading`: Widget shown when navigation rail is collapsed
   - `navrailLeadingOnTop`: Controls whether leading widgets appear at the top or after the expand/collapse button

2. **Header Support**: Added optional header widget functionality
   - `header`: Optional header widget for the site
   - `useFullHeader`: Controls whether header spans full width above navigation rail

3. **Scrollable Navigation**: Added vertical scrolling support for navigation rails
   - `navrailVerticleScrolling`: Enables vertical scrolling for navigation rails with many items

4. **Secondary Actions**: Enhanced action management with dynamic secondary actions
   - `setSecondaryActions()`: Method to dynamically set secondary action buttons
   - Secondary actions are automatically cleared on navigation operations

#### Migration Steps

1. **Update Property Names** (if using old property names):
   - `minWidth` → `navrailMinWidth`
   - `maxWidth` → `navrailMaxWidth`
   - `minHeight` → `navrailMinHeight`
   - `maxHeight` → `navrailMaxHeight`

2. **Add New Features** (optional):
   - Consider adding leading widgets for better branding
   - Add header widget for site-wide navigation elements
   - Enable vertical scrolling if you have many navigation items

3. **Test Thoroughly**:
   - Test all navigation functionality
   - Verify responsive behavior with new features
   - Check custom styling with new properties

### Migrating to v1.2.x

### Migrating to v1.1.x

#### Breaking Changes

1. **API Changes**: Some method signatures have changed.

**Before (v1.0.x)**:
```dart
NavPages(
  pages: [/* ... */], // Old property name
  navigationButtons: [/* ... */], // Old property name
)
```

**After (v1.1.x)**:
```dart
NavPages(
  children: [/* ... */], // New property name
  buttons: [/* ... */], // New property name
)
```

#### Migration Steps

1. **Update Property Names**:
   - `pages` → `children`
   - `navigationButtons` → `buttons`

2. **Update Method Calls**:
   - Check for any custom method calls that might have changed

3. **Test Thoroughly**:
   - Test all navigation functionality
   - Verify responsive behavior
   - Check custom styling

### Migrating from Other Navigation Packages

#### From BottomNavigationBar

**Before**:
```dart
BottomNavigationBar(
  currentIndex: _currentIndex,
  onTap: (index) {
    setState(() {
      _currentIndex = index;
    });
  },
  items: [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
  ],
)
```

**After**:
```dart
NavPages(
  buttons: [
    NavRailButton(label: 'Home', icon: Icons.home),
    NavRailButton(label: 'Profile', icon: Icons.person),
  ],
  children: [
    NavPage(child: const HomePage()),
    NavPage(child: const ProfilePage()),
  ],
)
```

#### From NavigationRail

**Before**:
```dart
NavigationRail(
  selectedIndex: _selectedIndex,
  onDestinationSelected: (index) {
    setState(() {
      _selectedIndex = index;
    });
  },
  destinations: [
    NavigationRailDestination(icon: Icon(Icons.home), label: Text('Home')),
    NavigationRailDestination(icon: Icon(Icons.person), label: Text('Profile')),
  ],
)
```

**After**:
```dart
NavPages(
  buttons: [
    NavRailButton(label: 'Home', icon: Icons.home),
    NavRailButton(label: 'Profile', icon: Icons.person),
  ],
  children: [
    NavPage(child: const HomePage()),
    NavPage(child: const ProfilePage()),
  ],
)
```

### Version Compatibility

| NavPages Version | Flutter Version | Dart Version |
|------------------|-----------------|--------------|
| 1.2.5 | >=1.17.0 | ^3.9.0 |
| 1.2.x | >=1.17.0 | ^3.9.0 |
| 1.1.x | >=1.17.0 | ^3.0.0 |
| 1.0.x | >=1.17.0 | ^2.17.0 |

## Examples

Check out the `example/` directory for complete sample applications demonstrating various use cases.

### Running the Example

1. **Clone the repository**:
   ```bash
   git clone https://github.com/sidekick-dojo/navpages.git
   cd navpages
   ```

2. **Navigate to the example directory**:
   ```bash
   cd example
   ```

3. **Get dependencies**:
   ```bash
   flutter pub get
   ```

4. **Run the example**:
   ```bash
   flutter run
   ```

### Example Features Demonstrated

- **Basic Navigation**: Simple multi-page setup
- **Expandable Navigation**: Collapsible navigation rail
- **Action Buttons**: Secondary actions in navigation
- **Custom Styling**: Themed navigation bars and buttons
- **Programmatic Navigation**: Using `NavPages.push()` and `NavPages.pop()`
- **Responsive Design**: Automatic adaptation to screen sizes
- **Leading Widgets**: Custom leading widgets for branding
- **Header Support**: Site-wide header functionality
- **Scrollable Navigation**: Vertical scrolling for many navigation items
- **Dynamic Secondary Actions**: Context-specific temporary actions

## Contributing

We welcome contributions to NavPages! Here's how you can help improve the package.

### Ways to Contribute

- 🐛 **Report Bugs**: Found a bug? Please file an issue with detailed information
- 💡 **Suggest Features**: Have an idea? Open a feature request issue
- 📝 **Improve Documentation**: Help others by improving docs and examples
- 🔧 **Submit Code**: Fix bugs or add new features via pull requests
- 🧪 **Test**: Help test new features and report issues

### Development Setup

1. **Fork the repository** on GitHub
2. **Clone your fork**:
   ```bash
   git clone https://github.com/YOUR_USERNAME/navpages.git
   cd navpages
   ```

3. **Create a branch** for your changes:
   ```bash
   git checkout -b feature/your-feature-name
   ```

4. **Install dependencies**:
   ```bash
   flutter pub get
   ```

5. **Run tests**:
   ```bash
   flutter test
   ```

6. **Run the example** to test your changes:
   ```bash
   cd example
   flutter run
   ```

### Code Style Guidelines

- Follow the existing code style and formatting
- Use meaningful variable and function names
- Add comments for complex logic
- Ensure all tests pass
- Update documentation for new features

### Pull Request Process

1. **Ensure your code works**: Test thoroughly on different screen sizes
2. **Update documentation**: Update README.md and API docs if needed
3. **Add tests**: Include tests for new functionality
4. **Update CHANGELOG.md**: Document your changes
5. **Submit PR**: Create a pull request with a clear description

### Pull Request Template

When submitting a pull request, please include:

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Tests pass
- [ ] Tested on multiple screen sizes
- [ ] Tested on different platforms

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Documentation updated
- [ ] CHANGELOG.md updated
```

### Issue Guidelines

When reporting issues, please include:

- **Flutter version**: `flutter --version`
- **Package version**: Current version of navpages
- **Platform**: iOS, Android, Web, Desktop
- **Steps to reproduce**: Clear steps to reproduce the issue
- **Expected behavior**: What should happen
- **Actual behavior**: What actually happens
- **Screenshots**: If applicable
- **Code sample**: Minimal code that reproduces the issue

### Feature Request Guidelines

When requesting features, please include:

- **Use case**: Why is this feature needed?
- **Proposed solution**: How should it work?
- **Alternatives**: Other ways to solve the problem
- **Additional context**: Any other relevant information

### Community Guidelines

- Be respectful and inclusive
- Help others learn and grow
- Provide constructive feedback
- Follow the [Code of Conduct](CODE_OF_CONDUCT.md)

### Recognition

Contributors will be recognized in:
- README.md contributors section
- Release notes
- Package documentation

Thank you for contributing to NavPages! 🎉

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Additional Information

For more information about this package, visit:
- [GitHub Repository](https://github.com/sidekick-dojo/navpages)
- [Pub.dev Package](https://pub.dev/packages/navpages)

To contribute to the package, file issues, or get support, please visit our GitHub repository.
