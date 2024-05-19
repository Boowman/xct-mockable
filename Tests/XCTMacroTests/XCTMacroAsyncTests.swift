//
//  XCTMacroAsyncTests.swift
//  
//
//  Created by Lenard Pop on 10/05/2024.
//

import Foundation
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport

final class XCTMacroAsyncTests: XCTMacroBaseTests {
    func test_void_return() throws {
        #if canImport(XCTMacros)
        assertMacroExpansion(
            """
            @Mockable
            protocol AsyncProtocol {
                func fetchData() async
            }
            """,
            expandedSource: """
            protocol AsyncProtocol {
                func fetchData() async
            }

            class AsyncProtocolMock: AsyncProtocol, XCTMockProtocol {
                public var mockClassId = UUID()
            
                public static var context = XCTMockable.ContextContainer()
                public var context = XCTMockable.ContextContainer()

                func fetchData() async -> XCTMockable.Mockable<XCTMockable.FunctionDeclaration, () async -> Void, Void> {
                return XCTMockable.Mockable<XCTMockable.FunctionDeclaration, () async -> Void, Void>(context: context,
                                                                                                                         invocation: XCTMockable.Invocation(key: "func fetchData() async -> Void",
                                                                                                                                                             members: []),
                                                                                                                         returnType: Swift.ObjectIdentifier((Void).self))
                }

                func fetchData() async -> Void {
                    return self.context.mocking.didInvoke(XCTMockable.Invocation(key: "func fetchData() async -> Void",
                                                                                      members: [])) { invocation in

                        let result = self.context.stubbing.implementation(for: invocation)

                            if let result = result {
                    if let result = result as? Void {
                        return result
                    }
                }

                        fatalError("Failed to find a suitable result type.", file: #file, line: #line)
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
    
    func test_product_return() throws {
        #if canImport(XCTMacros)
        assertMacroExpansion(
            """
            @Mockable
            protocol AsyncProtocol {
                func fetchData() async -> Product
            }
            """,
            expandedSource: """
            protocol AsyncProtocol {
                func fetchData() async -> Product
            }

            class AsyncProtocolMock: AsyncProtocol, XCTMockProtocol {
                public var mockClassId = UUID()
            
                public static var context = XCTMockable.ContextContainer()
                public var context = XCTMockable.ContextContainer()

                func fetchData() async -> XCTMockable.Mockable<XCTMockable.FunctionDeclaration, () async -> Product, Product> {
                return XCTMockable.Mockable<XCTMockable.FunctionDeclaration, () async -> Product, Product>(context: context,
                                                                                                                         invocation: XCTMockable.Invocation(key: "func fetchData() async -> Product",
                                                                                                                                                             members: []),
                                                                                                                         returnType: Swift.ObjectIdentifier((Product).self))
                }

                func fetchData() async -> Product {
                    return self.context.mocking.didInvoke(XCTMockable.Invocation(key: "func fetchData() async -> Product",
                                                                                      members: [])) { invocation in

                        let result = self.context.stubbing.implementation(for: invocation)

                            if let result = result {
                    if let result = result as? Product {
                        return result
                    }
                }

                        fatalError("Failed to find a suitable result type.", file: #file, line: #line)
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
    
    func test_primitive_return() throws {
        #if canImport(XCTMacros)
        assertMacroExpansion(
            """
            @Mockable
            protocol AsyncProtocol {
                func getProductPrice(id: Int) async -> Float
            }
            """,
            expandedSource: """
            protocol AsyncProtocol {
                func getProductPrice(id: Int) async -> Float
            }

            class AsyncProtocolMock: AsyncProtocol, XCTMockProtocol {
                public var mockClassId = UUID()
            
                public static var context = XCTMockable.ContextContainer()
                public var context = XCTMockable.ContextContainer()

                func getProductPrice(id: Int) async -> XCTMockable.Mockable<XCTMockable.FunctionDeclaration, (_ id: Int) async -> Float, Float> {
                return XCTMockable.Mockable<XCTMockable.FunctionDeclaration, (_ id: Int) async -> Float, Float>(context: context,
                                                                                                                         invocation: XCTMockable.Invocation(key: "func getProductPrice(id: Int) async -> Float",
                                                                                                                                                             members: [XCTMockable.InvocationMember(base: id)]),
                                                                                                                         returnType: Swift.ObjectIdentifier((Float).self))
                }

                func getProductPrice(id: Int) async -> Float {
                    return self.context.mocking.didInvoke(XCTMockable.Invocation(key: "func getProductPrice(id: Int) async -> Float",
                                                                                      members: [XCTMockable.InvocationMember(base: id)])) { invocation in

                        let result = self.context.stubbing.implementation(for: invocation)

                            if let result = result {
                    if let result = result as? Float {
                        return result
                    }
                }

                        fatalError("Failed to find a suitable result type.", file: #file, line: #line)
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
            protocol AsyncProtocol {
                func doesProductExist(id: Int) async -> Bool?
            }
            """,
            expandedSource: """
            protocol AsyncProtocol {
                func doesProductExist(id: Int) async -> Bool?
            }

            class AsyncProtocolMock: AsyncProtocol, XCTMockProtocol {
                public var mockClassId = UUID()
            
                public static var context = XCTMockable.ContextContainer()
                public var context = XCTMockable.ContextContainer()

                func doesProductExist(id: Int) async -> XCTMockable.Mockable<XCTMockable.FunctionDeclaration, (_ id: Int) async -> Bool?, Bool?> {
                return XCTMockable.Mockable<XCTMockable.FunctionDeclaration, (_ id: Int) async -> Bool?, Bool?>(context: context,
                                                                                                                         invocation: XCTMockable.Invocation(key: "func doesProductExist(id: Int) async -> Bool?",
                                                                                                                                                             members: [XCTMockable.InvocationMember(base: id)]),
                                                                                                                         returnType: Swift.ObjectIdentifier((Bool?).self))
                }

                func doesProductExist(id: Int) async -> Bool? {
                    return self.context.mocking.didInvoke(XCTMockable.Invocation(key: "func doesProductExist(id: Int) async -> Bool?",
                                                                                      members: [XCTMockable.InvocationMember(base: id)])) { invocation in

                        let result = self.context.stubbing.implementation(for: invocation)

                            if let result = result {
                    if let result = result as? Bool {
                        return result
                    }

                    return nil
                }

                        fatalError("Failed to find a suitable result type.", file: #file, line: #line)
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
