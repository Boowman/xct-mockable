//
//  SubscriptMapper.swift
//  
//
//  Created by Lenard Pop on 10/05/2024.
//

import Foundation
import SwiftSyntax

internal final class SubscriptMapper {
    private let subscriptKeyword: String = "subscript"
    
    private var declSyntax: DeclSyntax
    private var member: SubscriptDeclSyntax? = nil
    
    init(node: DeclSyntax) {
        self.declSyntax = node
        self.member = SubscriptDeclSyntax(node)
    }
    
    func build() -> String {
        return mapSubscriptFromNode()
    }
    
    func mapSubscriptFromNode() -> String {
        guard let member = member else { return "" }
        
        let parametersList = member.getParameters().joined(separator: ", ")
        let returnType = member.getReturnType
        
        return """
        \(subscriptKeyword)(\(parametersList)) -> \(returnType) {
        \(GetterMapper(node: declSyntax).build())\(SetterMapper(node: declSyntax).build())
        }
        """
    }
}
