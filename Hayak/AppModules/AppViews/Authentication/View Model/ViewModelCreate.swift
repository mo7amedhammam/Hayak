//
//
//  ViewModelCreate.swift
//  Hayak
//
//  Created by Mohamed Ragab on 16/09/2024.
//

import SwiftUI
import Combine


class ViewModelCreate: ObservableObject {
    // Published properties to track the sign-up state
    @Published var isLoading: Bool? = false
    @Published var signUpSuccess: Bool = false
    @Published var errorMessage: String? = nil
    // Combine cancellable for API calls
    private var cancellables = Set<AnyCancellable>()
    
    @Published var secondsCount: Int? = 0
    @Published var code: Int? = 0

    
    
    // Function to initiate sign-up
    func Create(name: String, mobile: String ,passwordHash : String , confirmPassword : String , isChecked : Bool ) {
        
        // Input validation logic
        guard !name.isEmpty else {
            self.errorMessage = "Please enter your name."
            return
        }
        guard validateInput(name) else {
            errorMessage = "Only alphabetic characters and spaces are allowed."
            return
        }
        
        
        guard !mobile.isEmpty else {
            self.errorMessage = "Please enter a valid phone number"
            return
        }
        
        guard (mobile.contains("+966")) && (mobile.count == 13) else {
            self.errorMessage = "phone number must start with +966 and 9 digits"
            return
        }
        
        guard !passwordHash.isEmpty else {
            self.errorMessage = "Password must be at least 8 characters long, contain at least one number, and one special character."
            return
        }
        
        // Validate the password using the reusable function
          guard isValidPassword(passwordHash) else {
              self.errorMessage = "Password must be at least 8 characters long, contain at least one number, and one special character."
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
        
        
        let newMobile = mobile.replacingOccurrences(of: "+966", with: "")
        
        
        // If validation passes, reset validation message
        self.errorMessage = nil
        isLoading = true
        
        let parametersArr =  ["name" : name,"mobile" : newMobile, "passwordHash" : passwordHash] as [String : Any]
        
        // Create your API request with the username and password
        let target = Authintications.Create(parameters: parametersArr)
        //print(parametersarr)
        // Call the API using the BaseNetwork class
        BaseNetwork.CallApi(target, BaseResponse<SignUpResponse>.self)
            .sink {[weak self] completion in
                guard let self = self else {return}

                // Handle completion
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: {[weak self] response in
                guard let self = self else {return}
                print("response : \(response)")
                self.isLoading = false
                
                // Handle the response
                if response.success == true {
                    self.signUpSuccess = true
                    self.secondsCount = response.data?.secondsCount
                    self.code = response.data?.otp

                } else {
                    self.signUpSuccess = false
                    self.errorMessage = response.message
                }
            }
            .store(in: &cancellables)
    }
}
