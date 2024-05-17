//
//  XCTErrors.swift
//
//
//  Created by Lenard Pop on 09/02/2024.
//

import Foundation

enum XCTErrors: Error {
    case noMembersFound
}

extension XCTErrors: CustomStringConvertible {
    var description: String {
        switch self {
        case .noMembersFound:
            return "There must be at least 1 member available."
        }
    }
}

extension XCTErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noMembersFound:
            return NSLocalizedString("There must be at least 1 member available.", comment: "No members found.")
        }
    }
}
