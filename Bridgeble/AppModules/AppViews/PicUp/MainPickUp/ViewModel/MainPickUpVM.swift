//
//  MainPickUpVM.swift
//  Hayak
//
//  Created by wecancity on 13/10/2024.
//

import Foundation
//import Combine

class MainPickUpVM: BaseViewModel {
    static let shared = MainPickUpVM()
    //    private var cancellables: Set<AnyCancellable> = []
    
    // Reference the location view model
    //    private var locationManager = LocationManagerVM.shared
    
    
    //    MARK: --- inputs ---
    @Published var maxResultCount = 10
    @Published var skipCount = 0
    
    //    @Published var selectedLessonid : Int?
    @Published var selectedCategory:MainCategoriesM?
    @Published var sortBy : String? // rate, recommendation,distance
    @Published var Radius : Int? // rate, recommendation,distance
    @Published var Rate : Int? // rate, recommendation,distance
    
    //    @Published var filtersubject : DropDownOption?{
    //        didSet{
    //            filterlesson = nil
    //        }
    //    }
    //    @Published var filterlesson : DropDownOption?
    //    @Published var filtergroupName : String = ""
    //    @Published var filterdate : String?
    //    @Published var isFiltering : Bool = false
    
    @Published var islistingfavourites = false
    
    //    MARK: --- outpust ---
    @Published var isLoading : Bool?
    @Published var isError : Bool = false
    @Published var error: AlertType = .error(title: "", image: "", message: "", buttonTitle: "", secondButtonTitle: "")
    
    //    @Published var isTeacherHasSubjects: Bool = false
    @Published var Categories : [MainCategoriesM]?
    @Published var NearestBrandBranches : [NearestBrandBrancheM]?
    //    @Published var itemAddedToFavourit : Bool = false
    
    var lat : Double?
    var lon : Double?
    
    override init(){
        //        lat = locationManager.userLatitude
        //        lon = locationManager.userLongitude
        
        //        lat = LocationManagerVM.shared.userLatitude
        //        lon = LocationManagerVM.shared.userLongitude
        
    }
}

extension MainPickUpVM{
    
    func GetCategories() {
        DispatchQueue.main.async { [weak self] in
            self?.isLoading = true
        }
        
        let target = PickupServices.Categories
        handleAPI(target: target, responseType: [MainCategoriesM].self, onSuccess: { [weak self] data in
            self?.Categories = data
            self?.isLoading = false
        }, onFailure: { [weak self] error in
            self?.isError = true
            self?.error = .error(image: nil, message: error.localizedDescription, buttonTitle: "Done")
            self?.isLoading = false
        })
        
    }
    
    func GetNearestBrandBranches(){
        var parameters:[String:Any] = [:]
        // Access latitude and longitude directly from the location manager
        parameters["lat"] = 30.549753700368758
        parameters["lon"] = 31.065455361906114
        
        //        if let lat = lat, let lon = lon {
        //            parameters["lat"] = lat
        //            parameters["lon"] = lon
        //        }
        
        if let distance = Radius{
            parameters["distance"] = distance
        }
        if let categoryId = selectedCategory?.id{
            parameters["categoryId"] = categoryId
        }
        if let sortBy = sortBy{
            parameters["sortBy"] = sortBy
        }
        print("parameters",parameters)
        DispatchQueue.main.async { [weak self] in
            self?.isLoading = true
        }
        let target = PickupServices.NearestBrandBranches(parameters: parameters)
        handleAPI(target: target, responseType: [NearestBrandBrancheM].self, onSuccess: { [weak self] data in
            self?.NearestBrandBranches = data
            self?.isLoading = false
        }, onFailure: { [weak self] error in
            self?.isError = true
            self?.error = .error(image: nil, message: error.localizedDescription, buttonTitle: "Done")
            self?.isLoading = false
        })
        
    }
    
    func GetFavouriteBrandBranches(){
        var parameters:[String:Any] = [:]
        parameters["lat"] = 30.549753700368758
        parameters["lon"] = 31.065455361906114
        
        //        if let lat = lat, let lon = lon {
        //            parameters["lat"] = lat
        //            parameters["lon"] = lon
        //        }
        
        //        if let sortBy = ""{
        //            parameters["sortBy"] = sortBy
        //        }
        if let categoryId = selectedCategory?.id{
            parameters["categoryId"] = categoryId
        }
        let target = PickupServices.CustomerFavourite(parameters: parameters)
        DispatchQueue.main.async { [weak self] in
            self?.isLoading = true
        }
        handleAPI(target: target, responseType: [NearestBrandBrancheM].self, onSuccess: { [weak self] data in
            self?.NearestBrandBranches = data
            self?.isLoading = false
        }, onFailure: { [weak self] error in
            self?.isError = true
            self?.error = .error(image: nil, message: error.localizedDescription, buttonTitle: "Done")
            self?.isLoading = false
        })
        
    }
    func AddToFavourit(brandBranchId: Int) {
        
        DispatchQueue.main.async { [weak self] in
            self?.isLoading = true
        }
        let parametersArr =  ["brandBranchId" : brandBranchId]
        let target = PickupServices.AddToFavourit(parameters: parametersArr)
        // Call the API using the BaseNetwork class
        handleAPI(target: target, responseType: [LoginResponse].self, onSuccess: { [weak self] data in
            //            self?.NearestBrandBranches = data
            self?.isLoading = false
        }, onFailure: { [weak self] error in
            self?.isError = true
            self?.error = .error(image: nil, message: error.localizedDescription, buttonTitle: "Done")
            self?.isLoading = false
        })
    }
    
    
    //    func clearTeacherGroup(){
    //        subject = nil
    //        lesson = nil
    //        date = nil
    //        groupName = ""
    //    }
    
    //    func clearFilter(){
    //        filtersubject = nil
    //        filterlesson = nil
    //        filterdate = nil
    //        filtergroupName = ""
    //    }
    
    //    func selectSubjectForEdit(item:TeacherSubjectM){
    //        isEditing = false
    //        editId = item.id ?? 0
    //        educationType = .init(id: item.educationTypeID,Title: item.educationTypeName)
    //        educationLevel = .init(id: item.educationLevelID,Title: item.educationLevelName)
    //        academicYear = .init(id: item.subjectAcademicYearID,Title: item.academicYearName)
    //        subject = .init(id: item.subjectAcademicYearID,Title: item.subjectDisplayName)
    //        if let min = item.minGroup{
    //            minGroup = String(min)
    //        }
    //        if let max = item.maxGroup{
    //            maxGroup = String(max)
    //        }
    //        if let gcost = item.groupCost{
    //            groupCost = String(gcost)
    //        }
    //        if let indcost = item.individualCost{
    //            individualCost = String(indcost)
    //        }
    //        subjectBrief = item.teacherBrief ?? ""
    //        isEditing = true
    //    }
    
    //    func cleanup() {
    //        // Cancel any ongoing Combine subscriptions
    //        cancellables.forEach { cancellable in
    //            cancellable.cancel()
    //        }
    //        cancellables.removeAll()
    //    }
}




