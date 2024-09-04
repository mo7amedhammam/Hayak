//
//  DiningView.swift
//  Hayak
//
//  Created by Mohamed Ragab on 22/07/2024.
//

import SwiftUI

struct DiningView: View {
//    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack (alignment: .top){
            Color(.white).ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
            
            VStack{
                CustomHeaderView(title: "QR Code Scan" , onBack: {
                    // Handle back button action
                    print("Back button pressed")
//                    presentationMode.wrappedValue.dismiss()
                }, onOtherBtn: {
                }, OtherBtnIsfound: false , imageonOtherBtn: "", coloronOtherBtn: "")
                
                
                Image(.scanMeQrCode)
                    .padding(.top)
                
                
                VStack(spacing:15){
                    Text("Scan QR Code")
                        .foregroundStyle(.main1)
                        .font(Font.Bold(size: 18))
                    
                    Text("Thank you for choosing our\n service and trusted to help you\n with your problems")
                        .foregroundStyle(.main1)
                        .font(Font.Regular(size: 14))
                        .multilineTextAlignment(.center)
                        .lineSpacing(5)
                }
                .frame(maxWidth:.infinity)
                .padding(.vertical,20)
                .background(Color.white.borderRadius(.clear, cornerRadius: 12, corners: .allCorners))
                .padding(.horizontal)
                Spacer()
                
                CustomButton(Title:"fibndCarrire",IsDisabled:.constant(false) , action: {

                })
                .frame(height: 50)
                .padding(.top,40)
                .padding()
            }
            .background(.bg)

        }
    }
}

#Preview {
    DiningView()
}
