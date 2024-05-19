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
    
    private let mockClassId: String = "mockClassId"
    private var className: String = ""
    private var protocolName: String = ""
    
    init(protocolDecl: ProtocolDeclSyntax, node: AttributeSyntax) {
        self.protocolDecl = protocolDecl
        self.node = node
    }
    
    func build() throws -> [DeclSyntax] {
        className = "\(protocolDecl.name.text)Mock"
        protocolName = protocolDecl.name.text
        
        var inheritanceTypes: [String] = protocolDecl.getInheritanceTypes
        inheritanceTypes.insert(protocolName, at: 0)
        inheritanceTypes.insert("XCTMockProtocol", at: 1)
        
        let inheritanceText = inheritanceTypes.joined(separator: ", ")

        var attributes = ""
        if protocolDecl.hasAttributes {
            attributes += protocolDecl.getAttributes
        }
        
        let result =
        """
        \(attributes)
        class \(className): \(inheritanceText) {
            public var \(mockClassId) = UUID()
        
            public static var context = XCTMockable.ContextContainer()
            public var context = XCTMockable.ContextContainer()
            
            \(getMemberImplementations())\(getInheritanceImplementations())
        }
        """
        
        return [DeclSyntax(stringLiteral: result)]
    }
    
    private func getMemberImplementations() -> String {
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
    
    private func getInheritanceImplementations() -> String {
        var inheritanceResult = ""
        
        if protocolDecl.doesContainInheritance(inheritance: .equatable) {
            inheritanceResult += """
            \n
            static func == (lhs: \(className), rhs: \(className)) -> Bool {
                return lhs.\(mockClassId) == rhs.\(mockClassId)
            }
            """
        }
        
        return inheritanceResult
    }
}
