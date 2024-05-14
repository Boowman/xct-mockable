//
//  XCTMacroBaseTests.swift
//
//
//  Created by Lenard Pop on 10/05/2024.
//

import XCTest
import Foundation
import SwiftSyntaxMacros

#if canImport(XCTMacros)
import XCTMacros
#endif

class XCTMacroBaseTests: XCTestCase {
    let mockableMacroTest: [String: Macro.Type] = [
        "Mockable": MockableMacro.self,
    ]
}
