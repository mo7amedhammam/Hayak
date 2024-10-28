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
    var attributeValueID, attributeValuePrice: Int?

    enum CodingKeys: String, CodingKey {
        case itemAttributeValueID = "itemAttributeValueId"
        case attributeValueName
        case attributeValueID = "attributeValueId"
        case attributeValuePrice
    }
}

// MARK: - CustomerCart
struct CustomerCart: Codable {
    var itemID: Int?
    var itemName, description: String?
    var price, calories: Int?
    var imageURL: String?

    enum CodingKeys: String, CodingKey {
        case itemID = "itemId"
        case itemName, description, price, calories
        case imageURL = "imageUrl"
    }
}
