import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

/// Implementation of the `Localize` macro, which takes an expression of `String` type 
/// and priduces a `LocalizedStringResource` tied to the current bundle. For example
///
///     #Localize("Localizable String")
///
///  will expand to
///
///     LocalizedStringResource("Localizable String", bundle: .module)
public struct LocalizeMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) -> ExprSyntax {
        guard let argument = node.argumentList.first?.expression else {
            fatalError("compiler bug: the macro does not have any arguments")
        }
        guard argument.is(StringLiteralExprSyntax.self) else {
            fatalError("compiler bug: the macro only accepts string literals")
        }
        
        return """
        {
        #if SWIFT_PACKAGE
        LocalizedStringResource(\(argument), bundle: .atURL(Bundle.module.bundleURL))
        #else
        LocalizedStringResource(\(argument))
        #endif
        }()
        """
    }
}

@main
struct LocalizePlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        LocalizeMacro.self,
    ]
}
