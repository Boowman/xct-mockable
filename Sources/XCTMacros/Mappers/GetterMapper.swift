//
//  GetterMapper.swift
//
//
//  Created by Lenard Pop on 10/05/2024.
//

import Foundation
import SwiftSyntax

internal final class GetterMapper {
    private let getterKeyword: String = "get"
    private let subscriptKeyword: String = "subscript"
    private let varKeyword: String = "var"
    
    private var member: DeclSyntax
    
    init(node: DeclSyntax) {
        self.member = node
    }
    
    func build() -> String {
        return mapGetterMember()
    }
    
    private func mapGetterMember() -> String {
        switch member.kind {
        case .subscriptDecl:
            return mapSubscriptMember()
        case .variableDecl:
            return mapVariableMember()
        default:
            return ""
        }
    }
    
    private func mapSubscriptMember() -> String {
        guard let member = SubscriptDeclSyntax(member) else { return "" }
        guard member.hasGetter else { return "" }
        
        let parametersList = member.getParameters().joined(separator: ", ")
        let returnType = member.getReturnType
        
        let definition = "\(subscriptKeyword)(\(parametersList)): \(returnType)"
        let effect = member.getEffects ?? ""
        
        return mapGetterBlock(
            definition: definition,
            type: returnType,
            effects: effect,
            optional: member.isOptional)
    }
    
    private func mapVariableMember() -> String {
        guard let member = VariableDeclSyntax(member) else { return "" }
        guard member.hasGetter else { return "" }
        
        guard let name = member.getName, 
              let type = member.getReturnType
        else { return "" }
        
        let definition = "\(varKeyword) \(name): \(type)"
        let effect = member.getEffects ?? ""
        
        return mapGetterBlock(
            definition: definition,
            type: type,
            effects: effect,
            optional: member.isReturningOptional)
    }
    
    private func mapGetterBlock(definition: String, type: String, effects: String, optional: Bool) -> String {
        let declaration = effects.isEmpty ? "\(getterKeyword)" : "\(getterKeyword) \(effects)"
        
        return """
        \(declaration) {
            return self.context.mocking.didInvoke(XCTMockable.Invocation(key: "\(definition)",
                                                                         members: [])) { invocation in
                self.context.recordInvocation(invocation)
        
                let result = self.context.stubbing.implementation(for: invocation)

                \(getResultBlock(returnType: type, optional: optional))
                
                fatalError("Failed to find a suitable result type.", file: #file, line: #line)
            }
        }
        """
    }
    
    private func getResultBlock(returnType: String, optional: Bool) -> String {
        return """
        if let result = result {
                    if let result = result as? \(returnType.replacingOccurrences(of: "?", with: "")) {
                        return result
                    }\(getOptionalReturnBlock(optional))
        }
        """
    }
    
    private func getOptionalReturnBlock(_ isOptional: Bool) -> String {
        return isOptional ? 
        """
        \n
        return nil
        """ : ""
    }
}
