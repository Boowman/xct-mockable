//
//  AssociatedTypeProtocol.swift
//  
//
//  Created by Lenard Pop on 19/05/2024.
//

import Foundation
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport

final class XCTMacroAssociatedTypeTests: XCTMacroBaseTests {
    func test_associated_type() throws {
        #if canImport(XCTMacros)
        assertMacroExpansion(
            """
            @Mockable(("ItemId", String))
            protocol AssociatedTypeProtocol {
                associatedtype ItemId
                
                var products: [ItemId] { get set }
            }
            """,
            expandedSource: """
            protocol AssociatedTypeProtocol {
                typealias ItemId = String
                
                var products: [ItemId] { get set }
            }

            class AsyncProtocolMock: AsyncProtocol, XCTMockProtocol {
                typealias ItemType = String
            
                public var mockClassId = UUID()
            
                public static var context = XCTMockable.ContextContainer()
                public var context = XCTMockable.ContextContainer()
            }
            """,
            macros: mockableMacroTest
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
}
