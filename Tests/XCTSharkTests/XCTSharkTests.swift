import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(XCTSharkMacros)
import XCTSharkMacros

let testMacros: [String: Macro.Type] = [
    "Mockable": MockableMacro.self,
]
#endif

final class XCTSharkTests: XCTestCase {
    func testMacro() throws {
        #if canImport(XCTSharkMacros)
        assertMacroExpansion(
            """
            @Mockable
            protocol ProductsServiceProtocol {
                init(apiKey: String)
            }
            """,
            expandedSource: """
            protocol ProductsServiceProtocol {
                init(apiKey: String)
            }

            class ProductsServiceProtocolMock: ProductsServiceProtocol, XCTSharkMockProtocol {
                internal var context = ContextContainer()

                func fetchProducts(id: [String], ids: [Int]) async throws -> Mockable<String?> {
                    return Mockable(context: context,
                                    invocation: Invocation(key: "fetchProducts(id: [String], ids: [Int])",
                                                           members: [InvocationMember(base: id), InvocationMember(base: ids)]),
                                    returnType: Swift.ObjectIdentifier((String?).self))
                }

                func fetchProducts(id: [String], ids: [Int]) async throws -> String? {
                    return context.mockingContext.didInvoke(Invocation(key: "fetchProducts(id: [String], ids: [Int])",
                                                                       members: [InvocationMember(base: id), InvocationMember(base: ids)])) { results in
                        if let result = results as? String {
                            return result
                        }

                        fatalError("Failed to find a suitable result type.",
                                   file: #file,
                                   line: #line)
                    }
                }
            
                static public func fetchProducts(id: [String]) throws -> Mockable<[String]?> {
                    return Mockable(context: context,
                                    invocation: Invocation(key: "fetchProducts(id: [String])",
                                                           members: [InvocationMember(base: id)]),
                                    returnType: Swift.ObjectIdentifier((String?).self))
                }

                static public func fetchProducts(id: [String]) throws -> [String]? {
                    return context.mockingContext.didInvoke(Invocation(key: "fetchProducts(id: [String])",
                                                                       members: [InvocationMember(base: id)])) { results in
                        if let result = results as? [String]? {
                            return result
                        }

                        fatalError("Failed to find a suitable result type.",
                                   file: #file,
                                   line: #line)
                    }
                }
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
}
