// The Swift Programming Language
// https://docs.swift.org/swift-book

@attached(peer, names: suffixed(Mock))
public macro Mockable() = #externalMacro(module: "XCTSharkMacros", type: "MockableMacro")
