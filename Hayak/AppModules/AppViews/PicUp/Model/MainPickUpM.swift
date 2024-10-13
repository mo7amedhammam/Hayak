//
//  MainPickUpM.swift
//  Hayak
//
//  Created by wecancity on 13/10/2024.
//

import Foundation

// MARK: - PickupCategoriesM
struct CategoriesM: Codable {
    var items: [CategoriesItem]?
    var totalCount: Int?
}

// MARK: - Item
struct CategoriesItem: Codable,Hashable {
    static func == (lhs: CategoriesItem, rhs: CategoriesItem) -> Bool {
       return lhs.id == rhs.id
    }
    
    var id: Int?
    var name, imageURL: String?
    var brandID: Int?
    var brands: [CategoriesBrand]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "imageUrl"
        case brandID = "brandId"
        case brands
    }
}

// MARK: - Brand
struct CategoriesBrand: Codable,Hashable {
    static func == (lhs: CategoriesBrand, rhs: CategoriesBrand) -> Bool {
       return lhs.id == rhs.id
    }
    var id: Int?
    var name, description, descriptionEn, bannerURL: String?

    enum CodingKeys: String, CodingKey {
        case id, name, description, descriptionEn
        case bannerURL = "bannerUrl"
    }
}
