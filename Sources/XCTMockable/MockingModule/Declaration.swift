//
//  Declaration.swift
//  
//
//  Created by Lenard Pop on 26/02/2024.
//

/// All mockable declaration types conform to this protocol.
public protocol Declaration {}

/// Mockable declarations.
public class AnyDeclaration: Declaration {}

/// Mockable variable declarations.
public class VariableDeclaration: Declaration {}

/// Mockable property getter declarations.
public class PropertyGetterDeclaration: VariableDeclaration {}

/// Mockable property setter declarations.
public class PropertySetterDeclaration: VariableDeclaration {}

/// Mockable function declarations.
public class FunctionDeclaration: Declaration {}

/// Mockable async function declarations.
public class AsyncFunctionDeclaration: FunctionDeclaration {}

/// Mockable throwing function declarations.
public class ThrowingFunctionDeclaration: FunctionDeclaration {}

/// Mockable throwing async function declarations.
public class ThrowingAsyncFunctionDeclaration: AsyncFunctionDeclaration {}
