//
//  FunctionDeclaration+Extensions.swift
//  
//
//  Created by Lenard Pop on 10/05/2024.
//

import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import Foundation

extension FunctionDeclSyntax {
    var getName: String {
        return self.name.text
    }
    
    var getParametersCount: Int {
        return self.signature.parameterClause.parameters.count
    }
    
    var getReturnType: String {
        return self.signature.returnClause?.type.trimmedDescription ?? "Void"
    }
    
    var hasAttributes: Bool {
        return !self.attributes.isEmpty
    }
    
    var getAttributes: String {
        return self.attributes.trimmedDescription
    }
    
    var isReturningOptional: Bool {
        return OptionalTypeSyntax(self.signature.returnClause?.type) != nil
    }
    
    func getParameters() -> [String] {
        return self.signature.parameterClause.parameters.compactMap {
            $0.trimmedDescription.replacingOccurrences(of: ",",with: "")
        }
    }
    
    func getParametersRaw() -> [FunctionParameterSyntax] {
        return self.signature.parameterClause.parameters.compactMap { $0 }
    }
    
    ///
    ///  - `static`
    ///  - `open`
    ///  - `public`
    ///  - `private`
    ///  - `internal`
    ///  - `fileprivate` 
    ///
    func getModifiers(includeSpaceSuffix: Bool = false) -> String {
        let space = includeSpaceSuffix ? " " : ""
        
        return self.modifiers.isEmpty ? "" : self.modifiers.trimmedDescription + space
    }
    
    ///
    ///  - `asyncSpecifier`: (`'async'` | `'reasync'`)?
    ///  - `throwsSpecifier`: (`'throws'` | `'rethrows'`)?
    ///
    func getEffectSpecifiers(includeSpacePrefix: Bool = false) -> String {
        guard let effectSpecifier = self.signature.effectSpecifiers else { return "" }
        
        let space = includeSpacePrefix ? " " : ""
        
        return space + effectSpecifier.trimmedDescription
    }
}
