// The Swift Programming Language
// https://docs.swift.org/swift-book

@attached(peer, names: suffixed(Mock))
public macro Mockable() = #externalMacro(module: "XCTMacros", type: "MockableMacro")

@attached(peer, names: overloaded, suffixed(Mock))
public macro Mockable(_ value: (String, Any)...) = #externalMacro(module: "XCTMacros", type: "MockableMacro")
