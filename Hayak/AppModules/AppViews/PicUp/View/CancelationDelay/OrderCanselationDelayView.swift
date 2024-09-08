//
//  OrderCanselationDelayView.swift
//  Hayak
//
//  Created by wecancity on 08/09/2024.
//

import SwiftUI

struct OrderCanselationDelayView: View {
    
    var timeSeconds = 30
    @State private var timeRemaining  = 0 // Set countdown time in seconds
    @State private var timerIsActive = false
    
    var body: some View {
        
        ZStack {
            VStack{
                CustomHeaderView(title: "QR Code Scan", OtherBtnIsfound: false , imageonOtherBtn: "", coloronOtherBtn: "")
                
                Spacer()
                
                HStack{
                    CustomBorderedButton(Title:"Cancel",IsDisabled:.constant(false) , action: {
                        //                        startScanning = true
                    })
                    .frame(height: 50)
                    .padding(.bottom,40)
                    
                    CustomButton(Title:"Pay",IsDisabled:.constant(false) , action: {
                        //                        startScanning = true
                    })
                    .frame(height: 50)
                    .padding(.bottom,40)
                    
                }
                .padding(.horizontal)
                
            }
            .background(.bg1)
            
            VStack(spacing:20){
                Text("\(formatTime())")
                    .font(Font.SemiBold(size: 45))
                    .foregroundStyle(.main2)
                
                Text("You can cancel your order\nwithin \(timeSeconds) seconds")
                    .font(Font.Regular(size: 14))
                    .foregroundStyle(.main1)
                    .multilineTextAlignment(.center)
                    .lineSpacing(8)
            }
        }
        .onAppear {
            // Optional: Start the timer immediately when the view appears
            startTimer(for: timeSeconds)
        }
        
        
    }
    func formatTime() -> String {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func startTimer(for:Int) {
        timerIsActive = true
        timeRemaining = timeSeconds
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer.invalidate() // Stop the timer when it reaches 0
                timerIsActive = false
            }
        }
    }
    
    func stopTimer() {
        timerIsActive = false
        timeRemaining = 30 // Reset the timer if needed
    }
}

#Preview {
    OrderCanselationDelayView()
}
