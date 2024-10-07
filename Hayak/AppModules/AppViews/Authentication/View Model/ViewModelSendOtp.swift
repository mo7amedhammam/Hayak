//
//  ViewModelSendOtp.swift
//  Hayak
//
//  Created by Mohamed Ragab on 16/09/2024.
//

import SwiftUI
import Combine


class ViewModelOTP: ObservableObject {
    // Published properties to track the sign-up state
    @Published var isLoading: Bool = false
    @Published var OTPSuccess: Bool = false
    @Published var errorMessage: String? = nil
    // Combine cancellable for API calls
    private var cancellables = Set<AnyCancellable>()
    
    var secondsCount: Int     = 0 // Countdown starting from 180 seconds (3 minutes)
    @Published var timeRemaining: String = "00:00" // Formatted time string
    
    private var timer: AnyCancellable?
    
    
    init() {
        startTimer()
    }
    
    // Function to initiate sign-up
    func SendOtp(otp: String, mobile: String) {
        
        // Input validation logic
        guard !otp.isEmpty else {
            self.errorMessage = "Please enter correct otp."
            return
        }
        
        // If validation passes, reset validation message
        self.errorMessage = nil
        isLoading = true
        
        let parametersArr =  ["otp" : otp,"mobile" : mobile] as [String : Any]
        
        // Create your API request with the username and password
        let target = Authintications.SendOTP(parameters: parametersArr)
        //print(parametersarr)
        // Call the API using the BaseNetwork class
        BaseNetwork.CallApi(target, BaseResponse<OtpResponse>.self)
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
                    self.OTPSuccess = true
                } else {
                    self.OTPSuccess = false
                    self.errorMessage = response.message
                }
            }
            .store(in: &cancellables)
    }
    
    
    func startTimer() {
        // Invalidate the previous timer if any
        timer?.cancel()
        
        // Start a new timer that fires every second
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.secondsCount > 0 {
                    self.secondsCount -= 1
                    self.updateTimeRemaining()
                } else {
                    // Stop the timer when it reaches zero
                    self.timer?.cancel()
                }
            }
    }
    
    // Function to convert seconds to minutes:seconds format
    func updateTimeRemaining() {
        let minutes = self.secondsCount / 60
        let seconds = self.secondsCount % 60
        self.timeRemaining = String(format: "%02d:%02d", minutes, seconds)
    }
    
    
}
