import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct MockableMacro: PeerMacro {
    public static func expansion(of node: SwiftSyntax.AttributeSyntax, 
                                 providingPeersOf declaration: some SwiftSyntax.DeclSyntaxProtocol,
                                 in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> [SwiftSyntax.DeclSyntax] {
        guard let protocolDecl = declaration.as(ProtocolDeclSyntax.self) else {
            return []
        }
        
        let protocolName = protocolDecl.name.text
        
        var memembers = ""
        
        for (index, item) in protocolDecl.memberBlock.members.enumerated() {
            let lastMember = index != protocolDecl.memberBlock.members.count - 1
            
            memembers += createInitializerMember(member: item.decl, lastMember: lastMember)
            memembers += createVariableMember(member: item.decl, lastMember: lastMember)
            memembers += createFunctionMember(member: item.decl, lastMember: lastMember)
        }
        
        let result =
        """
        class \(protocolName)Mock: \(protocolName), XCTSharkMockProtocol {
            public static var context = XCTSharkMockable.ContextContainer()
            public var context = XCTSharkMockable.ContextContainer()
            
            \(memembers)
        }
        """
        
        
        return [DeclSyntax(stringLiteral: result)]
    }
    
    // MARK: Initializer Creation
    
    private static func createInitializerMember(member: DeclSyntax, lastMember: Bool) -> String {
        guard let initializer = member.as(InitializerDeclSyntax.self) else { return "" }

        var returnInit = """
            required
         \(initializer.trimmedDescription) { }
        """
        
        if lastMember {
            returnInit += "\n\n"
        }
        
        return returnInit
    }
    
    // MARK: Variable Creation
    
    private static func createVariableMember(member: DeclSyntax, lastMember: Bool) -> String {
        guard let variable = member.as(VariableDeclSyntax.self) else { return "" }
        
        let pattern = variable.bindings.first?.as(PatternBindingSyntax.self)?.pattern.trimmedDescription
        let type = variable.bindings.first?.as(PatternBindingSyntax.self)?.typeAnnotation?.trimmedDescription
        
        guard let pattern = pattern, let type = type else { return "" }
        
        var returnVariable = """
            var \(pattern)\(type) {
                \(createGet(variable: variable))
                \(createSet())
            }
            """
        
        if lastMember {
            returnVariable += "\n\n"
        }
        
        return returnVariable
    }
    
    private static func createGet(variable: VariableDeclSyntax) -> String {
        let pattern = variable.bindings.first?.as(PatternBindingSyntax.self)?.pattern.trimmedDescription
        let type = variable.bindings.first?.as(PatternBindingSyntax.self)?.typeAnnotation?.type.trimmedDescription
        
        guard let pattern = pattern, let type = type else { return "" }
        
        let name = "var \(pattern): \(type)"
        
        return """
            get {
                    return self.context.mocking.didInvoke(XCTSharkMockable.Invocation(key: "\(name)",
                                                                                      members: [])) { invocation in
                        self.context.recordInvocation(invocation)
                        let result = self.context.stubbing.implementation(for: invocation)

                        if let result = result as? \(type) {
                            return result
                        }

                        fatalError("Failed to find a suitable result type.", file: #file, line: #line)
                    }
                }
        """
    }
    
    // ToDo -> Check if the variable contains a setter if not don't add it.
    private static func createSet() -> String {
        return """
            set { }
        """
    }
    
    // MARK: Function Creation
    
    private static func createFunctionMember(member: DeclSyntax, lastMember: Bool) -> String {
        guard let function = member.as(FunctionDeclSyntax.self) else { return "" }
        
        var returnFunction = ""
        
        returnFunction += createMockableInvoke(function: function)
        returnFunction += "\n\n"
        returnFunction += createDidInvoke(function: function)
        
        if lastMember {
            returnFunction += "\n\n"
        }
        
        return returnFunction
    }
    
    private static func createMockableInvoke(function: FunctionDeclSyntax) -> String {
        let functionName = function.name.text
        let parametersClause = function.signature.parameterClause.trimmedDescription
        let returnType = function.signature.returnClause?.trimmedDescription ?? ""
        
        let asType = (function.signature.returnClause?.type.trimmedDescription ?? "")
        let parameterNames = "[\(function.signature.parameterClause.parameters.map { "XCTSharkMockable.InvocationMember(base: \($0.firstName.text))" }.joined(separator: ","))]"
        let modifiers = function.modifiers.isEmpty ? "" : function.modifiers.trimmedDescription + " "
        let effectSpecifiers = function.signature.effectSpecifiers != nil ? " " + function.signature.effectSpecifiers!.trimmedDescription : ""
        
        return """
        \(modifiers)func \(functionName)\(parametersClause)\(effectSpecifiers) -> XCTSharkMockable.Mockable<XCTSharkMockable.FunctionDeclaration, \(asType)> {
            return XCTSharkMockable.Mockable<XCTSharkMockable.FunctionDeclaration, \(asType)>(context: context,
                                                                                              invocation: XCTSharkMockable.Invocation(key: "\(modifiers)func \(functionName)\(parametersClause)\(effectSpecifiers) \(returnType)",
                                                                                                                                      members: \(parameterNames)),
                                                                                              returnType: Swift.ObjectIdentifier((\(asType)).self))
        }
        """
    }
    
    private static func createDidInvoke(function: FunctionDeclSyntax) -> String {
        let functionName = function.name.text
        let parametersClause = function.signature.parameterClause.trimmedDescription
        let returnType = function.signature.returnClause?.trimmedDescription ?? ""
        let modifiers = function.modifiers.isEmpty ? "" : function.modifiers.trimmedDescription + " "
        let effectSpecifiers = function.signature.effectSpecifiers != nil ? " " + function.signature.effectSpecifiers!.trimmedDescription : ""
        
        let asType = (function.signature.returnClause?.type.trimmedDescription ?? "")
        let parameterNames = "[\(function.signature.parameterClause.parameters.map { "XCTSharkMockable.InvocationMember(base: \($0.firstName.text))" }.joined(separator: ","))]"
        let optionalReturn = OptionalTypeSyntax(function.signature.returnClause?.type) != nil ? "if result == nil { return nil }" : ""
        
        return """
            \(modifiers)func \(functionName)\(parametersClause)\(effectSpecifiers)\(returnType) {
                return self.context.mocking.didInvoke(XCTSharkMockable.Invocation(key: "\(modifiers)func \(functionName)\(parametersClause)\(effectSpecifiers) \(returnType)",
                                                                                  members: \(parameterNames))) { invocation in
                    
                    let result = self.context.stubbing.implementation(for: invocation)
                    \(optionalReturn)
                    if let result = result as? \(asType.replacingOccurrences(of: "?", with: "")) {
                        return result
                    }

                    fatalError("Failed to find a suitable result type.", file: #file, line: #line)
                }
            }
        """
    }
}

@main
struct XCTSharkPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        MockableMacro.self,
    ]
}
