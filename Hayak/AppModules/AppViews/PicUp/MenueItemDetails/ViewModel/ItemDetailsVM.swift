//
//  ItemDetailsVM.swift
//  Hayak
//
//  Created by wecancity on 27/10/2024.
//

import Foundation
import Combine

class ItemDetailsVM: ObservableObject {
    static let shared = ItemDetailsVM()
    private var cancellables: Set<AnyCancellable> = []
    
    // Reference the location view model
//    private var locationManager = LocationManagerVM.shared
    
    
    //    MARK: --- inputs ---
//    @Published var maxResultCount = 10
//    @Published var skipCount = 0
    
     var branchId : Int?
    
    @Published var quantity:Int = 1
    @Published var extraIds:[Int] = []
    
//    @Published private var multiSelection: [Int: Set<Int>] = [:] // Holds selected item IDs per attribute for multi-selection

    //    @Published var filtersubject : DropDownOption?{
    //        didSet{
    //            filterlesson = nil
    //        }
    //    }
    //    @Published var filterlesson : DropDownOption?
//    @Published var filtergroupName : String = ""
//    @Published var filterdate : String?
    //    @Published var isFiltering : Bool = false
    
    //    MARK: --- outpust ---
    @Published var isLoading : Bool?
    @Published var isError : Bool = false
    @Published var error: AlertType = .error(title: "", image: "", message: "", buttonTitle: "", secondButtonTitle: "")
    
    //    @Published var isTeacherHasSubjects: Bool = false
    @Published var Details : ItemDetailsM?
//    @Published var BrandBrancheDetails : BrandBrancheMenuM?
        @Published var isAddedToCheckout : Bool = false

//     var lat : Double?
//     var lon : Double?
    
    init(){
//        lat = locationManager.userLatitude
//        lon = locationManager.userLongitude
        
//        lat = LocationManagerVM.shared.userLatitude
//        lon = LocationManagerVM.shared.userLongitude

    }
}

extension ItemDetailsVM{
    func GetItemDetails(itemId:Int){
                let parameters:[String:Any] = ["itemId":itemId]
        //        print("parameters",parameters)
        let target = PickupServices.GetItemDetailsView(parameters: parameters)
        isLoading = true
        BaseNetwork.shared.CallApi(target, BaseResponse<ItemDetailsM>.self)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {[weak self] completion in
                guard let self = self else{return}
                isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    isError =  true
                    self.error = .error(image:nil, message: "\(error.localizedDescription)",buttonTitle:"Done")
                }
            },receiveValue: {[weak self] receivedData in
                guard let self = self else{return}
                print("receivedData",receivedData)
                if receivedData.success == true {
                    //                    TeacherSubjects?.append(model)
                    //                    if skipCount == 0{
                    Details = receivedData.data
                    //                    }else{
                    //                        Categories?.items?.append(contentsOf: receivedData.data?.items ?? [])
                    //                    }
                    
                }else{
                    isError =  true
                    //                    error = NetworkError.apiError(code: receivedData.messageCode ?? 0, error: receivedData.message ?? "")
                    error = .error(image:nil,  message: receivedData.message ?? "",buttonTitle:"Done")
                }
                isLoading = false
            })
            .store(in: &cancellables)
    }
    
    func AddToCart(){
// orderTypeId -   pickup :1   -    Dining :2
        print(branchId,Details?.customerCart?.id,quantity)
        guard let brandBranchId = branchId , let itemId = Details?.customerCart?.id,let orderTypeId = Helper.shared.selectedordertype?.rawValue else {return}
        var parameters:[String:Any] = [
            "brandBranchId":brandBranchId,
            "orderTypeId":orderTypeId,
            "itemId": itemId,
            "quantity":quantity
        ]
        if extraIds.count > 0 {
            parameters["itemAttributeValueId"] = extraIds
        }
        
        //        print("parameters",parameters)
        let target = PickupServices.AddToCart(parameters: parameters)
        isLoading = true
        BaseNetwork.shared.CallApi(target, BaseResponse<BrandBrancheMenuM>.self)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {[weak self] completion in
                guard let self = self else{return}
                isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    isError =  true
                    self.error = .error(image:nil, message: "\(error.localizedDescription)",buttonTitle:"Done")
                }
            },receiveValue: {[weak self] receivedData in
                guard let self = self else{return}
                print("receivedData",receivedData)
                if receivedData.success == true {
                    //                    TeacherSubjects?.append(model)
                    //                    if skipCount == 0{
//                    BrandBrancheDetails = receivedData.data
                    //                    }else{
                    //                        Categories?.items?.append(contentsOf: receivedData.data?.items ?? [])
                    //                    }
                    isAddedToCheckout = true
                    
                }else{
                    isError =  true
                    //                    error = NetworkError.apiError(code: receivedData.messageCode ?? 0, error: receivedData.message ?? "")
                    error = .error(image:nil,  message: receivedData.message ?? "",buttonTitle:"Done")
                }
                isLoading = false
            })
            .store(in: &cancellables)
    }
    
//    func GetNearestBrandBranches(){
//        var parameters:[String:Any] = [:]
//        // Access latitude and longitude directly from the location manager
//        parameters["lat"] = 30.549753700368758
//        parameters["lon"] = 31.065455361906114
//
////        if let lat = lat, let lon = lon {
////            parameters["lat"] = lat
////            parameters["lon"] = lon
////        }
//
////        if let distance = ""{
////            parameters["distance"] = distance
////        }
//        if let categoryId = selectedCategory?.id{
//            parameters["categoryId"] = categoryId
//        }
////        if let sortBy = ""{
////            parameters["sortBy"] = sortBy
////        }
//        print("parameters",parameters)
//        let target = PickupServices.NearestBrandBranches(parameters: parameters)
//        isLoading = true
//        BaseNetwork.shared.CallApi(target, BaseResponse<[NearestBrandBrancheM]>.self)
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: {[weak self] completion in
//                guard let self = self else{return}
//                isLoading = false
//                switch completion {
//                case .finished:
//                    break
//                case .failure(let error):
//                    isError =  true
//                    self.error = .error(image:nil, message: "\(error.localizedDescription)",buttonTitle:"Done")
//                }
//            },receiveValue: {[weak self] receivedData in
//                guard let self = self else{return}
//                print("receivedData",receivedData)
//                if receivedData.success == true {
//                    //                    TeacherSubjects?.append(model)
//                    NearestBrandBranches = receivedData.data
//                }else{
//                    isError =  true
//                    //                    error = NetworkError.apiError(code: receivedData.messageCode ?? 0, error: receivedData.message ?? "")
//                    error = .error(image:nil,  message: receivedData.message ?? "",buttonTitle:"Done")
//                }
//                isLoading = false
//            })
//            .store(in: &cancellables)
//    }
    
    
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
    
    func cleanup() {
        // Cancel any ongoing Combine subscriptions
        cancellables.forEach { cancellable in
            cancellable.cancel()
        }
        cancellables.removeAll()
    }
}




