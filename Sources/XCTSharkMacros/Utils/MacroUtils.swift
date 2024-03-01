//
//  MacroUtils.swift
//
//
//  Created by Lenard Pop on 09/02/2024.
//

import Foundation
import SwiftSyntax

// MARK: General Stuff
final class MacroUtils { }

// MARK: Get different parameter types
extension MacroUtils {
    func getMemberExpression(_ label: LabeledExprSyntax?) -> ParameterProtocol? {
        
        let member = MemberAccessExprSyntax(label?.expression)
        let type = DeclReferenceExprSyntax(member?.base)
        let value = member?.trimmedDescription
        
        guard let type = type, let value = value else {
            return nil
        }
        
        return MacroParameter(type: type.baseName.text, value: value)
    }
    
    func getFunctionExpression(_ label: LabeledExprSyntax?) -> ParameterProtocol? {
        let function = FunctionCallExprSyntax(label?.expression)
        let type = DeclReferenceExprSyntax(function?.calledExpression)
        let value = function?.trimmedDescription
        
        guard let type = type, let value = value else {
            return nil
        }
        
        return MacroParameter(type: type.baseName.text, value: value)
    }
    
    func getStringExpression(_ label: LabeledExprSyntax?) -> ParameterProtocol? {
        
        let string = StringLiteralExprSyntax(label?.expression)
        
        guard let string = string else {
            return nil
        }
        
        return MacroParameter(type: "String", value: string.trimmedDescription)
    }
    
    func getIntExpression(_ label: LabeledExprSyntax?) -> ParameterProtocol? {
        
        let int = IntegerLiteralExprSyntax(label?.expression)
        
        guard let int = int else {
            return nil
        }
        
        return MacroParameter(type: "Int", value: int.trimmedDescription)
    }
    
    func getForceUnwrapExpression(_ label: LabeledExprSyntax?) -> ParameterProtocol? {
        let forceUnwrap = ForceUnwrapExprSyntax(label?.expression)
        let function = FunctionCallExprSyntax(forceUnwrap?.expression)
        
        let type = DeclReferenceExprSyntax(function?.calledExpression)
        let value = function?.trimmedDescription
        
        guard let type = type, let value = value else {
            return nil
        }
        
        return MacroParameter(type: type.baseName.text, value: value)
    }
    
    func getArrayExpression(_ label: LabeledExprSyntax?) -> ParameterProtocol? {
        let expression = ArrayExprSyntax(label?.expression)
        let elements = ArrayElementListSyntax(expression?.elements)
        
        let type = elements?.first?.expression.getType()
        let value = expression?.trimmedDescription
        
        guard let type = type, let value = value else {
            return nil
        }
        
        return MacroParameter(type: "[\(type)]", value: value)
    }
}

// MARK: Get parameters from node
extension MacroUtils {
    static func getParameters(_ node: AttributeSyntax) -> [ParameterProtocol] {
        let arguments = LabeledExprListSyntax(node.arguments)?
            .filter { $0.as(LabeledExprSyntax.self)?
            .label?.text != "label" }
        
        guard let arguments = arguments else {
            return []
        }
        
        let parameters = arguments.compactMap { prm in
            let string = MacroUtils().getStringExpression(prm)
            let int = MacroUtils().getIntExpression(prm)
            let member = MacroUtils().getMemberExpression(prm)
            let function = MacroUtils().getFunctionExpression(prm)
            let unwrap = MacroUtils().getForceUnwrapExpression(prm)
            let array = MacroUtils().getArrayExpression(prm)
            
            return string ??
            int ??
            member ??
            function ??
            unwrap ??
            array
        }
        
        return parameters
    }
}
