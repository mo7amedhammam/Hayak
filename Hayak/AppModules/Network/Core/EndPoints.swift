//
//  EndPoints.swift
//  MrS-Cool
//
//  Created by wecancity on 16/10/2023.
//

import Foundation

struct Constants {
// MARK: - APIs Constants
    static var baseURL:String {return "https://mrscoolapi.azurewebsites.net/"} //TEST
//static var baseURL:String {return "https://mrscoolapi.azurewebsites.net/"} //LIVE

    static var apiURL:String {return "\(baseURL)api/\(LocalizeHelper.shared.currentLanguage)/"}
//    static var imagesURL:String {return "http://mrscoolapi.azurewebsites.net/"}

//var TermsAndConditionsURL =  "https://camelgate.app/terms.html"

    static var WhatsAppNum = "+201011138900"
}

enum EndPoints: String {
    //MARK: -- Lookups --
    case GetGender = "Lookups/GetGender"///get
    case GetCountries = "Country/Get"///get
    case GetGovernorates = "Governorate/Get"///get
    case GetCities = "City/Get" ///get
    
        // MARK: -- Student Auth --
    case RegisterStudent = "Student/Register" ///post
    case LoginStudent = "Student/Login"///post
    
    case sendOTPStudent = "Student/SendOTP" ///Post
    case VerifyOTPStudent = "Student/VefiryUser" /// Post
    case VerifyResetOTPStudent = "Student/VerifyOTP" /// Post

    case ResetPasswordStudent = "Student/ResetPassword"
    case ChangePasswordStudent = "Student/ChangePassword"
    
  
    // MARK: -- Teacher Scheduals --
    case GetMySchedules = "TeacherSchedule/GetMySchedules"
    case CreateMySchedules = "TeacherSchedule/Create"
    case DeleteMySchedules = "TeacherSchedule/Delete"
    

    //MARK: - firebase notifications -
    case UpdateTeacherDeviceToken = "Teacher/UpdateTeacherDeviceToken"

}

//enum ParentEndPoints:String{
//    // MARK: -- parent --
//    case GetMyChildren = "Parent/GetMyChildren"
//    case CreateStudentByParent = "Student/CreateByParent"
//    case DeleteStudentByParent = "Student/Delete"
//
//}
