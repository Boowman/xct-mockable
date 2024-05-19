//
//  ProtocolDeclSyntax+Extensions.swift
//
//
//  Created by Lenard Pop on 19/05/2024.
//

import Foundation
import SwiftSyntax

extension ProtocolDeclSyntax {
    var getInheritanceTypes: [String] {
        let types = self.inheritanceClause?.inheritedTypes.trimmedDescription.split(separator: ",")
            .map { $0.replacingOccurrences(of: " ", with: "") }
        
        if let types = types, types.isEmpty == false {
            return types
        }
        
        return []
    }
    
    var hasAttributes: Bool {
        return !self.attributes.filter {
            AttributeSyntax($0.self)?.attributeName.trimmedDescription != GlobalTypes.mockable.rawValue
        }.isEmpty
    }
    
    var getAttributes: String {
        return self.attributes.filter {
            AttributeSyntax($0.self)?.attributeName.trimmedDescription != GlobalTypes.mockable.rawValue
        }.compactMap { $0.trimmedDescription }.joined(separator: "\n")
    }
    
    func doesContainInheritance(inheritance: InheritedTypes) -> Bool {
        self.inheritanceClause?.inheritedTypes.contains(where: {
            $0.type.trimmedDescription == inheritance.rawValue
        }) ?? false
    }
}
