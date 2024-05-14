//
//  ThrowsProtocol.swift
//
//
//  Created by Lenard Pop on 23/03/2024.
//

import Foundation
import XCTMockable

@Mockable
protocol ThrowsProtocol {
    func fetchData() throws -> String
    func fetchProducts(ids: [Int]) throws -> [Product]
    func fetchProduct(id: Int) throws -> Product
}
