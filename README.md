# CxjToasts 

Effortless toast presentation with various interaction behaviors between displayed toasts. CxjToasts provides an intuitive and highly customizable solution for managing toast notifications in your iOS app.

![Static Image](https://github.com/coxijcake/CxjToastsExample/blob/main/Assets/ToastsPreview.png)

---

# Table of Contents
- [Introduction](#cxjtoasts)
- [Features](#features)
- [Video Examples of Toast Usage](#video-examples-of-toast-usage)
- [Example Project](#example-project)
- [Swift Version Support](#swift-version-support)
- [Privacy](#privacy)
- [Installation](#installation)
  - [Swift Package Manager](#swift-package-manager)
  - [CocoaPods](#cocoapods)
- [How to Show a Toast](#how-to-show-a-toast)
  - [Public API](#public-api)
  - [Toast Types](#toast-types)
  - [Custom Toast Configuration](#custom-toast-configuration)
- [Toast Configuration](#toast-configuration)
- [View Configuration](#view-configuration)
- [Content Configuration](#content-configuration)
- [License](#licence)

---

## Features
- **Predefined Templates**: Ready-to-use toast designs for common scenarios.
- **Customizable Toasts**: Tailor toasts to match your app's unique style.
- **Dynamic Layouts**: Adapts seamlessly to different screen configurations.
- **Easy-to-Integrate API**: Quickly add toast notifications with minimal setup.
- **iOS 14+ Compatibility**: Fully supports modern and older devices.
- **Swift Modern Concurrency**: Harness the power of Swift's async/await for toast management.
- **Flexible Animations**: Easily configurable animation options.
- **Interaction Coordination**: Smooth management of toast interaction behaviors.
- **Multiple Interaction Methods**: Supports swipe, tap, or timeout-based dismissals.
- **Haptic Feedback Support**: Enhance user experience with tactile feedback.

---

## Video Examples of Toast Usage

### This section demonstrates various examples of toast usage through videos. Each video showcases a specific type of toast behavior or interaction.
<table>
  <tr>
    <td>
		<img src="https://raw.githubusercontent.com/coxijcake/CxjToastsExample/main/Assets/native.gif" alt="Animated GIF" />
    </td>
    <td>
      	<img src="https://raw.githubusercontent.com/coxijcake/CxjToastsExample/main/Assets/undo.gif" alt="Animated GIF" />
    </td>
    <td>
     	<img src="https://raw.githubusercontent.com/coxijcake/CxjToastsExample/main/Assets/bottom_primary.gif" alt="Animated GIF" />
    </td>
    <td>
      	<img src="https://raw.githubusercontent.com/coxijcake/CxjToastsExample/main/Assets/global_status.gif" alt="Animated GIF" />
    </td>
  </tr>
  <tr>
    <td>
      	<img src="https://raw.githubusercontent.com/coxijcake/CxjToastsExample/main/Assets/side_presenting.gif" alt="Animated GIF" />
    </td>
    <td>
      	<img src="https://raw.githubusercontent.com/coxijcake/CxjToastsExample/main/Assets/action_event.gif" alt="Animated GIF" />
    </td>
    <td>
     	<img src="https://raw.githubusercontent.com/coxijcake/CxjToastsExample/main/Assets/compact_action_description.gif" alt="Animated GIF" />
    </td>
    <td>
      	<img src="https://raw.githubusercontent.com/coxijcake/CxjToastsExample/main/Assets/top_straight.gif" alt="Animated GIF" />
    </td>
  </tr>
</table>


---

## Example Project

To explore the full functionality of **CxjToasts**, check out the example project available in this repository. 

The example project demonstrates:
- **Predefined templates** for various toast types.
- **Customization options** for titles, icons, backgrounds, and more.
- **Dynamic animations** and interaction policies.
- **Live examples** of toast stacking, hiding, and interaction coordination.

Simply clone the repository and open the example project to see **CxjToasts** in action.

[Click here to view the example project.](https://github.com/coxijcake/CxjToastsExample)

---

## Swift Version Support

You can find the most up-to-date information about Swift version support for CxjToasts on [Swift Package Index](https://swiftpackageindex.com/coxijcake/CxjToasts):

[![Swift Versions](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fcoxijcake%2FCxjToasts%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/coxijcake/CxjToasts)

## Privacy

CxjToasts does not collect any data. This notice is provided to assist you in completing [App Privacy Details](https://developer.apple.com/app-store/app-privacy-details/). 
Additionally, [privacy manifest](https://github.com/coxijcake/CxjToasts/blob/main/Sources/PrivacyInfo.xcprivacy) was included to be integrated into your app if needed.


## Installation

### Swift Package Manager
You can use The Swift Package Manager to install CxjToasts by adding the description to your Package.swift file:
```swift
dependencies: [
    .package(url: "https://github.com/coxijcake/CxjToasts", from: "1.0.7")
]
```

### CocoaPods
```swift
pod "CxjToasts"
```

After installation, import the library into your project with:
```swift
import CxjToasts
```

## How to Show a Toast

To display a toast, use the `showToast` method of the `CxjToastsCoordinator` singleton. This method allows specifying the toast type and whether the toast should appear with an animation.

### Public API

#### `showToast(type:animated:)`
This is the primary method for displaying toasts.

- **type**: The type of toast to display. It can be either:
  - `templated(template: CxjToastTemplate)`: Use predefined templates for common toast types like success, error, or info.
  - `custom(data: CxjToastType.CustomToastData)`: Provide custom configurations, view settings, and content for a fully customizable toast.
- **animated**: Specifies whether the toast should appear with animation. Defaults to `true`.

---

### Toast Types

#### `CxjToastType`

The `CxjToastType` enum defines the type of toast to display and has the following cases:

1. **Templated Toasts**: Use predefined templates for common toast use cases.
2. **Custom Toasts**: Create custom toasts by providing specific configuration, view settings, and content.

---

### Custom Toast Configuration

For custom toasts, you need to create a `CxjToastType.CustomToastData` object.

#### `CustomToastData` Structure

- **config**: A `CxjToastConfiguration` object that defines toast behavior, such as duration.
- **viewConfig**: A `CxjToastViewConfiguration` object that defines visual properties, such as background color and corner radius.
- **content**: A custom view conforming to `CxjToastContentView` that defines the actual content displayed in the toast.

---


## Toast Configuration
The core structure for defining the behavior, appearance, and interaction of a toast. It provides a flexible API to customize animations, layout, dismissal methods, and more.

### CxjToastConfiguration 
| **Parameter**         | **Description**                                                                                                              |
|-----------------------|----------------------------------------------------------------------------------------------------------------------------|
| `typeId`             	| Identifier for the toast, used to manage interactions such as spam protection and coexistence policies. It also allows for closing all toasts with a specific `typeId`. Note: `typeId` does not equal `CxjToast.id` and is not required to be unique.          |
| `sourceView`         	| The view associated with the toast. Often used for layout calculations or interactions.                                     |
| `sourceBackground`   	| Optional background configuration for the toast. Supports touch interactions and actions.                                   |
| `layout`             	| Layout configuration for the toast, including `placement` and `constraints`.                                               |
| `dismissMethods`     	| Defines how the toast can be dismissed, such as by swipe, tap, or automatic timeout.                                        |
| `keyboardHandling`   	| Configures behavior when a keyboard is visible, such as moving the toast above it.                                         |
| `animations`         	| Animation settings for toast presentation and dismissal.                                                                    |
| `hapticFeedback`     	| Haptic feedback for the toast (e.g., success, error, or custom).                                                           |
| `spamProtection`     	| Enables or disables spam protection and defines criteria for toast comparison.                                             |
| `coexistencePolicy`  	| Defines how the toast interacts with others when a new toast is displayed.                                                 |

---

## View Configuration
Defines the visual and structural properties of the toast’s view. This configuration ensures that the toast seamlessly integrates into your app’s design and functionality.

### CxjToastViewConfiguration
| **Parameter**            | **Description**                                                                                                  |
|--------------------------|------------------------------------------------------------------------------------------------------------------|
| `contentLayout`          | Determines how the content is laid out inside the toast view (e.g., fill with insets, specific constraints).     |
| `background`             | Specifies the background style of the toast view, such as color, blur effect, gradient, or custom view.          |
| `shadow`                 | Configures the shadow appearance for the toast view.                                                             |
| `corners`                | Configures the corner style of the toast view, such as rounded or capsule.                                       |
| `isUserInteractionEnabled` | Specifies whether user interactions with the toast view are enabled.                                           |

---

## Content Configuration
Easily configure the toast content without requiring manual layout, by using pre-defined templates or providing your own custom content view to display in the toast.

### CxjToastContentConfiguration

| Case                              | Description                                                                                   |
|-----------------------------------|-----------------------------------------------------------------------------------------------|
| `.info(type:)`                    | Displays an informational toast with text or text and an icon.                               |
| `.action(config:infoContent:)`    | Displays a toast with an action (e.g., a button) and optional informational content.          |
| `.undoAction(config:)`            | Displays a toast with an undo action, such as a button to revert a previous operation.        |
| `.custom(contentView:)`           | Allows for custom content by providing a custom view implementing `CxjToastContentView`.      |

### InfoContentType

| Case                                     | Description                                                                               |
|------------------------------------------|-------------------------------------------------------------------------------------------|
| `.text(config:)`                         | Displays a text-only informational toast.                                                |
| `.textWithIcon(iconConfig:, textConfig:)`| Displays informational content with both text and an icon, configured separately.         |

---

## Licence
**CxjToasts** is available under the MIT licence. See the [LICENCE](./LICENSE) for more info.


