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
                public var mockClassId = UUID()
            
                public static var context = XCTMockable.ContextContainer()
                public var context = XCTMockable.ContextContainer()

                subscript(index: Int) -> String {
                    get {
                        return self.context.mocking.didInvoke(XCTMockable.Invocation(key: "subscript(index: Int): String",
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
                public var mockClassId = UUID()
            
                public static var context = XCTMockable.ContextContainer()
                public var context = XCTMockable.ContextContainer()

                subscript(key: String) -> Int {
                    get {
                        return self.context.mocking.didInvoke(XCTMockable.Invocation(key: "subscript(key: String): Int",
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
                public var mockClassId = UUID()
            
                public static var context = XCTMockable.ContextContainer()
                public var context = XCTMockable.ContextContainer()
            
                subscript(product: Product) -> Product? {
                    get {
                        return self.context.mocking.didInvoke(XCTMockable.Invocation(key: "subscript(product: Product): Product?",
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
    
    func test_async_throws_get() throws {
        #if canImport(XCTMacros)
        assertMacroExpansion(
            """
            @Mockable
            protocol PropertiesProtocol {
                subscript(id: String, product: Product) -> Product? { get async throws }
            }
            """,
            expandedSource: """
            protocol PropertiesProtocol {
                subscript(id: String, product: Product) -> Product? { get async throws }
            }

            class PropertiesProtocolMock: PropertiesProtocol, XCTMockProtocol {
                public var mockClassId = UUID()
            
                public static var context = XCTMockable.ContextContainer()
                public var context = XCTMockable.ContextContainer()
            
                subscript(id: String, product: Product) -> Product? {
                    get async throws {
                        return self.context.mocking.didInvoke(XCTMockable.Invocation(key: "subscript(id: String, product: Product): Product?",
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
