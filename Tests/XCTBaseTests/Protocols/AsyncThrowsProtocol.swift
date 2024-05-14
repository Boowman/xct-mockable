//
//  AsyncThrowsProtocol.swift
//
//
//  Created by Lenard Pop on 23/03/2024.
//

import Foundation
import XCTMockable

@Mockable
protocol AsyncThrowsProtocol {
    func fetchData() async throws -> Product
    func fetchProduct(id: Int) async throws -> Product
    func getProductPrice(id: Int) async throws -> Float
    func doesProductExist(id: Int) async throws -> Bool?
}
