//
//  AddNewCard.swift
//  Hayak
//
//  Created by wecancity on 19/01/2025.
//

import SwiftUI

struct AddNewCard:View {
    @StateObject var viewmodel = AddNewCardViewModel.shared
    
    var body: some View {
        VStack {
            CustomHeaderView(title: "Payment Methood" , onBack: {
                // Handle back button action
                print("Back From Payment Methood")
                //                    presentationMode.wrappedValue.dismiss()
            }, onOtherBtn: {
            }, OtherBtnIsfound: false , imageonOtherBtn: "", coloronOtherBtn: "")
            ScrollView{
                Image(.newCardIcon)
                
                CustomInputField(title: "Account Holder Name", placeholder: "enter your account holder name",text: $viewmodel.CardHolderName)
                    .onChange(of: viewmodel.CardHolderName) { newValue in
                        viewmodel.updateCardHolderName(newValue)
                       }

                CustomInputField(title: "Card Number", placeholder: "enter your card number",icon: "cardIcon",text: $viewmodel.CardNumber)
                    .onChange(of: viewmodel.CardNumber) { newValue in
                        viewmodel.updateCardNumber(newValue)
                       }
                
                HStack{
                    CustomInputField(title: "Exp. Date", placeholder: "enter exp. date",icon: nil,text: $viewmodel.CardExpireDate)
                        .onChange(of: viewmodel.CardExpireDate) { newValue in
                                viewmodel.updateExpDate(newValue)
                            }

                    CustomInputField(title: "CVV Code", placeholder: "enter your cvv code",icon: nil,text: $viewmodel.CardCVVCode)
                        .onChange(of: viewmodel.CardCVVCode) { newValue in
                            viewmodel.updateCVV(newValue)
                            }
                    
                }
                
                CustomButton(Title: "Save Now",IsDisabled: .constant(false), action: {
                    UIApplication.shared.endEditing()
                    
                    //                            viewModel.Login(mobile: phoneNumber , password: passwordNumber)
                    Task{
                        //                        await viewModel.Login1(mobile: phoneNumber , password: passwordNumber)
                    }
                    
                })
                .frame(height: 50)
                .padding(.horizontal)
                
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical,40)
            .background(Color.bg1)
        }
        .hideNavigationBar()
        
        
    }
    
}
#Preview {
    AddNewCard()
}
