//
//  PaymentSuccessScreen.swift
//  Hayak
//
//  Created by Mohamed Ragab on 12/08/2024.
//

import SwiftUI

struct PaymentSuccessScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showOverlay: Bool = false
    
    var body: some View {
        ZStack {
            Color(UIColor(named: "bg1")!).ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
            
            VStack {
                CustomHeaderView(title: "Payment Methood" , onBack: {
                    // Handle back button action
                    print("Back button pressed")
                    presentationMode.wrappedValue.dismiss()
                }, onOtherBtn: {
                    showOverlay.toggle()
                }, OtherBtnIsfound: false , imageonOtherBtn: "", coloronOtherBtn: "")
                
                ExtractedViewPaymentSuccessScreen()
            }
        }
    }
}

#Preview {
    PaymentSuccessScreen()
}


struct ExtractedViewPaymentSuccessScreen: View {
    
    
    var body: some View {
        ScrollView {
            VStack (spacing : 10){
                
                Image("done")
                    .resizable()
                    .frame(width: 190 , height: 150)
                VStack(spacing : 15) {
                    Text("Payment Success")
                        .font(.custom("LamaSans-Bold", size: 18))
                        .foregroundColor(Color("main1"))
                    Text("Tip ID # 125050")
                        .font(.custom("LamaSans-Bold", size: 14))
                        .foregroundColor(Color("main2"))
                    Text("Thank you for choosing our service and trusted to help you with your problems")
                        .lineSpacing(10.0)
                        .font(.custom("LamaSans-Medium", size: 14))
                        .foregroundColor(Color("main1"))
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity , minHeight: 110)
                .padding(30)
                .background(.white)
                .cornerRadius(20)
                .padding(20)
                
                Button(action: {
                    //save
                    
                }, label: {
                    Text("Find Currier")
                        .frame(height: 50) // Set the height here
                        .frame(maxWidth: .infinity)
                        .font(.custom("LamaSans-Medium", size: 14))
                        .foregroundColor(Color("bg1")).background(Color("main2"))
                        .cornerRadius(11)
                        .padding(.horizontal , 20)
                })
                
                Spacer()
            }
        }
    }
}
