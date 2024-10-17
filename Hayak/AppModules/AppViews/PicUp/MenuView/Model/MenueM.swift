//
//  MenueM.swift
//  Hayak
//
//  Created by wecancity on 17/10/2024.
//

import Foundation

// MARK: - NearestBrandBrancheM
struct BrandBrancheMenuM: Codable,Hashable {
    var id: Int?
    var address: String?
    var rate: Double?
    var availablePickup, availableDineIn: Bool?
    var items: [BrandBrancheMenuItemM]?
}

// MARK: - Item
struct BrandBrancheMenuItemM: Codable ,Hashable{
    var id, name, description: String?
    var price, calories: Int?
    var imageURL: String?

    enum CodingKeys: String, CodingKey {
        case id, name, description, price, calories
        case imageURL = "imageUrl"
    }
}
