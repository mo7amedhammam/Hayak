//
//  MainPickUpM.swift
//  Hayak
//
//  Created by wecancity on 13/10/2024.
//

import Foundation

// MARK: - PickupCategoriesM
struct MainCategoriesM: Codable,Hashable {
        var id: Int?
        var name, imageURL: String?
   
       enum CodingKeys: String, CodingKey {
           case id, name
           case imageURL = "mainCategoryPath"
       }
}

// MARK: - NearestBrandBrancheM
struct NearestBrandBrancheM: Codable {
    var id: Int?
    var branchName: String?
    var rate, ratingCount: Int?
    var bannerURL: String?
    var favourite: Bool?
    var distance: Int?
    var resturantType: String?
    var isRecommended: Bool?

    enum CodingKeys: String, CodingKey {
        case id, branchName, rate, ratingCount
        case bannerURL = "bannerUrl"
        case favourite, distance, resturantType, isRecommended
    }
}
