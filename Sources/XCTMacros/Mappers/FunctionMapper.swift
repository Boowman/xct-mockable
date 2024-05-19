//
//  FunctionMapper.swift
//
//
//  Created by Lenard Pop on 11/05/2024.
//

import Foundation
import SwiftSyntax

internal final class FunctionMapper {
    private let funcKeyword: String = "func"
    private let async: String = "async"
    private let `throws`: String = "throws"
    
    private var member: FunctionDeclSyntax? = nil
    
    private var functionName: String = ""
    private var parametersList: String = ""
    private var returnType: String = ""
    
    private var parameterNames: String = ""
    private var modifiers: String = ""
    
    private var effectSpecifiers: String = ""
    
    init(node: DeclSyntax) {
        self.member = FunctionDeclSyntax(node)
    }
    
    func build() -> String {
        guard let member = member else { return "" }
        
        self.functionName = member.getName
        self.parametersList = member.getParameters().joined(separator: ", ")
        self.returnType = member.getReturnType
        
        self.modifiers = member.getModifiers(includeSpaceSuffix: true)
        self.effectSpecifiers = member.getEffectSpecifiers(includeSpacePrefix: true)
        
        return mapToFunctionMember()
    }
    
    private func mapToFunctionMember() -> String {
        var returnFunction = ""
        
        returnFunction += mapInvoke()
        returnFunction += "\n\n"
        returnFunction += mapDidInvoke()
        
        return returnFunction
    }
    
    private func mapInvoke() -> String {
        guard let member = member else { return "" }
        
        let invocationsParameters = member.getParametersRaw().compactMap { parameter in
            parameter.hasWildCard ? parameter.trimmedDescription : "_ \(parameter.trimmedDescription)"
        }.joined(separator: " ")
        
        let invocationType = "(\(invocationsParameters))\(effectSpecifiers) -> \(returnType)"
        let invocationMembers = createInvocationMembersList(
            parameters: member.signature.parameterClause.parameters
        )
        
        var attributes = ""
        if member.hasAttributes {
            attributes += "\(member.getAttributes)"
        }
        
        return """
        \(attributes)
        \(modifiers)\(funcKeyword) \(functionName)(\(parametersList))\(effectSpecifiers) -> \(createInvocationReturn(invocationType: invocationType, type: returnType)) {
            return XCTMockable.Mockable<XCTMockable.FunctionDeclaration, \(invocationType), \(returnType)>(context: context,
                                                                                                                     invocation: XCTMockable.Invocation(key: "\(modifiers)func \(functionName)(\(parametersList))\(effectSpecifiers) -> \(returnType)",
                                                                                                                                                         members: \(invocationMembers)),
                                                                                                                     returnType: Swift.ObjectIdentifier((\(returnType)).self))
        }
        """
    }
    
    private func mapDidInvoke() -> String {
        guard let member = member else { return "" }
        
        let invocationMembers = createInvocationMembersList(
            parameters: member.signature.parameterClause.parameters
        )
        
        return """
            \(modifiers)\(funcKeyword) \(functionName)(\(parametersList))\(effectSpecifiers) -> \(returnType) {
                return self.context.mocking.didInvoke(XCTMockable.Invocation(key: "\(modifiers)func \(functionName)(\(parametersList))\(effectSpecifiers) -> \(returnType)",
                                                                                  members: \(invocationMembers))) { invocation in
                    
                    let result = self.context.stubbing.implementation(for: invocation)
        
                    \(getResultBlock(returnType: returnType, optional: member.isReturningOptional))

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
        return isOptional ? "\n\nreturn nil" : ""
    }
    
    // MARK: InvocationCalls
    private func createInvocationReturn(invocationType: String, type: String) -> String {
        return "XCTMockable.Mockable<XCTMockable.FunctionDeclaration, \(invocationType), \(type)>"
    }
    
    private func createInvocationMembersList(parameters: FunctionParameterListSyntax) -> String {
        return "[\(parameters.compactMap { createInvocationMember(value: $0) }.joined(separator: ", "))]"
    }
    
    private func createInvocationMember(value: FunctionParameterSyntax) -> String {
        
        let propertyName = value.hasWildCard ? value.secondName?.trimmedDescription :
                                               value.firstName.trimmedDescription
        
        return "XCTMockable.InvocationMember(base: \(propertyName ?? ""))"
    }
}
