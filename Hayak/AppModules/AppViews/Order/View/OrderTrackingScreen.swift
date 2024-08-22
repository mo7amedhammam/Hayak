//
//  OrderTrackingScreen.swift
//  Hayak
//
//  Created by Mohamed Ragab on 21/08/2024.
//

import SwiftUI

struct OrderTrackingScreen: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color(UIColor(named: "bg1")!).ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
            
            VStack {
                CustomHeaderView(title: "Order Tracking" , onBack: {
                    // Handle back button action
                    print("Back button pressed")
                    presentationMode.wrappedValue.dismiss()
                }, onOtherBtn: {
                }, OtherBtnIsfound: false , imageonOtherBtn: "", coloronOtherBtn: "")
                
                ExtractedViewOrderTrackingScreen()
            }
        }
    }
}

#Preview {
    OrderTrackingScreen()
}


struct ExtractedViewOrderTrackingScreen: View {
    
    var body: some View {
        
        VStack {
          
            VStack {
              
                VStack (spacing : 15){
                    HStack {
                        Text("Your Booking code:")
                            .foregroundColor(Color("main1"))
                            .font(.custom(fontEnum.bold.rawValue, size:14))
                        Spacer()
                        Text("#800715")
                            .foregroundColor(Color("main2"))
                            .font(.custom(fontEnum.bold.rawValue, size:14))

                    }
                    HStack {
                        Text("3 Services")
                            .foregroundColor(Color("main1"))
                            .font(.custom(fontEnum.bold.rawValue, size:14))
                        Spacer()
                        Text("$23.5")
                            .foregroundColor(Color("main2"))
                            .font(.custom(fontEnum.bold.rawValue, size:14))
                    }
                }
                .frame(height: 90)
                .padding(.horizontal , 20)
                .background(Color("bg1"))
                .cornerRadius(20)
                .padding(20)


                
                
                HStack {
                    
                    VStack {
                        Image("oval")
                        Spacer()
                        Image("oval")
                        Spacer()
                        Image("oval")
                        Spacer()
                        Image("oval")
                    }
                    .frame(width: 50, height: 200)  // Set the size of the container
                    .background(
                        Color("main2") // Vertical line color
                            .frame(width: 3) // Vertical line width
                            .cornerRadius(3) // Optional: to make the line rounded
                    )
                    .padding(.bottom , 20)
                 
                    VStack(alignment: .leading , spacing : 20) {

                        VStack(alignment: .leading ,  spacing : 10){
                            Text("Food Delivered")
                                .foregroundColor(Color("main1"))
                                .font(.custom(fontEnum.bold.rawValue, size:14))
                            Text("Estimated for 7 July, 2021")
                                .foregroundColor(Color("empty text field"))
                                .font(.custom(fontEnum.medium.rawValue, size:13))
                        }
                        
                        VStack(alignment: .leading ,  spacing : 10){
                            Text("Reached at location")
                                .foregroundColor(Color("main1"))
                                .font(.custom(fontEnum.bold.rawValue, size:14))
                            Text("Estimated for 5 July, 2021")
                                .foregroundColor(Color("empty text field"))
                                .font(.custom(fontEnum.medium.rawValue, size:13))
                        }
                        
                        
                        VStack(alignment: .leading ,  spacing : 10){
                            Text("Confirmed")
                                .foregroundColor(Color("main1"))
                                .font(.custom(fontEnum.bold.rawValue, size:14))
                            Text("Your Booking has been confirmed")
                                .foregroundColor(Color("empty text field"))
                                .font(.custom(fontEnum.medium.rawValue, size:13))
                        }
                        
                        VStack(alignment: .leading ,  spacing : 10){
                            Text("Booking placed")
                                .foregroundColor(Color("main1"))
                                .font(.custom(fontEnum.bold.rawValue, size:14))
                            Text("We have received your order")
                                .foregroundColor(Color("empty text field"))
                                .font(.custom(fontEnum.medium.rawValue, size:13))
                        }
                    }
                    
                    
                    Spacer()

                    
                }
                .frame(height: 230)
                
             
                Spacer()
            }
            .frame(height: 400)
            .frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius(20)
            .padding()
            
            Spacer()
                .frame(height: 50)
            
         
            Button(action: {
                //back
                
            }, label: {
                Text("Back to Home")
                    .frame(height: 50) // Set the height here
                    .frame(maxWidth: .infinity)
                    .font(.custom("LamaSans-Medium", size: 14))
                    .foregroundColor(Color("bg1")).background(Color("main2"))
                    .cornerRadius(11)
                    .padding(.horizontal , 20)
            })
            
            
            Spacer()
        }
        .frame(width: .infinity)

    }
    
}

