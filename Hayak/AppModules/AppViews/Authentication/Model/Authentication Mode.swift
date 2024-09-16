//
//  Authentication Mode.swift
//  Hayak
//
//  Created by Mohamed Ragab on 16/09/2024.
//

import Foundation


struct SignUpResponse: Codable {
    let success: Bool
    let message: String
}

struct LoginResponse: Codable {
    let name: String
    let mobile: String
    let genderId: Int
    let birthDate: String
    let email: String
    let address: String
    let cityId: Int
    let creationDate: String 
    let id: Int
    let token : String
}


struct ChangePasswordResponse: Codable {
    let name: String
    let mobile: String
    let genderId: Int
    let birthDate: String
    let email: String
    let address: String
    let cityId: Int
    let creationDate: String
    let id: Int
}
