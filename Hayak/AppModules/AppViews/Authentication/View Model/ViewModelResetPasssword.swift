//
//  ViewModelResetPasssword.swift
//  Hayak
//
//  Created by Mohamed Ragab on 16/09/2024.
//

import SwiftUI
import Combine


class ViewModelResetPasssword: ObservableObject {
    // Published properties to track the sign-up state
    @Published var isLoading: Bool = false
    @Published var resetSuccess: Bool = false
    @Published var errorMessage: String? = nil
    // Combine cancellable for API calls
    private var cancellables = Set<AnyCancellable>()
    
    // Function to initiate sign-up
    func ResetPasssword( mobile: String, newPassword: String, ConfirmPassword : String ) {
        
        
        guard !mobile.isEmpty else {
            self.errorMessage = "phone number not found , please try again."
            return
        }
        
        // Input validation logic
        guard !newPassword.isEmpty else {
            self.errorMessage = "Please enter new password."
            return
        }
        
        
        // Validate the password using the reusable function
        guard isValidPassword(newPassword) else {
            self.errorMessage = "Password must be at least 8 characters long, contain at least one number, and one special character."
            return
        }
        
        // Input validation logic
        guard !ConfirmPassword.isEmpty else {
            self.errorMessage = "Please Confirm new password."
            return
        }
        
        // Input validation logic
        guard ConfirmPassword == newPassword else {
            self.errorMessage = "password not matched"
            return
        }
        
        let newMobile = mobile.replacingOccurrences(of: "+966", with: "")
        
        
        isLoading = true
        errorMessage = nil
        let parametersArr =  ["mobile" : newMobile , "newPassword" : newPassword ]
        
        // Create your API request with the username and password
        let target = Authintications.ResetPassword(parameters: parametersArr)
        //print(parametersarr)
        // Call the API using the BaseNetwork class
        BaseNetwork.shared.CallApi(target, BaseResponse<OtpResponse>.self)
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
                print("response : \(response)")
                self.isLoading = false
                
                // Handle the response
                if response.success == true {
                    self.resetSuccess = true
                } else {
                    self.resetSuccess = false
                    self.errorMessage = response.message
                }
                
            }
            .store(in: &cancellables)
    }
}
