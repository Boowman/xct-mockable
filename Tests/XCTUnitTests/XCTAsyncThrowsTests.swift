//
//  XCTAsyncThrowsTests.swift
//
//
//  Created by Lenard Pop on 20/02/2024.
//

import XCTest
import Foundation
import XCTMockable

@testable import XCTBaseTests

final class XCTAsyncThrowsTests: XCTBaseTests {
    private let product = Product(
        id: "x125",
        title: "Title",
        date: Date(timeIntervalSince1970: 1708387889),
        price: 49.99
    )
    
    func test_fetchData_productReturn() async throws {
        // Arrange
        given(try await asyncThrowsMock.fetchData()).willReturn(product)
        
        // Act
        let result: Product = try await asyncThrowsMock.fetchData()
        
        // Assert
        XCTAssertEqual(product, result)
    }
    
    func test_fetchData_withParameters_productReturn() async throws {
        // Arrange
        given(try await asyncThrowsMock.fetchProduct(id: 2)).willReturn(product)
        
        // Act
        let result: Product = try await asyncThrowsMock.fetchProduct(id: 2)
        
        // Assert
        XCTAssertEqual(product, result)
    }
    
    func test_fetchData_withParameters_typeReturn() async throws {
        // Arrange
        given(try await asyncThrowsMock.getProductPrice(id: 2)).willReturn(2.0)
        
        // Act
        let result: Float = try await asyncThrowsMock.getProductPrice(id: 2)
        
        // Assert
        XCTAssertEqual(2.0, result)
    }
    
    func test_fetchData_withParameters_returnTrue() async throws {
        // Arrange
        given(try await asyncThrowsMock.doesProductExist(id: 2)).willReturn(true)
        
        // Act
        let result: Bool? = try await asyncThrowsMock.doesProductExist(id: 2)
        
        // Assert
        XCTAssertTrue(result ?? false)
    }
    
    func test_fetchData_withParameters_returnFalse() async throws {
        // Arrange
        given(try await asyncThrowsMock.doesProductExist(id: 2)).willReturn(false)
        
        // Act
        let result: Bool? = try await asyncThrowsMock.doesProductExist(id: 2)
        
        // Assert
        XCTAssertFalse(result ?? true)
    }
    
    func test_fetchData_withParameters_returnNil() async throws {
        // Arrange
        given(try await asyncThrowsMock.doesProductExist(id: 2)).willReturn(nil)
        
        // Act
        let result: Bool? = try await asyncThrowsMock.doesProductExist(id: 2)
        
        // Assert
        XCTAssertNil(result)
    }
}
