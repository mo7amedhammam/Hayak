//
//  ViewModelSendOtp.swift
//  Hayak
//
//  Created by Mohamed Ragab on 09/10/2024.
//

import SwiftUI
import Combine


class ViewModelSendOtp: ObservableObject {
    // Published properties to track the sign-up state
    @Published var isLoading: Bool = false
    @Published var OTPSuccess: Bool = false
    @Published var errorMessage: String? = nil
    // Combine cancellable for API calls
    private var cancellables = Set<AnyCancellable>()
    
    var secondsCount: Int     = 0{
        didSet{
            startTimer()
        }
    } // Countdown starting from 180 seconds (3 minutes)
    @Published var timeRemaining: String = "00:00" // Formatted time string
    @Published var code: Int? // Formatted time string

    private var timer: AnyCancellable?
    
    
    init() {
//        startTimer()
    }
    
    // Function to initiate sign-up
    func SendOtp(mobile: String) {
        
        // Input validation logic
        guard !mobile.isEmpty else {
            self.errorMessage = "Please enter your phone number."
            return
        }
        
        guard (mobile.contains("+966")) && (mobile.count == 13) else {
            self.errorMessage = "phone number must start with +966 and 9 digits"
            return
        }
        
        // If validation passes, reset validation message
        self.errorMessage = nil
        isLoading = true
        
        let newMobile = mobile.replacingOccurrences(of: "+966", with: "")
     
        let parametersArr =  ["mobile" : newMobile]
        
        // Create your API request with the username and password
        let target = Authintications.SendOTP(parameters: parametersArr)
        //print(parametersarr)
        // Call the API using the BaseNetwork class
        BaseNetwork.CallApi(target, BaseResponse<OtpResponse>.self)
            .sink { [weak self] completion in
                guard let self = self else{return}

                // Handle completion
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { [weak self] response in
                guard let self = self else{return}
                print("response : \(response)")
                self.isLoading = false
                
                // Handle the response
                if response.success == true {
                    self.OTPSuccess = true
                    self.secondsCount = response.data?.secondsCount ?? 0
                    self.code = response.data?.otp
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
