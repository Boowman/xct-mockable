//
//  AsyncProtocol.swift
//
//
//  Created by Lenard Pop on 23/03/2024.
//

import Foundation
import XCTMockable

@Mockable
protocol AsyncProtocol {
    func fetchData() async -> Product
    func fetchProduct(id: Int) async -> Product
    func getProductPrice(id: Int) async -> Float
    func doesProductExist(id: Int) async -> Bool?
}
