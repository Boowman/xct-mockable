//
//  XCTMacroInitTests.swift
//
//
//  Created by Lenard Pop on 10/05/2024.
//

import Foundation
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport

final class XCTMacroInitTests: XCTMacroBaseTests {
    func test_standard_init() throws {
        #if canImport(XCTMacros)
        assertMacroExpansion(
            """
            @Mockable
            protocol InitProtocol {
                init()
            }
            """,
            expandedSource: """
            protocol InitProtocol {
                init()
            }

            class InitProtocolMock: InitProtocol, XCTMockProtocol {
                public var mockClassId = UUID()
            
                public static var context = XCTMockable.ContextContainer()
                public var context = XCTMockable.ContextContainer()

                required init() {
                }
            }
            """,
            macros: mockableMacroTest
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    func test_parameterized() throws {
        #if canImport(XCTMacros)
        assertMacroExpansion(
            """
            @Mockable
            protocol InitProtocol {
                init(key keyValue: String, jsonValue: String)
            }
            """,
            expandedSource: """
            protocol InitProtocol {
                init(key keyValue: String, jsonValue: String)
            }

            class InitProtocolMock: InitProtocol, XCTMockProtocol {
                public var mockClassId = UUID()
            
                public static var context = XCTMockable.ContextContainer()
                public var context = XCTMockable.ContextContainer()

                required init(key keyValue: String, jsonValue: String) {
                }
            }
            """,
            macros: mockableMacroTest
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
}
