//
//  EndPoints.swift
//  MrS-Cool
//
//  Created by wecancity on 16/10/2023.
//

import Foundation

struct Constants {
// MARK: - APIs Constants
    static var baseURL:String {return "https://alnada-devhayakapi.azurewebsites.net/"} //TEST
//static var baseURL:String {return "https://alnada-devhayakapi.azurewebsites.net/"} //LIVE
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
    //MARK: -- 1. PickupEndPoints --
    case Categories = "MainCategory/GetAll"
    case NearestBrandBranches = "Pickup/NearestBrandBranches"
    
    //MARK: -- 2. pickup menu (details) --
    case CategoryForList = "Category/GetCategoryForList"
    case BrandBranchDetails = "Pickup/BrandBranchDetails"
    
    //MARK: -- 3. Order Customization Screen:**
    /** get<itemId */
    case GetItemDetailsView = "CustomerCart/GetItemDetailsView"
    /** post<brandBranchId,orderTypeId,itemId,[itemAttributeValueId],quantity */
    case AddToCart = "CustomerCart/AddToCart"

    //MARK: -- 4. **Order Summary Screen:**
    /** get*/
    case CheckoutView = "CustomerCart/CheckoutView"
    /** get<icustomerCartId*/
    case DeleteFromCart = "CustomerCart/DeleteFromCart"
    /** post<cartItems:[customerCartId,...]*/
    case ConfirmCheckout = "CustomerCart/ConfirmCheckout"

}
