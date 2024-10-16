//
//  EndPoints.swift
//  MrS-Cool
//
//  Created by wecancity on 16/10/2023.
//

import Foundation

struct Constants {
// MARK: - APIs Constants
    static var baseURL:String {return "https://hayakapidev.azurewebsites.net/"} //TEST
//static var baseURL:String {return "https://hayakapidev.azurewebsites.net/"} //LIVE
    static var apiURL:String {return "\(baseURL)api/\(LocalizeHelper.shared.currentLanguage)/"}
    static var WhatsAppNum = "+201011138900"
}

enum EndPoints: String {
    //MARK: -- Lookups --
    case Create = "Customer/Create"
    case Login = "Customer/Login"
    case SendOTP = "Customer/SendOTP"
    case VerifyOTP = "Customer/VerifyOTP"
    case ResetPassword = "Customer/ResetPassword"
    case ChangePassword = "Customer/ChangePassword"


}



enum PickupEndPoints: String {
    //MARK: -- PickupEndPoints --
    case Categories = "MainCategory/GetAll"
    case NearestBrandBranches = "Pickup/NearestBrandBranches"

}
