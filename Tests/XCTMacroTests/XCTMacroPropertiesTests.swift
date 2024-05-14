//
//  XCTMacroPropertiesTests.swift
//  
//
//  Created by Lenard Pop on 10/05/2024.
//

import Foundation
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport

final class XCTMacroPropertiesTests: XCTMacroBaseTests {
    func test_static_property() throws {
        #if canImport(XCTMacros)
        assertMacroExpansion(
            """
            @Mockable
            protocol PropertiesProtocol {
                static var description: String { get }
            }
            """,
            expandedSource: """
            protocol PropertiesProtocol {
                static var description: String { get }
            }

            class PropertiesProtocolMock: PropertiesProtocol, XCTMockProtocol {
                public static var context = XCTMockable.ContextContainer()
                public var context = XCTMockable.ContextContainer()
            
                static var description: String {
                    get {
                        return self.context.mocking.didInvoke(XCTMockable.Invocation(key: "var description: String",
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
                }
            }
            """,
            macros: mockableMacroTest
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    func test_get_set() throws {
        #if canImport(XCTMacros)
        assertMacroExpansion(
            """
            @Mockable
            protocol PropertiesProtocol {
                var product: Product { get set }
            }
            """,
            expandedSource: """
            protocol PropertiesProtocol {
                var product: Product { get set }
            }

            class PropertiesProtocolMock: PropertiesProtocol, XCTMockProtocol {
                public static var context = XCTMockable.ContextContainer()
                public var context = XCTMockable.ContextContainer()
            
                var product: Product {
                    get {
                        return self.context.mocking.didInvoke(XCTMockable.Invocation(key: "var product: Product",
                                                                                          members: [])) { invocation in

                            self.context.recordInvocation(invocation)
                            let result = self.context.stubbing.implementation(for: invocation)

                            if let result = result {
                                if let result = result as? Product {
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
    
    func test_nullable() throws {
        #if canImport(XCTMacros)
        assertMacroExpansion(
            """
            @Mockable
            protocol PropertiesProtocol {
                var productTitle: String? { get set }
            }
            """,
            expandedSource: """
            protocol PropertiesProtocol {
                var productTitle: String? { get set }
            }

            class PropertiesProtocolMock: PropertiesProtocol, XCTMockProtocol {
                public static var context = XCTMockable.ContextContainer()
                public var context = XCTMockable.ContextContainer()
            
                var productTitle: String? {
                    get {
                        return self.context.mocking.didInvoke(XCTMockable.Invocation(key: "var productTitle: String?",
                                                                                          members: [])) { invocation in

                            self.context.recordInvocation(invocation)
                            let result = self.context.stubbing.implementation(for: invocation)

                            if let result = result {
                                if let result = result as? String {
                                    return result
                                }

                                return nil
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
            protocol PropertiesProtocol {
                var productDescription: String { get }
            }
            """,
            expandedSource: """
            protocol PropertiesProtocol {
                var productDescription: String { get }
            }

            class PropertiesProtocolMock: PropertiesProtocol, XCTMockProtocol {
                public static var context = XCTMockable.ContextContainer()
                public var context = XCTMockable.ContextContainer()
            
                var productDescription: String {
                    get {
                        return self.context.mocking.didInvoke(XCTMockable.Invocation(key: "var productDescription: String",
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
                }
            }
            """,
            macros: mockableMacroTest
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
//    func test_async_get() throws {
//        #if canImport(XCTMacros)
//        assertMacroExpansion(
//            """
//            @Mockable
//            protocol PropertiesProtocol {
//                static var description: String { get }
//            
//                var product: Product { get set }
//                var productTitle: String? { get set }
//                var productDescription: String { get }
//            }
//            """,
//            expandedSource: """
//            protocol PropertiesProtocol {
//                static var description: String { get }
//            
//                var product: Product { get set }
//                var productTitle: String? { get set }
//                var productDescription: String { get }
//            }
//
//            class PropertiesProtocolMock: PropertiesProtocol, XCTMockProtocol {
//                public static var context = XCTMockable.ContextContainer()
//                public var context = XCTMockable.ContextContainer()
//            }
//            """,
//            macros: mockableMacroTest
//        )
//        #else
//        throw XCTSkip("macros are only supported when running tests for the host platform")
//        #endif
//    }
}
