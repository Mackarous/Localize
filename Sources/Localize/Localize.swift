// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

/// A macro that produces a localized string (module agnostic) from a String literal.
/// For example:
///
///     #Localize("Macros are fun!")
///
/// produces the following:
///
///     {
///         #if SWIFT_PACKAGE
///         LocalizedStringResource("Macros are fun!", bundle: .atURL(Bundle.module.bundleURL))
///         #else
///         LocalizedStringResource("Macros are fun!")
///         #endif
///     }()
@freestanding(expression)
public macro Localize(_ value: String.LocalizationValue) -> LocalizedStringResource = #externalMacro(module: "LocalizeMacros", type: "LocalizeMacro")
