//
//  SubscriptDeclSyntax+Extensions.swift
//  
//
//  Created by Lenard Pop on 10/05/2024.
//

import Foundation
import SwiftSyntax

extension SubscriptDeclSyntax {
    var hasGetter: Bool {
        return AccessorDeclListSyntax(self.accessorBlock?.accessors)?
            .hasGetter ?? false
    }
    
    var hasSetter: Bool {
        return AccessorDeclListSyntax(self.accessorBlock?.accessors)?
            .hasSetter ?? false
    }
    
    var isOptional: Bool {
        return OptionalTypeSyntax(self.returnClause.type) != nil
    }
    
    var getReturnType: String {
        return self.returnClause.type.trimmedDescription
    }
    
    var getEffects: String? {
        return AccessorDeclListSyntax(self.accessorBlock?.accessors)?
            .first?
            .effectSpecifiers?
            .trimmedDescription
    }
    
    var getModifiers: String {
        return self.modifiers.trimmedDescription
    }
    
    func getParameters() -> [String] {
        return self.parameterClause.parameters.compactMap {
            $0.trimmedDescription.replacingOccurrences(of: ",",with: "")
        }
    }
}
