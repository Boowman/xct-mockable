//
//  XCTMacroErrorTests.swift
//  
//
//  Created by Lenard Pop on 18/05/2024.
//

import Foundation
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport

final class XCTMacroErrorTests: XCTMacroBaseTests {
    func test_members_found() throws {
        #if canImport(XCTMacros)
        assertMacroExpansion(
            """
            @Mockable
            protocol ErrorProtocol { }
            """,
            expandedSource: """
            protocol ErrorProtocol { }
            """,            
            diagnostics: [
                .init(message: "There must be at least 1 member available.", line: 1, column: 1)
            ],
            macros: mockableMacroTest
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
}
