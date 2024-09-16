//
//  Authintications.swift
//  MrS-Cool
//
//  Created by wecancity on 16/10/2023.
//

import Foundation
import Alamofire


//case Signup = "Customer/Create"
//case Signin = "Customer/Login"
//case ChangePassword = "Customer/ChangePassword"
//case SendOTP = "Customer/SendOTP"
//case VerifyOTP = "Customer/VerifyOTP"
//case ResetPassword = "Customer/ResetPassword"

enum Authintications {
    case Create(parameters : [String:Any])
    case Login(parameters : [String:Any])
    case ChangePassword(parameters : [String:Any])
    case SendOTP(parameters : [String:Any])
    case VerifyOTP(parameters : [String:Any])
    case ResetPassword(parameters : [String:Any])

}

extension Authintications : TargetType {
    var path: String {
        switch self {
        case .Create:
                return EndPoints.Create.rawValue
        case .Login:
                return EndPoints.Login.rawValue
        case .ChangePassword:
                return EndPoints.ChangePassword.rawValue
        case .SendOTP:
                return EndPoints.SendOTP.rawValue
        case .VerifyOTP:
                return EndPoints.VerifyOTP.rawValue
        case .ResetPassword:
                return EndPoints.ResetPassword.rawValue

        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .Create , .Login , .ChangePassword , .SendOTP , .VerifyOTP, .ResetPassword  :
            return .post
//        case .PhoneVerification :
//            return .get
        }
    }
    
    var parameter: parameterType {
        switch self {

        case .Create(parameters: let parameters) ,
                .Login(parameters: let parameters) ,
                .ChangePassword(parameters: let parameters) ,
                .SendOTP(parameters: let parameters) ,
                .VerifyOTP(parameters: let parameters) ,
                .ResetPassword(parameters: let parameters) :
            return .parameterRequest(Parameters: parameters, Encoding: .default)
            
//        case .SendFirebaseToken(parameters: let parameters):
//            return .parameterdGetRequest(Parameters: parameters, Encoding: .default)
            
        }
    }
}

