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
struct NearestBrandBrancheM: Codable,Hashable {
    var id: Int?
    var branchName: String?
    var rate, ratingCount: Int?
    var bannerURL: String?
    var favourite: Bool?
    var distance: Double?
    var resturantType: String?
    var isRecommended: Bool?
    var averageOrderTime: Int?

    enum CodingKeys: String, CodingKey {
        case id, branchName, rate, ratingCount
        case bannerURL = "bannerUrl"
        case favourite, distance, resturantType, isRecommended
        case averageOrderTime
    }
}

// MARK: - favourite menue
//{
//      "id": 0,
//      "branchName": "string",
//      "rate": 0,
//      "ratingCount": 0,
//      "bannerUrl": "string",
//      "favourite": true,
//      "distance": 0,
//      "resturantType": "string",
//      "isRecommended": true,
//      "customerId": 0,
//      "customerName": "string",
//      "averageOrderTime": 0,
//      "categoryList": [
//        {
//          "id": 0,
//          "name": "string"
//        }
//      ]
//    }
