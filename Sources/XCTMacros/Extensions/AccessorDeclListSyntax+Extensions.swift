//
//  AccessorDeclListSyntax+Extensions.swift
//
//
//  Created by Lenard Pop on 10/05/2024.
//

import Foundation
import SwiftSyntax

extension AccessorDeclListSyntax {
    var hasGetter: Bool {
        return self.filter { $0.accessorSpecifier.tokenKind == .keyword(.get) }.isEmpty == false
    }
    
    var hasSetter: Bool {
        return self.filter { $0.accessorSpecifier.tokenKind == .keyword(.set) }.isEmpty == false
    }
}
