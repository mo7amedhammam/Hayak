//
//  CheckoutVM.swift
//  Hayak
//
//  Created by wecancity on 27/10/2024.
//

import Foundation
import Combine

class CheckoutVM: ObservableObject {
    static let shared = CheckoutVM()
    private var cancellables: Set<AnyCancellable> = []
    
    // Reference the location view model
    //    private var locationManager = LocationManagerVM.shared
    
    
    //    MARK: --- inputs ---
    //    @Published var maxResultCount = 10
    //    @Published var skipCount = 0
    
    //    @Published var selectedLessonid : Int?
    //    @Published var selectedCategory:MainCategoriesM?
    
    //    @Published var filtersubject : DropDownOption?{
    //        didSet{
    //            filterlesson = nil
    //        }
    //    }
    //    @Published var filterlesson : DropDownOption?
    //    @Published var filtergroupName : String = ""
    @Published var note : String = ""
    
    @Published var isCheckoutConfirmed : Bool = false
    
    //    MARK: --- outpust ---
    @Published var isLoading : Bool?
    @Published var isError : Bool = false
    @Published var error: AlertType = .error(title: "", image: "", message: "", buttonTitle: "", secondButtonTitle: "")
    
    //    @Published var isTeacherHasSubjects: Bool = false
    @Published var checkout : CheckoutM?
    //    @Published var NearestBrandBranches : [NearestBrandBrancheM]?
    
    //     var lat : Double?
    //     var lon : Double?
    
    
    @Published var isCartDeleted : Bool = false
    @Published var dismissCart : Bool = false
    
    
    init(){
        
    }
}

extension CheckoutVM{
    
    func GetCheckout(){
        let target = PickupServices.GetCheckout
        isLoading = true
        BaseNetwork.shared.CallApi(target, BaseResponse<CheckoutM>.self)
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
                    checkout = receivedData.data
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
    
    func ConfirmCheckout(){
        guard let params = checkout?.toDictionary() else {return}
        let parameters:[String:Any] = params
        print("parameters",parameters)
        
        let target = PickupServices.ConfirmCheckout(parameters: parameters)
        isLoading = true
        BaseNetwork.shared.CallApi(target, BaseResponse<[NearestBrandBrancheM]>.self)
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
                    //                    NearestBrandBranches = receivedData.data
                    isCheckoutConfirmed = true
                    
                }else{
                    isError =  true
                    //                    error = NetworkError.apiError(code: receivedData.messageCode ?? 0, error: receivedData.message ?? "")
                    error = .error(image:nil,  message: receivedData.message ?? "",buttonTitle:"Done")
                }
                isLoading = false
            })
            .store(in: &cancellables)
    }
    
    
    
    func DeleteFromCart( customerCartId: Int , offsets: IndexSet) {
        
        isLoading = true
        let parametersArr =  ["customerCartId" : customerCartId]
        
        // Create your API request with the username and password
        let target = PickupServices.DeleteFromCart(parameters: parametersArr)
        //print(parametersarr)
        // Call the API using the BaseNetwork class
        BaseNetwork.shared.CallApi(target, BaseResponse<LoginResponse>.self)
            .sink { [self] completion in
                // Handle completion
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    isError =  true
                    self.error = .error(image:nil, message: "\(error.localizedDescription)",buttonTitle:"Done")
                case .finished:
                    break
                }
            } receiveValue: { [self] response in
                // Handle the response
                print("response : \(response)")
                self.isLoading = false
                
                // Handle the response
                if response.success == true {
                    isCartDeleted = true
                    SuccessItemdeleted(at: offsets)
                } else {
                    isError =  true
                    error = .error(image:nil,  message: response.message ?? "",buttonTitle:"Done")
                }
                
            }
            .store(in: &cancellables)
    }
    
    private func SuccessItemdeleted(at offsets: IndexSet) {
        checkout?.cartItems?.remove(atOffsets: offsets)
        
        if checkout?.cartItems?.count == 0  {
            dismissCart = true
        }
        
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
    
    func cleanup() {
        // Cancel any ongoing Combine subscriptions
        cancellables.forEach { cancellable in
            cancellable.cancel()
        }
        cancellables.removeAll()
    }
}




