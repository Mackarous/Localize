import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(LocalizeMacros)
import LocalizeMacros

let testMacros: [String: Macro.Type] = [
    "Localize": LocalizeMacro.self,
]
#endif

final class LocalizeTests: XCTestCase {
    func testMacroWithStringLiteral() throws {
        #if canImport(LocalizeMacros)
        assertMacroExpansion(
            #"""
            #Localize("Hello, \(name)")
            """#,
            expandedSource: #"""
            {
                #if SWIFT_PACKAGE
                LocalizedStringResource("Hello, \(name)", bundle: .atURL(Bundle.module.bundleURL))
                #else
                LocalizedStringResource("Hello, \(name)")
                #endif
            }()
            """#,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
}
