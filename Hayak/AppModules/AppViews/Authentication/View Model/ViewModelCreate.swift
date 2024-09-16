//
//
//  ViewModelCreate.swift
//  Hayak
//
//  Created by Mohamed Ragab on 16/09/2024.
//

import Foundation
import Alamofire
import Combine


class ViewModelCreate: ObservableObject {
    // Published properties to track the sign-up state
    @Published var isLoading: Bool = false
    @Published var signUpSuccess: Bool = false
    @Published var errorMessage: String? = nil
    // Combine cancellable for API calls
    private var cancellables = Set<AnyCancellable>()
    
    // Function to initiate sign-up
    func Create(name: String, mobile: String, genderId: Int , birthDate : String , email : String , address : String , cityId : Int , creationDate : String ,passwordHash : String ) {
        isLoading = true
      
        let parametersArr =  ["name" : name,"mobile" : mobile , "genderId" : genderId , "birthDate" : birthDate , "email" : email , "address" : address , "cityId" : cityId , "creationDate" : creationDate , "passwordHash" : passwordHash] as [String : Any]
        
        // Create your API request with the username and password
        let target = Authintications.Create(parameters: parametersArr)
        //print(parametersarr)
        // Call the API using the BaseNetwork class
        BaseNetwork.CallApi(target, BaseResponse<SignUpResponse>.self)
            .sink { completion in
                // Handle completion
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { response in
                // Handle the response
                self.signUpSuccess = true
            }
            .store(in: &cancellables)
    }
}
