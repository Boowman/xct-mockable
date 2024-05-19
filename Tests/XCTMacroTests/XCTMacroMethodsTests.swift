//
//  XCTMacroMethodsTests.swift
//
//
//  Created by Lenard Pop on 10/05/2024.
//

import Foundation
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport

final class XCTMacroMethodsTests: XCTMacroBaseTests {
    func test_void_return() throws {
        #if canImport(XCTMacros)
        assertMacroExpansion(
            """
            @Mockable
            protocol MethodsProtocol {
                func update(id: String)
            }
            """,
            expandedSource: """
            protocol MethodsProtocol {
                func update(id: String)
            }

            class MethodsProtocolMock: MethodsProtocol, XCTMockProtocol {
                public var mockClassId = UUID()
            
                public static var context = XCTMockable.ContextContainer()
                public var context = XCTMockable.ContextContainer()

                func update(id: String) -> XCTMockable.Mockable<XCTMockable.FunctionDeclaration, (_ id: String) -> Void, Void> {
                return XCTMockable.Mockable<XCTMockable.FunctionDeclaration, (_ id: String) -> Void, Void>(context: context,
                                                                                                                         invocation: XCTMockable.Invocation(key: "func update(id: String) -> Void",
                                                                                                                                                             members: [XCTMockable.InvocationMember(base: id)]),
                                                                                                                         returnType: Swift.ObjectIdentifier((Void).self))
                }

                func update(id: String) -> Void {
                    return self.context.mocking.didInvoke(XCTMockable.Invocation(key: "func update(id: String) -> Void",
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
    
    func test_variadic_parameters() throws {
        #if canImport(XCTMacros)
        assertMacroExpansion(
            """
            @Mockable
            protocol MethodsProtocol {
                func fetchContents(_ ids: String...) -> String
            }
            """,
            expandedSource: """
            protocol MethodsProtocol {
                func fetchContents(_ ids: String...) -> String
            }

            class MethodsProtocolMock: MethodsProtocol, XCTMockProtocol {
                public var mockClassId = UUID()
            
                public static var context = XCTMockable.ContextContainer()
                public var context = XCTMockable.ContextContainer()

                func fetchContents(_ ids: String...) -> XCTMockable.Mockable<XCTMockable.FunctionDeclaration, (_ ids: String...) -> String, String> {
                return XCTMockable.Mockable<XCTMockable.FunctionDeclaration, (_ ids: String...) -> String, String>(context: context,
                                                                                                                         invocation: XCTMockable.Invocation(key: "func fetchContents(_ ids: String...) -> String",
                                                                                                                                                             members: [XCTMockable.InvocationMember(base: ids)]),
                                                                                                                         returnType: Swift.ObjectIdentifier((String).self))
                }

                func fetchContents(_ ids: String...) -> String {
                    return self.context.mocking.didInvoke(XCTMockable.Invocation(key: "func fetchContents(_ ids: String...) -> String",
                                                                                      members: [XCTMockable.InvocationMember(base: ids)])) { invocation in

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
    
    func test_nullable_array_return() throws {
        #if canImport(XCTMacros)
        assertMacroExpansion(
            """
            @Mockable
            protocol MethodsProtocol {
                func fetchProduct(id: Int, key: String) -> [Product]?
            }
            """,
            expandedSource: """
            protocol MethodsProtocol {
                func fetchProduct(id: Int, key: String) -> [Product]?
            }

            class MethodsProtocolMock: MethodsProtocol, XCTMockProtocol {
                public var mockClassId = UUID()
            
                public static var context = XCTMockable.ContextContainer()
                public var context = XCTMockable.ContextContainer()

                func fetchProduct(id: Int, key: String) -> XCTMockable.Mockable<XCTMockable.FunctionDeclaration, (_ id: Int, _ key: String) -> [Product]?, [Product]?> {
                return XCTMockable.Mockable<XCTMockable.FunctionDeclaration, (_ id: Int, _ key: String) -> [Product]?, [Product]?>(context: context,
                                                                                                                         invocation: XCTMockable.Invocation(key: "func fetchProduct(id: Int, key: String) -> [Product]?",
                                                                                                                                                             members: [XCTMockable.InvocationMember(base: id), XCTMockable.InvocationMember(base: key)]),
                                                                                                                         returnType: Swift.ObjectIdentifier(([Product]?).self))
                }

                func fetchProduct(id: Int, key: String) -> [Product]? {
                    return self.context.mocking.didInvoke(XCTMockable.Invocation(key: "func fetchProduct(id: Int, key: String) -> [Product]?",
                                                                                      members: [XCTMockable.InvocationMember(base: id), XCTMockable.InvocationMember(base: key)])) { invocation in

                        let result = self.context.stubbing.implementation(for: invocation)

                            if let result = result {
                    if let result = result as? [Product] {
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
    
    func test_product_return() throws {
        #if canImport(XCTMacros)
        assertMacroExpansion(
            """
            @Mockable
            protocol MethodsProtocol {
                func fetchProduct(id: Int) -> Product
            }
            """,
            expandedSource: """
            protocol MethodsProtocol {
                func fetchProduct(id: Int) -> Product
            }

            class MethodsProtocolMock: MethodsProtocol, XCTMockProtocol {
                public var mockClassId = UUID()
            
                public static var context = XCTMockable.ContextContainer()
                public var context = XCTMockable.ContextContainer()

                func fetchProduct(id: Int) -> XCTMockable.Mockable<XCTMockable.FunctionDeclaration, (_ id: Int) -> Product, Product> {
                return XCTMockable.Mockable<XCTMockable.FunctionDeclaration, (_ id: Int) -> Product, Product>(context: context,
                                                                                                                         invocation: XCTMockable.Invocation(key: "func fetchProduct(id: Int) -> Product",
                                                                                                                                                             members: [XCTMockable.InvocationMember(base: id)]),
                                                                                                                         returnType: Swift.ObjectIdentifier((Product).self))
                }

                func fetchProduct(id: Int) -> Product {
                    return self.context.mocking.didInvoke(XCTMockable.Invocation(key: "func fetchProduct(id: Int) -> Product",
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
    
    func test_string_return() throws {
        #if canImport(XCTMacros)
        assertMacroExpansion(
            """
            @Mockable
            protocol MethodsProtocol {
                func fetchData() -> String
            }
            """,
            expandedSource: """
            protocol MethodsProtocol {
                func fetchData() -> String
            }

            class MethodsProtocolMock: MethodsProtocol, XCTMockProtocol {
                public var mockClassId = UUID()
            
                public static var context = XCTMockable.ContextContainer()
                public var context = XCTMockable.ContextContainer()

                func fetchData() -> XCTMockable.Mockable<XCTMockable.FunctionDeclaration, () -> String, String> {
                return XCTMockable.Mockable<XCTMockable.FunctionDeclaration, () -> String, String>(context: context,
                                                                                                                         invocation: XCTMockable.Invocation(key: "func fetchData() -> String",
                                                                                                                                                             members: []),
                                                                                                                         returnType: Swift.ObjectIdentifier((String).self))
                }

                func fetchData() -> String {
                    return self.context.mocking.didInvoke(XCTMockable.Invocation(key: "func fetchData() -> String",
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

    func test_attributes() throws {
        #if canImport(XCTMacros)
        assertMacroExpansion(
            """
            @Mockable
            protocol MethodsProtocol {
                @available(*, deprecated, message: "Use a different method instead")
                func fetchData() -> String
            }
            """,
            expandedSource: """
            protocol MethodsProtocol {
                @available(*, deprecated, message: "Use a different method instead")
                func fetchData() -> String
            }

            class MethodsProtocolMock: MethodsProtocol, XCTMockProtocol {
                public var mockClassId = UUID()

                public static var context = XCTMockable.ContextContainer()
                public var context = XCTMockable.ContextContainer()

                @available(*, deprecated, message: "Use a different method instead")
                func fetchData() -> XCTMockable.Mockable<XCTMockable.FunctionDeclaration, () -> String, String> {
                return XCTMockable.Mockable<XCTMockable.FunctionDeclaration, () -> String, String>(context: context,
                                                                                                                         invocation: XCTMockable.Invocation(key: "func fetchData() -> String",
                                                                                                                                                             members: []),
                                                                                                                         returnType: Swift.ObjectIdentifier((String).self))
                }

                func fetchData() -> String {
                    return self.context.mocking.didInvoke(XCTMockable.Invocation(key: "func fetchData() -> String",
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
}
