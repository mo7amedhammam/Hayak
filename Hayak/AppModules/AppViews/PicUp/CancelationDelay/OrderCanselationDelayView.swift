//
//  OrderCanselationDelayView.swift
//  Hayak
//
//  Created by wecancity on 08/09/2024.
//

import SwiftUI

struct OrderCanselationDelayView: View {
    
    var timeSeconds = 30
    @Binding var timeRemaining : Int // Set countdown time in seconds
    @State private var timerIsActive = false
    var onPay: () -> Void
    var onCancel: () -> Void
    
    var body: some View {
        
        ZStack {
            VStack{
//                CustomHeaderView(title: "QR Code Scan", OtherBtnIsfound: false , imageonOtherBtn: "", coloronOtherBtn: "")
                
                // Content of the header
                HStack {
                    // Back button
                    Button(action: {
                        onCancel()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.custom("LamaSans-Bold", size: 14))
                            .foregroundColor(Color("main1"))
                            .frame(width: 44) // The same width as the back button
                    }
                    .frame(width: 44) // The same width as the back button
                    Spacer()
                    // Title
                    Text("QR Code Scan")
                        .font(.headline)
                        .foregroundColor(Color("main1"))
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Spacer()
                        .frame(width: 44) // The same width as the back button
                    
                }
                .frame(height: 60)
                
                
                Spacer()
                
                HStack{
                    CustomBorderedButton(Title:"Cancel",IsDisabled:.constant(false) , action: {
                        onCancel()
                    })
                    .frame(height: 50)
                    .padding(.bottom,40)
                    
                    CustomButton(Title:"Pay",IsDisabled:.constant(false) , action: {
                        onPay()
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
    OrderCanselationDelayView(timeRemaining: .constant(30), onPay: {} , onCancel: {})
}
