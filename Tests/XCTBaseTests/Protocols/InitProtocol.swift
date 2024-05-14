//
//  InitProtocol.swift
//
//
//  Created by Lenard Pop on 28/04/2024.
//

import Foundation
import XCTMockable

@Mockable
protocol InitProtocol {
    init()
    init(key keyValue: String, jsonValue: String)
}
