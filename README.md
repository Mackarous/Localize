# Localize

A simple freestanding macro to easily localize strings in both app targets and Swift packages

## Localization

Localization with [String catalogs](https://developer.apple.com/documentation/xcode/localizing-and-varying-text-with-a-string-catalog) is now easier than ever, and you can also easily [localize Swift packages](https://developer.apple.com/documentation/xcode/localizing-package-resources) as well.

Here is a simple example of localization:
```swift
LocalizedStringResource("This is a localized string")
```
However, this will not work in the context of a Swift package because the built in localization uses the app target instead of the package target. You can see more information on how this works in my blog post on [Localization in SwiftUI](https://swift.mackarous.com/posts/2024/08/localization-in-swiftui/).

To make sure localization works in the context of a Swift package, or any module, you have to enable localization of the package, and initialize the resource like so:
```swift
LocalizedStringResource("This is a localized string", bundle: .module)
```

## Usage

This package introduces a simple freestanding Swift macro to help with reduce the boilerplate and effort of localization across modules.

You can use it anywhere that you would normally use a localized string, here are a couple examples:
```swift
// Assign to a variable
let localizedString = #Localize("This is a localized string")

// Use directly within SwiftUI
Text(#Localize("This is a localized text"))
```

## License

This package is released under MIT License.
See [LICENSE](LICENSE.txt) for more information.
