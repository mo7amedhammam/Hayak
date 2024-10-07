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
    
    @Published var secondsCount: Int? = 0

    
    
    // Function to initiate sign-up
    func Create(name: String, mobile: String ,passwordHash : String , confirmPassword : String , isChecked : Bool ) {
        
        // Input validation logic
        guard !name.isEmpty else {
            self.errorMessage = "Please enter your name."
            return
        }
        
        guard !mobile.isEmpty else {
            self.errorMessage = "Please enter your phone number."
            return
        }
        
        guard !passwordHash.isEmpty else {
            self.errorMessage = "Please enter your password."
            return
        }
        
        guard !confirmPassword.isEmpty else {
            self.errorMessage = "Please confirm your password."
            return
        }
        
        guard passwordHash == confirmPassword else {
            self.errorMessage = "Passwords do not match."
            return
        }
        
        guard isChecked else {
            self.errorMessage = "agree to the Terms of Service and Privacy Policy"
            return
        }
        
        
        // If validation passes, reset validation message
        self.errorMessage = nil
        isLoading = true
        
        let parametersArr =  ["name" : name,"mobile" : mobile, "passwordHash" : passwordHash] as [String : Any]
        
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
                
                print("response : \(response)")
                self.isLoading = false
                
                // Handle the response
                if response.success == true {
                    self.signUpSuccess = true
                    self.secondsCount = response.data?.otp
                } else {
                    self.signUpSuccess = false
                    self.errorMessage = response.message
                }
            }
            .store(in: &cancellables)
    }
}
