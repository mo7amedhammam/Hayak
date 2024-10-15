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
