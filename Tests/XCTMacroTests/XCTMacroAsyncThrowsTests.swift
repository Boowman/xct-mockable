//
//  XCTMacroAsyncThrowsTests.swift
//  
//
//  Created by Lenard Pop on 10/05/2024.
//

import Foundation
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport

final class XCTMacroAsyncThrowsTests: XCTMacroBaseTests {
    func test_void_return() throws {
        #if canImport(XCTMacros)
        assertMacroExpansion(
            """
            @Mockable
            protocol AsyncThrowsProtocol {
                func fetchData() async throws
            }
            """,
            expandedSource: """
            protocol AsyncThrowsProtocol {
                func fetchData() async throws
            }

            class AsyncThrowsProtocolMock: AsyncThrowsProtocol, XCTMockProtocol {
                public var mockClassId = UUID()
            
                public static var context = XCTMockable.ContextContainer()
                public var context = XCTMockable.ContextContainer()

                func fetchData() async throws -> XCTMockable.Mockable<XCTMockable.FunctionDeclaration, () async throws -> Void, Void> {
                return XCTMockable.Mockable<XCTMockable.FunctionDeclaration, () async throws -> Void, Void>(context: context,
                                                                                                                         invocation: XCTMockable.Invocation(key: "func fetchData() async throws -> Void",
                                                                                                                                                             members: []),
                                                                                                                         returnType: Swift.ObjectIdentifier((Void).self))
                }

                func fetchData() async throws -> Void {
                    return self.context.mocking.didInvoke(XCTMockable.Invocation(key: "func fetchData() async throws -> Void",
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
            protocol AsyncThrowsProtocol {
                func fetchData() async throws -> Product
            }
            """,
            expandedSource: """
            protocol AsyncThrowsProtocol {
                func fetchData() async throws -> Product
            }

            class AsyncThrowsProtocolMock: AsyncThrowsProtocol, XCTMockProtocol {
                public var mockClassId = UUID()
            
                public static var context = XCTMockable.ContextContainer()
                public var context = XCTMockable.ContextContainer()

                func fetchData() async throws -> XCTMockable.Mockable<XCTMockable.FunctionDeclaration, () async throws -> Product, Product> {
                return XCTMockable.Mockable<XCTMockable.FunctionDeclaration, () async throws -> Product, Product>(context: context,
                                                                                                                         invocation: XCTMockable.Invocation(key: "func fetchData() async throws -> Product",
                                                                                                                                                             members: []),
                                                                                                                         returnType: Swift.ObjectIdentifier((Product).self))
                }

                func fetchData() async throws -> Product {
                    return self.context.mocking.didInvoke(XCTMockable.Invocation(key: "func fetchData() async throws -> Product",
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
    
    func test_product_return_with_parameter() throws {
        #if canImport(XCTMacros)
        assertMacroExpansion(
            """
            @Mockable
            protocol AsyncThrowsProtocol {
                func fetchProduct(id: Int) async throws -> Product
            }
            """,
            expandedSource: """
            protocol AsyncThrowsProtocol {
                func fetchProduct(id: Int) async throws -> Product
            }

            class AsyncThrowsProtocolMock: AsyncThrowsProtocol, XCTMockProtocol {
                public var mockClassId = UUID()
            
                public static var context = XCTMockable.ContextContainer()
                public var context = XCTMockable.ContextContainer()

                func fetchProduct(id: Int) async throws -> XCTMockable.Mockable<XCTMockable.FunctionDeclaration, (_ id: Int) async throws -> Product, Product> {
                return XCTMockable.Mockable<XCTMockable.FunctionDeclaration, (_ id: Int) async throws -> Product, Product>(context: context,
                                                                                                                         invocation: XCTMockable.Invocation(key: "func fetchProduct(id: Int) async throws -> Product",
                                                                                                                                                             members: [XCTMockable.InvocationMember(base: id)]),
                                                                                                                         returnType: Swift.ObjectIdentifier((Product).self))
                }

                func fetchProduct(id: Int) async throws -> Product {
                    return self.context.mocking.didInvoke(XCTMockable.Invocation(key: "func fetchProduct(id: Int) async throws -> Product",
                                                                                      members: [XCTMockable.InvocationMember(base: id)])) { invocation in

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
            protocol AsyncThrowsProtocol {
                func getProductPrice(id: Int) async throws -> Float
            }
            """,
            expandedSource: """
            protocol AsyncThrowsProtocol {
                func getProductPrice(id: Int) async throws -> Float
            }

            class AsyncThrowsProtocolMock: AsyncThrowsProtocol, XCTMockProtocol {
                public var mockClassId = UUID()
            
                public static var context = XCTMockable.ContextContainer()
                public var context = XCTMockable.ContextContainer()

                func getProductPrice(id: Int) async throws -> XCTMockable.Mockable<XCTMockable.FunctionDeclaration, (_ id: Int) async throws -> Float, Float> {
                return XCTMockable.Mockable<XCTMockable.FunctionDeclaration, (_ id: Int) async throws -> Float, Float>(context: context,
                                                                                                                         invocation: XCTMockable.Invocation(key: "func getProductPrice(id: Int) async throws -> Float",
                                                                                                                                                             members: [XCTMockable.InvocationMember(base: id)]),
                                                                                                                         returnType: Swift.ObjectIdentifier((Float).self))
                }

                func getProductPrice(id: Int) async throws -> Float {
                    return self.context.mocking.didInvoke(XCTMockable.Invocation(key: "func getProductPrice(id: Int) async throws -> Float",
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
            protocol AsyncThrowsProtocol {
                func doesProductExist(id: Int) async throws -> Bool?
            }
            """,
            expandedSource: """
            protocol AsyncThrowsProtocol {
                func doesProductExist(id: Int) async throws -> Bool?
            }

            class AsyncThrowsProtocolMock: AsyncThrowsProtocol, XCTMockProtocol {
                public var mockClassId = UUID()
            
                public static var context = XCTMockable.ContextContainer()
                public var context = XCTMockable.ContextContainer()

                func doesProductExist(id: Int) async throws -> XCTMockable.Mockable<XCTMockable.FunctionDeclaration, (_ id: Int) async throws -> Bool?, Bool?> {
                return XCTMockable.Mockable<XCTMockable.FunctionDeclaration, (_ id: Int) async throws -> Bool?, Bool?>(context: context,
                                                                                                                         invocation: XCTMockable.Invocation(key: "func doesProductExist(id: Int) async throws -> Bool?",
                                                                                                                                                             members: [XCTMockable.InvocationMember(base: id)]),
                                                                                                                         returnType: Swift.ObjectIdentifier((Bool?).self))
                }

                func doesProductExist(id: Int) async throws -> Bool? {
                    return self.context.mocking.didInvoke(XCTMockable.Invocation(key: "func doesProductExist(id: Int) async throws -> Bool?",
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
