//
//  FunctionParameterSyntax+Extensions.swift
//  
//
//  Created by Lenard Pop on 12/05/2024.
//

import Foundation
import SwiftSyntax

extension FunctionParameterSyntax {
    var hasWildCard: Bool {
        return self.firstName.tokenKind == .wildcard
    }
}
