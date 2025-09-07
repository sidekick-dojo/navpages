# NavPages Example

This example demonstrates the basic usage of the NavPages package.

## Features Demonstrated

- **Basic Navigation**: Multiple pages with navigation buttons
- **Expandable Navigation**: Collapsible navigation rail
- **Action Buttons**: Secondary actions in the navigation rail
- **Custom Navbar**: Navigation bars with titles and action buttons
- **Navigation Control**: Programmatic navigation using `NavPages.push()`
- **Responsive Design**: Automatic adaptation to different screen sizes

## Running the Example

1. Navigate to the example directory:
   ```bash
   cd example
   ```

2. Get dependencies:
   ```bash
   flutter pub get
   ```

3. Run the example:
   ```bash
   flutter run
   ```

## What You'll See

- A dashboard with navigation buttons on the left (desktop) or top (mobile)
- Expandable navigation rail with primary and action buttons
- Multiple pages with different content
- Navigation bars with titles and action buttons
- A detail page that demonstrates programmatic navigation

## Key Concepts

### NavPages Widget
The main widget that manages multiple pages and navigation.

### NavRailButton
Buttons for navigation and actions in the rail.

### NavPage
Individual pages with optional navigation bars.

### Navbar
Customizable navigation bars with titles and actions.

### Navigation Control
Use `NavPages.push()`, `NavPages.pop()`, and `NavPages.canPop()` to control navigation programmatically.
