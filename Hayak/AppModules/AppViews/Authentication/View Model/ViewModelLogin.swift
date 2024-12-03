//
//  ViewModelLogin.swift
//  Hayak
//
//  Created by Mohamed Ragab on 16/09/2024.
//


import SwiftUI
import Combine

@MainActor
class ViewModelLogin: ObservableObject {
    // Published properties to track the sign-up state
    @Published var isLoading: Bool? = false
    @Published var loginSuccess: Bool = false
    @Published var errorMessage: String? = nil
    // Combine cancellable for API calls
    private var cancellables = Set<AnyCancellable>()
    
    // Function to initiate sign-up
    func Login( mobile: String, password: String ) {
        
        
        guard !mobile.isEmpty else {
            self.errorMessage = "Please enter your phone number."
            return
        }
        
        guard (mobile.contains("+966")) && (mobile.count == 13) else {
            self.errorMessage = "phone number must start with +966 and 9 digits"
            return
        }
        // Input validation logic
        guard !password.isEmpty else {
            self.errorMessage = "Please enter your password."
            return
        }
           
      
        let newMobile = mobile.replacingOccurrences(of: "+966", with: "")
        
        isLoading = true
        errorMessage = nil
        let parametersArr =  ["mobile" : newMobile , "password" : password ]
        
        // Create your API request with the username and password
        let target = Authintications.Login(parameters: parametersArr)
        //print(parametersarr)
        // Call the API using the BaseNetwork class
        BaseNetwork.shared.CallApi(target, BaseResponse<LoginResponse>.self)
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
                    let user = LoginResponse(name: response.data?.name, mobile: response.data?.mobile, genderId: response.data?.genderId, birthDate: response.data?.birthDate, email: response.data?.email, address: response.data?.address, cityId: response.data?.cityId, creationDate: response.data?.creationDate, id: response.data?.id, token: response.data?.token)
                    
                    Helper.shared.saveUser(user: user)
                    Helper.shared.IsLoggedIn(value: true)
                    
                    self.loginSuccess = true
                } else {
                    self.loginSuccess = false
                    self.errorMessage = response.message
                }
                
            }
            .store(in: &cancellables)
    }
    
    func Login1( mobile: String, password: String ) async {
        guard !mobile.isEmpty else {
            self.errorMessage = "Please enter your phone number."
            return
        }
        
        guard (mobile.contains("+966")) && (mobile.count == 13) else {
            self.errorMessage = "phone number must start with +966 and 9 digits"
            return
        }
        // Input validation logic
        guard !password.isEmpty else {
            self.errorMessage = "Please enter your password."
            return
        }
           
        let newMobile = mobile.replacingOccurrences(of: "+966", with: "")
        
        isLoading = true
        errorMessage = nil
        let parametersArr =  ["mobile" : newMobile , "password" : password ]
        
        // Create your API request with the username and password
        let target = Authintications.Login(parameters: parametersArr)
        print(parametersArr)

        isLoading = true
            errorMessage = nil
        do{
            let response = try await BaseNetwork.shared.request(target, LoginResponse.self)
            print(response)
            self.isLoading = false
            
//            if response.success == true {
                     // Successful login
                     let user = LoginResponse(
                        name: response.name ,
                         mobile: response.mobile,
                         genderId: response.genderId,
                         birthDate: response.birthDate,
                         email: response.email,
                         address: response.address,
                         cityId: response.cityId,
                         creationDate: response.creationDate,
                         id: response.id,
                         token: response.token
                     )
                     
                     Helper.shared.saveUser(user: user)
                     Helper.shared.IsLoggedIn(value: true)
                     
                     self.loginSuccess = true
//                 } else {
//                     self.loginSuccess = false
//                     self.errorMessage = response.message ?? "Login failed due to an unknown error."
//                 }
                 
             } catch let error as NetworkError {
                 self.isLoading = false

                 self.errorMessage = error.errorDescription
                 print("Network error: \(error.errorDescription)")
             } catch {
                 self.isLoading = false
                 self.errorMessage = error.localizedDescription
                 print("Unexpected error: \(error.localizedDescription)")

             }

    }
    
    
}
