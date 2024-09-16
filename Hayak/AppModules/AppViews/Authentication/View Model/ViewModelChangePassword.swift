//
//  ViewModelChangePassword.swift
//  Hayak
//
//  Created by Mohamed Ragab on 16/09/2024.
//


import Foundation
import Alamofire
import Combine


class ViewModelChangePassword: ObservableObject {
    // Published properties to track the sign-up state
    @Published var isLoading: Bool = false
    @Published var ChangePasswordSuccess: Bool = false
    @Published var errorMessage: String? = nil
    // Combine cancellable for API calls
    private var cancellables = Set<AnyCancellable>()
    
    // Function to initiate sign-up
    func ChangePassword( currentPassword: String, newPassword: String ) {
        isLoading = true
      
        let parametersArr =  ["currentPassword" : currentPassword , "newPassword" : newPassword ]
        
        // Create your API request with the username and password
        let target = Authintications.ChangePassword(parameters: parametersArr)
        //print(parametersarr)
        // Call the API using the BaseNetwork class
        BaseNetwork.CallApi(target, BaseResponse<ChangePasswordResponse>.self)
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
                self.ChangePasswordSuccess = true
            }
            .store(in: &cancellables)
    }
}
