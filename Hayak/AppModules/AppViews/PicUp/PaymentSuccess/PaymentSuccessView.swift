//
//  PaymentSuccessView.swift
//  Hayak
//
//  Created by wecancity on 08/09/2024.
//

import SwiftUI

struct PaymentSuccessView: View {
    
    var body: some View {
        ZStack {
            Color(UIColor(named: "bg1")!).ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
            
            VStack {
                CustomHeaderView(title: "Payment Methood" , onBack: {
                }, OtherBtnIsfound: false , imageonOtherBtn: "", coloronOtherBtn: "")
                
                ScrollView {
                    ExtractedViewPaymentSuccessScreen(tipororder: .order(520))
                    
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
    PaymentSuccessView()
}
