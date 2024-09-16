//
//  ViewModelLogin.swift
//  Hayak
//
//  Created by Mohamed Ragab on 16/09/2024.
//


import Foundation
import Alamofire
import Combine


class ViewModelLogin: ObservableObject {
    // Published properties to track the sign-up state
    @Published var isLoading: Bool = false
    @Published var loginSuccess: Bool = false
    @Published var errorMessage: String? = nil
    // Combine cancellable for API calls
    private var cancellables = Set<AnyCancellable>()
    
    // Function to initiate sign-up
    func Login( mobile: String, password: String ) {
        isLoading = true
      
        let parametersArr =  ["mobile" : mobile , "password" : password ]
        
        // Create your API request with the username and password
        let target = Authintications.Login(parameters: parametersArr)
        //print(parametersarr)
        // Call the API using the BaseNetwork class
        BaseNetwork.CallApi(target, BaseResponse<LoginResponse>.self)
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
                self.loginSuccess = true
            }
            .store(in: &cancellables)
    }
}
