//
//  SetterMapper.swift
//
//
//  Created by Lenard Pop on 10/05/2024.
//

import Foundation
import SwiftSyntax

internal final class SetterMapper {
    private let setterKeyword: String = "set"
    private var member: DeclSyntax
    
    init(node: DeclSyntax) {
        self.member = node
    }
    
    func build() -> String {
        return mapSetterMember()
    }
    
    private func mapSetterMember() -> String {
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
        guard member.hasSetter else { return "" }

        return mapSetterTextBlock()
    }
    
    private func mapVariableMember() -> String {
        guard let member = VariableDeclSyntax(member) else { return "" }
        guard member.hasSetter else { return "" }

        return mapSetterTextBlock()
    }
    
    private func mapSetterTextBlock() -> String {
        return "\(setterKeyword) { }"
    }
}
