//
//  InitialiserMapper.swift
//  
//
//  Created by Lenard Pop on 10/05/2024.
//

import Foundation
import SwiftSyntax

internal final class InitialiserMapper {
    private let requiredKeyword: String = "required"
    private var member: InitializerDeclSyntax? = nil
    
    init(node: DeclSyntax) {
        self.member = InitializerDeclSyntax(node)
    }
    
    func build() -> String {
        guard let member = member else {
            return ""
        }
        
        return "\(requiredKeyword) \(member.trimmedDescription) { }"
    }
}
