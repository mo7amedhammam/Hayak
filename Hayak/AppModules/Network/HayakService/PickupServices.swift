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
    
}

extension PickupServices : TargetType {
    var path: String {
        switch self {
        case .Categories:
            return PickupEndPoints.Categories.rawValue

        case .NearestBrandBranches:
            return PickupEndPoints.NearestBrandBranches.rawValue
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .NearestBrandBranches:
            return .post
        case .Categories :
            return .get
        }
    }
    
    var parameter: parameterType {
        switch self {
        case .Categories:
            return .plainRequest
            
        case .NearestBrandBranches(parameters:let parameters):
            return .parameterRequest(Parameters: parameters, Encoding: .default)
            
//        case .SendFirebaseToken(parameters: let parameters):
//            return .parameterdGetRequest(Parameters: parameters, Encoding: .default)
            
        }
    }
}
