//
//  PaymentSuccessScreen.swift
//  Hayak
//
//  Created by Mohamed Ragab on 12/08/2024.
//

import SwiftUI

struct PaymentSuccessScreen: View {
    @Environment(\.presentationMode) var presentationMode
    
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
                }, OtherBtnIsfound: false , imageonOtherBtn: "", coloronOtherBtn: "")
                
                ScrollView {
                    ExtractedViewPaymentSuccessScreen(tipororder: .tip(520))
                    
                    CustomButton(Title:"Find Currier",IsDisabled: .constant(false), action: {
                        
                    })
                    .padding(.horizontal)
                    .frame(height: 50) // Set the height here


                }
            }
        }
    }
}

#Preview {
    PaymentSuccessScreen()
}


enum tipOrorder:CustomStringConvertible{
//    case tip = "Tip"
//    case order = "Order"

    case tip(Int)
    case order(Int)

    var description: String {
        switch self {
        case .tip(let value):
            return "\(value)"
        case .order(let value):
            return "\(value)"
        }
    }

}

struct ExtractedViewPaymentSuccessScreen: View {
    var tipororder:tipOrorder = .tip(120)
    
    var body: some View {
//        ScrollView{
            VStack (spacing : 10){
                Image("done")
                    .resizable()
                    .frame(width: 190 , height: 150)
                VStack(spacing : 15) {
                    Text("Payment Success".localized())
                        .font(.custom("LamaSans-Bold", size: 18))
                        .foregroundColor(Color("main1"))
                    
                    switch tipororder {
                    case .tip(let id):
                        HStack(spacing:2){
                            Text("Tip ID".localized())
                            Text("# \(id)")
                        }
                            .font(.custom("LamaSans-Bold", size: 14))
                            .foregroundColor(Color("main2"))

                    case .order(let id):
                        HStack(spacing:2){
                            Text("Order ID".localized())
                            Text("# \(id)")
                        }
                            .font(.custom("LamaSans-Bold", size: 14))
                            .foregroundColor(Color("main2"))
                    }

                    Text("Thank you for choosing our service and trusted to help you with your problems".localized())
                        .lineSpacing(10.0)
                        .font(.custom(fontEnum.medium.rawValue, size: 14))
                        .foregroundColor(Color("main1"))
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity , minHeight: 110)
                .padding(30)
                .background(.white)
                .cornerRadius(20)
                .padding(20)
//                Spacer()
            }
//        }
    }
}
