//
//  VariableMapper.swift
//
//
//  Created by Lenard Pop on 10/05/2024.
//

import Foundation
import SwiftSyntax

internal final class VariableMapper {
    private let varKeyword: String = "var"
    private var declSyntax: DeclSyntax
    private var member: VariableDeclSyntax? = nil
    
    init(node: DeclSyntax) {
        self.declSyntax = node
        self.member = VariableDeclSyntax(node)
    }
    
    func build() -> String {
        return mapVariableFromNode()
    }
    
    func mapVariableFromNode() -> String {
        guard let member = member else { return "" }
        guard let name = member.getName, let type = member.getReturnType else { return "" }
        
        let modifiers = member.getModifiers(includeSpaceSuffix: true)
        
        return """
        \(modifiers)\(varKeyword) \(name): \(type) {
        \(GetterMapper(node: declSyntax).build())\(SetterMapper(node: declSyntax).build()) }
        """
    }
}
