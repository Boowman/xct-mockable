////
////  ExprSyntax+Extensions.swift
////
////
////  Created by Lenard Pop on 14/02/2024.
////
//
//import Foundation
//import SwiftSyntax
//
//extension ExprSyntax {
//    func getType() -> String {
//        if StringLiteralExprSyntax(self) != nil {
//            return "String"
//        } else if let member = MemberAccessExprSyntax(self) {
//            return member.base?.trimmedDescription ?? ""
//        } else if let function = FunctionCallExprSyntax(self) {
//            return function.calledExpression.trimmedDescription
//        }
//        
//        return ""
//    }
//}
