//
//  File.swift
//  
//
//  Created by Lenard Pop on 20/02/2024.
//

import Foundation
import XCTSharkMockable

@Mockable
protocol GivenProtocol {
    var product: Product { get set }
    var productTitle: String? { get set }

    init(apiKey: String)
    
    func fetchProducts() async -> [Product]
    static func fetchProducts(ids: [String]) async throws -> [Product]
    
    func fetchProduct(id: String) throws -> Product
    func fetchProduct(id: Int) -> Product
    
    func getProductPrice(id: String) -> Double
    func getProductPrice(id: Int) -> Float
    
    func doesProductExist(id: String) -> Bool?
}
