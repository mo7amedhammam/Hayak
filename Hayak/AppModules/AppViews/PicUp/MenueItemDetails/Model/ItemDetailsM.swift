//
//  ItemDetailsM.swift
//  Hayak
//
//  Created by wecancity on 27/10/2024.
//

import Foundation

// MARK: - ItemDetailsView
struct ItemDetailsM: Codable {
    var customerCart: CustomerCart?
    var addToCartDetails: [AddToCartDetail]?
}

// MARK: - AddToCartDetail
struct AddToCartDetail: Codable {
    var isRequired: Bool?
    var attributeName: String?
    var attributeID, maxValue, minValue: Int?
    var attributeValues: [AttributeValue]?

    enum CodingKeys: String, CodingKey {
        case isRequired, attributeName
        case attributeID = "attributeId"
        case maxValue, minValue, attributeValues
    }
}

// MARK: - AttributeValue
struct AttributeValue: Codable {
    var itemAttributeValueID: Int?
    var attributeValueName: String?
    var attributeValueID: Int?
    var attributeValuePrice: Float?

    enum CodingKeys: String, CodingKey {
        case itemAttributeValueID = "itemAttributeValueId"
        case attributeValueName
        case attributeValueID = "attributeValueId"
        case attributeValuePrice
    }
}

// MARK: - CustomerCart
struct CustomerCart: Codable,Hashable,Identifiable {
    var id: Int?
    var itemName, description: String?
    var price: Float?
    var calories: Int?
    var imageURL: String?
    var isCustomizable:Bool?

    enum CodingKeys: String, CodingKey {
        case id = "itemId"
        case itemName, description, price, calories
        case imageURL = "imageUrl"
        case isCustomizable
    }
}
