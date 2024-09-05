//
//  CheckoutScreen.swift
//  Hayak
//
//  Created by Mohamed Ragab on 05/09/2024.
//

import SwiftUI

struct CheckoutScreen: View {
    
    @Environment (\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color(.white).ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
            
            VStack {
                CustomHeaderView(title: "Checkout" , onBack: {
                    // Handle back button action
                    print("Back button pressed")
                    presentationMode.wrappedValue.dismiss()
                }, onOtherBtn: {
                }, OtherBtnIsfound: false , imageonOtherBtn: "", coloronOtherBtn: "")
                
                ExtractedViewCheckoutScreen()
                
            }
        }    }
}

#Preview {
    CheckoutScreen()
}

struct ExtractedViewCheckoutScreen : View {
    
    @State var useWallet : Bool = false
    @State var textAddVoucher : String = ""

    
    var body: some View {
        
        
        ScrollView {
            
            VStack(spacing : 13) {
                
                HStack (){
                    VStack(alignment : .leading , spacing : 5) {
                        Text("Rewards")
                            .font(.custom(fontEnum.bold.rawValue, size: 16))
                            .foregroundColor(Color("main1"))
                        Text("Add subtitle here")
                            .font(.custom(fontEnum.medium.rawValue, size: 12))
                            .foregroundColor(Color("empty text field"))
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                
                VStack {
                    
                    HStack (spacing : 10){
                        Image("gift")
                            .resizable()
                            .frame(width: 50 , height: 50)
                        VStack(alignment : .leading,spacing : 11 )  {
                            
                            Text("Get 10 SR off")
                                .font(.custom(fontEnum.bold.rawValue, size: 18))
                                .foregroundColor(Color("main1"))
                            
                            Text("with 1500 Points")
                                .font(.custom(fontEnum.bold.rawValue, size: 10))
                                .foregroundColor(Color("main2"))
                        }
                        Spacer()
                        
                        Button(action: {
                            //
                            
                        }, label: {
                            Text("Redeemed")
                                .frame(width: 100 , height: 40) // Set the height here
                                .font(.custom(fontEnum.medium.rawValue, size: 14))
                                .foregroundColor(Color("bg1")).background(Color("main2"))
                                .cornerRadius(10)
                                .padding(.horizontal , 20)
                        })
                        
                    }
                    .padding(5)
                }
                .frame(width: .infinity)
                .frame(height: 80)
                .background(Color("bg1"))
                .overlay(
                    RoundedCorners(radius: 10, corners: .allCorners)
                        .stroke(Color("main3"), lineWidth: 1)
                )
                
                
                //............................................................
                
                HStack {
                    VStack (alignment : .leading , spacing : 5){
                        Text("Add Voucher")
                            .font(.custom(fontEnum.bold.rawValue, size: 16))
                            .foregroundColor(Color("main1"))
                        Text("Add subtitle here")
                            .font(.custom(fontEnum.medium.rawValue, size: 12))
                            .foregroundColor(Color("empty text field"))
                    }
                                        
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                
                //............................................................
                
                HStack {
                   
                    HStack(spacing : 5){
                        Image("ticket")
                            .frame(width: 25 , height: 25)
                        
                        TextField("Enter voucher code", text: $textAddVoucher)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .overlay(
                        RoundedCorners(radius: 10, corners: .allCorners)
                            .stroke(Color("secondary"), lineWidth: 1)
                    )
                    
                    Button(action: {
                        //
                        
                    }, label: {
                        Text("Submit")
                            .frame(width: 100) // Set the height here
                            .frame(height: 60)
                            .font(.custom(fontEnum.medium.rawValue, size: 14))
                            .foregroundColor(Color("bg1")).background(Color("main2"))
                            .cornerRadius(10)
                    })
                }
                .frame(height: 60)
                //............................................................

                HStack {
                    VStack(alignment : .leading,spacing : 10 ) {
                        
                        Text("Use Wallet")
                            .font(.custom(fontEnum.bold.rawValue, size: 16))
                            .foregroundColor(Color("main1"))
                        Text("SAR 88.00")
                            .font(.custom(fontEnum.medium.rawValue, size: 12))
                            .foregroundColor(Color("main2"))
                    }
                    Spacer()
                    
                    Toggle(isOn: $useWallet) {
                        
                    }
                    .frame(width: 30, height: 20)
                    .padding()

                    
                }
                
                
                VStack (alignment : .leading ,spacing : 15){
                    
                    VStack(alignment : .leading,spacing : 5 ) {
                        
                        Text("Payment summary")
                            .font(.custom(fontEnum.bold.rawValue, size: 16))
                            .foregroundColor(Color("main1"))
                        Text("Add subtitle here")
                            .font(.custom(fontEnum.medium.rawValue, size: 12))
                            .foregroundColor(Color("empty text field"))
                    }
                    HStack {
                        Text("Subtotal")
                            .font(.custom(fontEnum.regular.rawValue, size: 12))
                            .foregroundColor(Color("main1"))
                        Spacer()
                        Text("SAR 66.00")
                            .font(.custom(fontEnum.medium.rawValue, size: 12))
                            .foregroundColor(Color("main1"))
                    }
                    
                    HStack {
                        Text("Services Fees")
                            .font(.custom(fontEnum.regular.rawValue, size: 12))
                            .foregroundColor(Color("main1"))
                        Spacer()
                        Text("SAR 66.00")
                            .font(.custom(fontEnum.medium.rawValue, size: 12))
                            .foregroundColor(Color("main1"))
                    }
                    
                    HStack {
                        Text("Wallet")
                            .font(.custom(fontEnum.regular.rawValue, size: 12))
                            .foregroundColor(Color("main1"))
                        Spacer()
                        Text("SAR -12.00")
                            .font(.custom(fontEnum.medium.rawValue, size: 12))
                            .foregroundColor(Color("wrong"))
                    }
                    HStack {
                        Text("Reward Discount")
                            .font(.custom(fontEnum.regular.rawValue, size: 12))
                            .foregroundColor(Color("main1"))
                        Spacer()
                        Text("SAR -12.00")
                            .font(.custom(fontEnum.medium.rawValue, size: 12))
                            .foregroundColor(Color("wrong"))
                    }
                    HStack {
                        Text("Voucher Discount")
                            .font(.custom(fontEnum.regular.rawValue, size: 12))
                            .foregroundColor(Color("main1"))
                        Spacer()
                        Text("SAR 00.00")
                            .font(.custom(fontEnum.medium.rawValue, size: 12))
                            .foregroundColor(Color("wrong"))
                    }
                    
                    //......................................................
                    
                    VStack {
                        
                        HStack {
                            Image("gift")
                                .resizable()
                                .frame(width: 50 , height: 50)
                            
                            Text("You will earn ")
                                .font(.custom(fontEnum.medium.rawValue, size: 10))
                                .foregroundColor(Color("main2"))
                            Text("100")
                                .font(.custom(fontEnum.bold.rawValue, size: 10))
                                .foregroundColor(Color("main2"))
                            Text("Points with this Order")
                                .font(.custom(fontEnum.medium.rawValue, size: 10))
                                .foregroundColor(Color("main2"))
                            Spacer()
                            
                        }
                        .padding(5)
                    }
                    .frame(width: .infinity)
                    .frame(height: 50)
                    .background(Color("bg1"))
                    .overlay(
                        RoundedCorners(radius: 10, corners: .allCorners)
                            .stroke(Color("main3"), lineWidth: 1)
                    )
                    
                    
                    
                    
                    
                    
                    HStack {
                        Text("Total amount")
                            .font(.custom(fontEnum.medium.rawValue, size: 14))
                            .foregroundColor(Color("main1"))
                        Spacer()
                        Text("SAR 45.00")
                            .font(.custom(fontEnum.medium.rawValue, size: 14))
                            .foregroundColor(Color("wrong"))
                    }
                    
                    
                    Button(action: {
                        //
                        
                    }, label: {
                        Text("Check Out")
                            .frame(maxWidth: .infinity) // Set the height here
                            .frame(height: 50)
                            .font(.custom(fontEnum.medium.rawValue, size: 14))
                            .foregroundColor(Color("bg1")).background(Color("main2"))
                            .cornerRadius(10)
                    })
                    
                    
                    
                    
                }
                .frame(maxWidth: .infinity)
                
                //............................................................
                
                
            }
            .padding(.horizontal ,15)
            
            
            Spacer()
        }
        
    }
}
