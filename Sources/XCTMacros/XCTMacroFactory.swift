//
//  XCTMacroFactory.swift
//
//
//  Created by Lenard Pop on 14/02/2024.
//

import Foundation
import SwiftSyntax

final class XCTMacroFactory {
    
    private let protocolDecl: ProtocolDeclSyntax
    private let node: AttributeSyntax
    
    init(protocolDecl: ProtocolDeclSyntax, node: AttributeSyntax) {
        self.protocolDecl = protocolDecl
        self.node = node
    }
    
    func build() throws -> [DeclSyntax] {
        let className = protocolDecl.name.text
        let memberBlocks = getMemberBlocks()
        
        let result =
        """
        class \(className)Mock: \(className), XCTMockProtocol {
            public static var context = XCTMockable.ContextContainer()
            public var context = XCTMockable.ContextContainer()
            
            \(memberBlocks)
        }
        """
        
        return [DeclSyntax(stringLiteral: result)]
    }
    
    private func getMemberBlocks() -> String {
        var members = ""
        
        for (index, item) in protocolDecl.memberBlock.members.enumerated() {
            let lastMember = index != protocolDecl.memberBlock.members.count - 1
            
            members += InitialiserMapper(node: item.decl).build()
            members += SubscriptMapper(node: item.decl).build()
            members += VariableMapper(node: item.decl).build()
            members += FunctionMapper(node: item.decl).build()
            
            if lastMember {
                members += "\n\n"
            }
        }
        
        return members
    }
}
