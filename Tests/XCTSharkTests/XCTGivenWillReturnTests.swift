////
////  XCTGivenWillReturnTests.swift.swift
////
////
////  Created by Lenard Pop on 20/02/2024.
////
//
//import Foundation
//import XCTest
//import XCTSharkMockable
//
//final class XCTWillReturnTests: XCTestCase {
//    
//    private let mock = GivenProtocolMock()
//    private let product = Product(id: "x125", title: "Title", date: Date(timeIntervalSince1970: 1708387889), price: 49.99)
//    
//    func test_fetchProducts() throws {
//        // Arrange
//        given(mock.fetchProducts()).willReturn([product])
//        
//        // Act
//        let result: [Product] = mock.fetchProducts()
//        
//        // Assert
//        XCTAssertEqual(product, result.first!)
//    }
//    
//    func test_fetchProduct_StringId() throws {
//        // Arrange
//        given(mock.fetchProduct(id: "xxxx")).willReturn(product)
//        
//        // Act
//        let result: Product = mock.fetchProduct(id: "xxxx")
//        
//        // Assert
//        XCTAssertEqual(product, result)
//    }
//    
//    func test_fetchProduct_IntId() throws {
//        // Arrange
//        given(mock.fetchProduct(id: 2)).willReturn(product)
//        
//        // Act
//        let result: Product = mock.fetchProduct(id: 2)
//        
//        // Assert
//        XCTAssertEqual(product, result)
//    }
//
//    func test_fetchDoesProductExist_True() throws {
//        // Arrange
//        given(mock.doesProductExist(id: "xxx")).willReturn(true)
//        
//        // Act
//        let result: Bool? = mock.doesProductExist(id: "xxx")
//        
//        // Assert
//        XCTAssertTrue(result ?? false)
//    }
//    
//    func test_fetchDoesProductExist_False() throws {
//        // Arrange
//        given(mock.doesProductExist(id: "xxx")).willReturn(false)
//        
//        // Act
//        let result: Bool? = mock.doesProductExist(id: "xxx")
//        
//        // Assert
//        XCTAssertFalse(result ?? true)
//    }
//    
//    func test_fetchDoesProductExist_Nil() throws {
//        // Arrange
//        given(mock.doesProductExist(id: "xxx")).willReturn(nil)
//        
//        // Act
//        let result: Bool? = mock.doesProductExist(id: "xxx")
//        
//        // Assert
//        XCTAssertFalse(result ?? true)
//    }
//    
//    
//    func test_fetchDoesProductGetPrice_Double() throws {
//        // Arrange
//        given(mock.getProductPrice(id: "xxx")).willReturn(49.99)
//        
//        // Act
//        let result: Double = mock.getProductPrice(id: "xxx")
//        
//        // Assert
//        XCTAssertEqual(49.99, result)
//    }
//    
//    func test_fetchDoesProductGetPrice_Float() throws {
//        // Arrange
//        given(mock.getProductPrice(id: 25)).willReturn(49.0)
//        
//        // Act
//        let result: Float = mock.getProductPrice(id: 25)
//        
//        // Assert
//        XCTAssertEqual(49.0, result)
//    }
//    
//    //
//    // MARK: To Implement Nil Return
//    //
//    //    func test_fetchProductReturnNil() throws {
//    //        // Arrange
//    //        given(mock.fetchProduct(id: 2)).willReturn(nil)
//    //
//    //        // Act
//    //        let result: [Product] = mock.fetchProducts()
//    //
//    //        // Assert
//    //        XCTAssertEqual(product, result.first!)
//    //    }
//        
//}
