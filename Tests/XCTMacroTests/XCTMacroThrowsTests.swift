//
//  XCTMacroThrowsTests.swift
//
//
//  Created by Lenard Pop on 10/05/2024.
//

import Foundation
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport

final class XCTMacroThrowsTests: XCTMacroBaseTests {
    func test_string_return() throws {
        #if canImport(XCTMacros)
        assertMacroExpansion(
            """
            @Mockable
            protocol ThrowsProtocol {
                func fetchData() throws -> String
            }
            """,
            expandedSource: """
            protocol ThrowsProtocol {
                func fetchData() throws -> String
            }

            class ThrowsProtocolMock: ThrowsProtocol, XCTMockProtocol {
                public var mockClassId = UUID()
            
                public static var context = XCTMockable.ContextContainer()
                public var context = XCTMockable.ContextContainer()

                func fetchData() throws -> XCTMockable.Mockable<XCTMockable.FunctionDeclaration, () throws -> String, String> {
                return XCTMockable.Mockable<XCTMockable.FunctionDeclaration, () throws -> String, String>(context: context,
                                                                                                                         invocation: XCTMockable.Invocation(key: "func fetchData() throws -> String",
                                                                                                                                                             members: []),
                                                                                                                         returnType: Swift.ObjectIdentifier((String).self))
                }

                func fetchData() throws -> String {
                    return self.context.mocking.didInvoke(XCTMockable.Invocation(key: "func fetchData() throws -> String",
                                                                                      members: [])) { invocation in

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
            """,
            macros: mockableMacroTest
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    func test_array_return() throws {
        #if canImport(XCTMacros)
        assertMacroExpansion(
            """
            @Mockable
            protocol ThrowsProtocol {
                func fetchProducts(ids: [Int]) throws -> [Product]
            }
            """,
            expandedSource: """
            protocol ThrowsProtocol {
                func fetchProducts(ids: [Int]) throws -> [Product]
            }

            class ThrowsProtocolMock: ThrowsProtocol, XCTMockProtocol {
                public var mockClassId = UUID()
            
                public static var context = XCTMockable.ContextContainer()
                public var context = XCTMockable.ContextContainer()

                func fetchProducts(ids: [Int]) throws -> XCTMockable.Mockable<XCTMockable.FunctionDeclaration, (_ ids: [Int]) throws -> [Product], [Product]> {
                return XCTMockable.Mockable<XCTMockable.FunctionDeclaration, (_ ids: [Int]) throws -> [Product], [Product]>(context: context,
                                                                                                                         invocation: XCTMockable.Invocation(key: "func fetchProducts(ids: [Int]) throws -> [Product]",
                                                                                                                                                             members: [XCTMockable.InvocationMember(base: ids)]),
                                                                                                                         returnType: Swift.ObjectIdentifier(([Product]).self))
                }

                func fetchProducts(ids: [Int]) throws -> [Product] {
                    return self.context.mocking.didInvoke(XCTMockable.Invocation(key: "func fetchProducts(ids: [Int]) throws -> [Product]",
                                                                                      members: [XCTMockable.InvocationMember(base: ids)])) { invocation in

                        let result = self.context.stubbing.implementation(for: invocation)

                            if let result = result {
                    if let result = result as? [Product] {
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
            protocol ThrowsProtocol {
                func fetchProduct(id: Int) throws -> Product
            }
            """,
            expandedSource: """
            protocol ThrowsProtocol {
                func fetchProduct(id: Int) throws -> Product
            }

            class ThrowsProtocolMock: ThrowsProtocol, XCTMockProtocol {
                public var mockClassId = UUID()
            
                public static var context = XCTMockable.ContextContainer()
                public var context = XCTMockable.ContextContainer()

                func fetchProduct(id: Int) throws -> XCTMockable.Mockable<XCTMockable.FunctionDeclaration, (_ id: Int) throws -> Product, Product> {
                return XCTMockable.Mockable<XCTMockable.FunctionDeclaration, (_ id: Int) throws -> Product, Product>(context: context,
                                                                                                                         invocation: XCTMockable.Invocation(key: "func fetchProduct(id: Int) throws -> Product",
                                                                                                                                                             members: [XCTMockable.InvocationMember(base: id)]),
                                                                                                                         returnType: Swift.ObjectIdentifier((Product).self))
                }

                func fetchProduct(id: Int) throws -> Product {
                    return self.context.mocking.didInvoke(XCTMockable.Invocation(key: "func fetchProduct(id: Int) throws -> Product",
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
    
    func test_nullable_return() throws {
        #if canImport(XCTMacros)
        assertMacroExpansion(
            """
            @Mockable
            protocol ThrowsProtocol {
                func fetchProduct(id: Int) throws -> Product?
            }
            """,
            expandedSource: """
            protocol ThrowsProtocol {
                func fetchProduct(id: Int) throws -> Product?
            }

            class ThrowsProtocolMock: ThrowsProtocol, XCTMockProtocol {
                public var mockClassId = UUID()
            
                public static var context = XCTMockable.ContextContainer()
                public var context = XCTMockable.ContextContainer()

                func fetchProduct(id: Int) throws -> XCTMockable.Mockable<XCTMockable.FunctionDeclaration, (_ id: Int) throws -> Product?, Product?> {
                return XCTMockable.Mockable<XCTMockable.FunctionDeclaration, (_ id: Int) throws -> Product?, Product?>(context: context,
                                                                                                                         invocation: XCTMockable.Invocation(key: "func fetchProduct(id: Int) throws -> Product?",
                                                                                                                                                             members: [XCTMockable.InvocationMember(base: id)]),
                                                                                                                         returnType: Swift.ObjectIdentifier((Product?).self))
                }

                func fetchProduct(id: Int) throws -> Product? {
                    return self.context.mocking.didInvoke(XCTMockable.Invocation(key: "func fetchProduct(id: Int) throws -> Product?",
                                                                                      members: [XCTMockable.InvocationMember(base: id)])) { invocation in

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
            """,
            macros: mockableMacroTest
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    func test_void_return() throws {
        #if canImport(XCTMacros)
        assertMacroExpansion(
            """
            @Mockable
            protocol ThrowsProtocol {
                func update(id: String) throws
            }
            """,
            expandedSource: """
            protocol ThrowsProtocol {
                func update(id: String) throws
            }

            class ThrowsProtocolMock: ThrowsProtocol, XCTMockProtocol {
                public var mockClassId = UUID()
            
                public static var context = XCTMockable.ContextContainer()
                public var context = XCTMockable.ContextContainer()

                func update(id: String) throws -> XCTMockable.Mockable<XCTMockable.FunctionDeclaration, (_ id: String) throws -> Void, Void> {
                return XCTMockable.Mockable<XCTMockable.FunctionDeclaration, (_ id: String) throws -> Void, Void>(context: context,
                                                                                                                         invocation: XCTMockable.Invocation(key: "func update(id: String) throws -> Void",
                                                                                                                                                             members: [XCTMockable.InvocationMember(base: id)]),
                                                                                                                         returnType: Swift.ObjectIdentifier((Void).self))
                }

                func update(id: String) throws -> Void {
                    return self.context.mocking.didInvoke(XCTMockable.Invocation(key: "func update(id: String) throws -> Void",
                                                                                      members: [XCTMockable.InvocationMember(base: id)])) { invocation in

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
}
