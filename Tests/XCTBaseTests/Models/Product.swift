//
//  Product.swift
//  
//
//  Created by Lenard Pop on 20/02/2024.
//

import Foundation

struct Product: Equatable {
    var id: String
    var title: String
    var date: Date
    var price: Float
    
    public static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
}
