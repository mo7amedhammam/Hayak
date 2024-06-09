//
//  Authintications.swift
//  MrS-Cool
//
//  Created by wecancity on 16/10/2023.
//

import Foundation
import Alamofire

enum Authintications {
    case Register(parameters : [String:Any])
    case VerifyOtpUser(parameters : [String:Any])

}

extension Authintications : TargetType {
    var path: String {
        switch self {
        case .Register:
                return EndPoints.RegisterStudent.rawValue
           

//        case .TeacherLogin(let user,_):
//                return EndPoints.LoginStudent.rawValue
//
            
        case .VerifyOtpUser:
                return EndPoints.VerifyOTPStudent.rawValue

        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .Register,
                .VerifyOtpUser:
            return .post
            
//        case .TeacherDeleteSubjects:
//            return .get
        }
    }
    
    var parameter: parameterType {
        switch self {
        case .Register(let parameters),
                .VerifyOtpUser( let parameters):
            return .parameterRequest(Parameters: parameters, Encoding: .default)
            
//        case .TeacherDeleteSubjects(parameters: let parameters):
//            return .BodyparameterRequest(Parameters: parameters, Encoding: .default)
            
//        case .SendFirebaseToken(parameters: let parameters):
//            return .parameterdGetRequest(Parameters: parameters, Encoding: .default)
            
        }
    }
}

