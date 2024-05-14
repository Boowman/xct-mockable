//
//  XCTMacroSubscriptTests.swift
//
//
//  Created by Lenard Pop on 10/05/2024.
//

import Foundation
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport

final class XCTMacroSubscriptTests: XCTMacroBaseTests {
    func test_get_set() throws {
        #if canImport(XCTMacros)
        assertMacroExpansion(
            """
            @Mockable
            protocol SubscriptProtocol {
                subscript(index: Int) -> String { get set }
            }
            """,
            expandedSource: """
            protocol SubscriptProtocol {
                subscript(index: Int) -> String { get set }
            }

            class SubscriptProtocolMock: SubscriptProtocol, XCTMockProtocol {
                public static var context = XCTMockable.ContextContainer()
                public var context = XCTMockable.ContextContainer()

                subscript(index: Int) -> String {
                    get {
                        return self.context.mocking.didInvoke(XCTMockable.Invocation(key: "subscriptindex: Int: String",
                                                                                          members: [])) { invocation in

                            self.context.recordInvocation(invocation)
                            let result = self.context.stubbing.implementation(for: invocation)

                            if let result = result {
                                if let result = result as? String {
                                    return result
                                }
                            }

                            fatalError("Failed to find a suitable result type.", file: #file, line: #line)
                        }
                    }
                    set {
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
    
    func test_get_only() throws {
        #if canImport(XCTMacros)
        assertMacroExpansion(
            """
            @Mockable
            protocol SubscriptProtocol {
                subscript(key: String) -> Int { get }
            }
            """,
            expandedSource: """
            protocol SubscriptProtocol {
                subscript(key: String) -> Int { get }
            }

            class SubscriptProtocolMock: SubscriptProtocol, XCTMockProtocol {
                public static var context = XCTMockable.ContextContainer()
                public var context = XCTMockable.ContextContainer()

                subscript(key: String) -> Int {
                    get {
                        return self.context.mocking.didInvoke(XCTMockable.Invocation(key: "subscriptkey: String: Int",
                                                                                          members: [])) { invocation in

                            self.context.recordInvocation(invocation)
                            let result = self.context.stubbing.implementation(for: invocation)

                            if let result = result {
                                if let result = result as? Int {
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
    
    func test_nullable_return() throws {
        #if canImport(XCTMacros)
        assertMacroExpansion(
            """
            @Mockable
            protocol SubscriptProtocol {
                subscript(product: Product) -> Product? { get }
            }
            """,
            expandedSource: """
            protocol SubscriptProtocol {
                subscript(product: Product) -> Product? { get }
            }

            class SubscriptProtocolMock: SubscriptProtocol, XCTMockProtocol {
                public static var context = XCTMockable.ContextContainer()
                public var context = XCTMockable.ContextContainer()
            
                subscript(product: Product) -> Product? {
                    get {
                        return self.context.mocking.didInvoke(XCTMockable.Invocation(key: "subscriptproduct: Product: Product?",
                                                                                          members: [])) { invocation in

                            self.context.recordInvocation(invocation)
                            let result = self.context.stubbing.implementation(for: invocation)

                            if let result = result {
                                if let result = result as? Product {
                                    return result
                                }

                                return nil
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
