//
//  CheckoutM.swift
//  Hayak
//
//  Created by wecancity on 27/10/2024.
//

import Foundation

// MARK: - CheckoutM
struct CheckoutM: Codable {
    var cartItems: [CheckoutCartItem]?
    var totalPrice, subTotal, tax, discount: Int?
}

// MARK: - CheckoutCartItem
struct CheckoutCartItem: Codable , Identifiable,Hashable,Equatable {
    static func == (lhs: CheckoutCartItem, rhs: CheckoutCartItem) -> Bool {
        return lhs.itemID == rhs.itemID
    }
    
    let id = UUID()
    var customerCartID, itemID, itemPrice: Int?
    var itemName: String?
    var customerID, qty: Int?
    var itemAttributeValues: [ItemAttributeValue]?

    enum CodingKeys: String, CodingKey {
        case customerCartID = "customerCartId"
        case itemID = "itemId"
        case itemPrice, itemName
        case customerID = "customerId"
        case qty, itemAttributeValues
    }
}

// MARK: - ItemAttributeValue
struct ItemAttributeValue: Codable , Identifiable ,Hashable{
    let id = UUID()
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


extension CheckoutM {
    func toDictionary() -> [String: Any]? {
        // Attempt to encode the instance as JSON data
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase // Use this to handle any other snake_case conversions
        guard let jsonData = try? encoder.encode(self) else { return nil }
        
        // Decode JSON data back to a dictionary format
        return (try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments))
            as? [String: Any]
    }
}
