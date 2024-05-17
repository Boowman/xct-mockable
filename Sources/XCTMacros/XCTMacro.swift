import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct MockableMacro: PeerMacro {
    
    public static func expansion(
        of node: SwiftSyntax.AttributeSyntax,
        providingPeersOf declaration: some SwiftSyntax.DeclSyntaxProtocol,
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.DeclSyntax] {
        
        guard let protocolDecl = declaration.as(ProtocolDeclSyntax.self) else {
            return []
        }
        
        guard !protocolDecl.memberBlock.members.isEmpty else {
            throw XCTErrors.noMembersFound
        }
        
        return try XCTMacroFactory(protocolDecl: protocolDecl, node: node).build()
    }
}

@main
struct XCTPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        MockableMacro.self,
    ]
}
