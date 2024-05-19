//
//  VariableDeclSyntax+Extensions.swift
//  
//
//  Created by Lenard Pop on 10/05/2024.
//

import Foundation
import SwiftSyntax

extension VariableDeclSyntax {
    var hasGetter: Bool {
        return AccessorDeclListSyntax(self.bindings.first?.accessorBlock?.accessors)?
            .hasGetter ?? false
    }
    
    var hasSetter: Bool {
        return AccessorDeclListSyntax(self.bindings.first?.accessorBlock?.accessors)?
            .hasSetter ?? false
    }
    
    var getName: String? {
        return PatternBindingSyntax(self.bindings.first)?.pattern.trimmedDescription
    }
    
    var getReturnType: String? {
        return self.bindings.first?.typeAnnotation?.type.trimmedDescription
    }
    
    var getEffects: String? {
        return AccessorDeclListSyntax(self.bindings.first?.accessorBlock?.accessors)?.first?.effectSpecifiers?.trimmedDescription
    }
    
    var isReturningOptional: Bool {
        return OptionalTypeSyntax(self.bindings.first?.typeAnnotation?.type) != nil
    }
    
    ///
    ///  - `open`
    ///  - `static
    ///  - `public`
    ///  - `private`
    ///  - `internal`
    ///  - `fileprivate`
    ///
    func getModifiers(includeSpaceSuffix: Bool = false) -> String {
        let space = includeSpaceSuffix ? " " : ""
        
        return self.modifiers.isEmpty ? "" : self.modifiers.trimmedDescription + space
    }
}
