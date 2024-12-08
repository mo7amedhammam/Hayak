//
//  PickupServices.swift
//  Hayak
//
//  Created by wecancity on 13/10/2024.
//

import Foundation
import Alamofire

enum PickupServices {
    case Categories
    case NearestBrandBranches(parameters : [String:Any])
    
    case CategoryForList
    case BrandBranchDetails(parameters : [String:Any])
    
    case GetItemDetailsView(parameters : [String:Any])
    case AddToCart(parameters : [String:Any])

    case GetCheckout
    case DeleteFromCart(parameters : [String:Any])
    case ConfirmCheckout(parameters : [String:Any])
    case CustomerFavourite(parameters : [String:Any])
    case AddToFavourit(parameters : [String:Any])


}

extension PickupServices : TargetType {
    var path: String {
        switch self {
        case .Categories:
            return PickupEndPoints.Categories.rawValue
        case .NearestBrandBranches:
            return PickupEndPoints.NearestBrandBranches.rawValue
            
        case .CategoryForList:
            return PickupEndPoints.CategoryForList.rawValue
        case .BrandBranchDetails:
            return PickupEndPoints.BrandBranchDetails.rawValue
            
        case .GetItemDetailsView:
            return PickupEndPoints.GetItemDetailsView.rawValue
        case .AddToCart:
            return PickupEndPoints.AddToCart.rawValue
            
        case .GetCheckout:
            return PickupEndPoints.CheckoutView.rawValue
        case .DeleteFromCart:
            return PickupEndPoints.DeleteFromCart.rawValue
        case .ConfirmCheckout:
            return PickupEndPoints.ConfirmCheckout.rawValue
        case .CustomerFavourite :
            return PickupEndPoints.CustomerFavourite.rawValue
        case .AddToFavourit :
            return PickupEndPoints.AddToFavourit.rawValue
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .NearestBrandBranches, .BrandBranchDetails, .AddToCart, .ConfirmCheckout, .CustomerFavourite, .AddToFavourit :
            return .post
        case .Categories,.CategoryForList,.GetItemDetailsView,.GetCheckout,.DeleteFromCart :
            return .get
        }
    }
    
    var parameter: parameterType {
        switch self {
        case .Categories,.CategoryForList,.GetCheckout:
            return .plainRequest
            
        case .NearestBrandBranches(parameters:let parameters),
                .BrandBranchDetails(parameters: let parameters),
                .AddToCart(parameters: let parameters),
                .ConfirmCheckout(parameters: let parameters),
                .CustomerFavourite(parameters: let parameters),
                .AddToFavourit(parameters: let parameters) :
            return .parameterRequest(Parameters: parameters, Encoding: .default)
            
        case .GetItemDetailsView(parameters: let parameters),
                .DeleteFromCart(parameters: let parameters):
            return .parameterdGetRequest(Parameters: parameters, Encoding: .default)
            
        }
    }
}
