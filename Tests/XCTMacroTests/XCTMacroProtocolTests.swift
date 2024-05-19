//
//  XCTMacroProtocolTests.swift
//
//
//  Created by Lenard Pop on 10/05/2024.
//

import Foundation
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport

final class XCTMacroProtocolTests: XCTMacroBaseTests {
    func test_protocol_attribute() throws {
        #if canImport(XCTMacros)
        assertMacroExpansion(
            """
            @Mockable
            @MainActor
            protocol AsyncProtocol {
                var mainActorAttribute: Bool { get }
            }
            """,
            expandedSource: """
            @MainActor
            protocol AsyncProtocol {
                var mainActorAttribute: Bool { get }
            }

            @MainActor
            class AsyncProtocolMock: AsyncProtocol, XCTMockProtocol {
                public var mockClassId = UUID()

                public static var context = XCTMockable.ContextContainer()
                public var context = XCTMockable.ContextContainer()

                var mainActorAttribute: Bool {
                    get {
                        return self.context.mocking.didInvoke(XCTMockable.Invocation(key: "var mainActorAttribute: Bool",
                                                                                     members: [])) { invocation in
                            self.context.recordInvocation(invocation)

                            let result = self.context.stubbing.implementation(for: invocation)

                            if let result = result {
                                if let result = result as? Bool {
                                    return result
                                }
                            }

                            fatalError("Failed to find a suitable result type.", file: #file, line: #line)
                        }
                    }
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
