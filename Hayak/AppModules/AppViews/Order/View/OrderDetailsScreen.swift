//
//  OrderDetailsScreen.swift
//  Hayak
//
//  Created by Mohamed Ragab on 20/08/2024.
//

import SwiftUI

struct OrderDetailsScreen: View {
    
    @Environment(\.presentationMode) var presentationMode

    
    
    var body: some View {
        ZStack {
            Color(.white).ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
            
            VStack {
                CustomHeaderView(title: "order Details" , onBack: {
                    // Handle back button action
                    print("Back button pressed")
                    presentationMode.wrappedValue.dismiss()
                }, onOtherBtn: {
                }, OtherBtnIsfound: false , imageonOtherBtn: "", coloronOtherBtn: "")
                
                ExtractedViewOrderDetailsScreen()
            }
        }
    }
}

#Preview {
    OrderDetailsScreen()
}



struct ExtractedViewOrderDetailsScreen : View {
    
    @State var showDetails : Bool = false
    @State var plusMinus : Int = 1

    var body: some View {
        
        
        VStack(spacing : 20) {
            
            HStack(spacing : 10) {
                
                Image("2")
                    .resizable()
                    .frame(width: 100 , height: 100)
                
                VStack(alignment : .leading , spacing : 10) {
                    Spacer()
                    
                    HStack {
                        Text("Subway, Dubai World Trad...")
                            .foregroundColor(Color("main1"))
                            .font(.custom("LamaSans-Medium", size:12))
                        Spacer()
                        
                        Button("" ,systemImage: "chevron.right") {
                            showDetails.toggle()
                        }
                        .foregroundColor(Color("main1"))
                        .frame(width: 25 , height: 25)
                       
                    }
                    
                    Text("Delivered")
                        .foregroundColor(Color("main2"))
                        .font(.custom("LamaSans-Medium", size:12))
                    
                    Text("24 September 2023 16:17")
                        .foregroundColor(Color("black50%"))
                        .font(.custom("LamaSans-Medium", size:12))
                    
                    Text("Order ID: 1284566612")
                        .foregroundColor(Color("black50%"))
                        .font(.custom("LamaSans-Medium", size:12))
                  
                    Spacer()

                    
                }
                
            }
            .frame(height: 100)
            
            
            if showDetails {
                
                List {
                    ForEach(0 ..< 5) {_ in
                            HStack(spacing : 10) {
                                
                                VStack(alignment : .leading , spacing : 10) {

                                    Text("Pink Risotto")
                                        .foregroundColor(Color("main1"))
                                        .font(.custom(fontEnum.semiBold.rawValue, size:14))
                                    
                                    Text("SAR 66.00")
                                        .foregroundColor(Color("main1"))
                                        .font(.custom(fontEnum.semiBold.rawValue, size:12))

                                    Text("Your Choice of Sauce")
                                        .foregroundColor(Color("main1"))
                                        .font(.custom(fontEnum.regular.rawValue, size:10))

                                    Text("Spicy Sauce")
                                        .foregroundColor(Color("main1"))
                                        .font(.custom(fontEnum.semiBold.rawValue, size:10))
                                    
                                    Text("Pasta Sauce (+7 SAR)")
                                        .foregroundColor(Color("main1"))
                                        .font(.custom(fontEnum.semiBold.rawValue, size:10))
                                    Text("Your Choice of Sandwich")
                                        .foregroundColor(Color("main1"))
                                        .font(.custom(fontEnum.regular.rawValue, size:10))
                                    Text("Spicy (+15 SAR)")
                                        .foregroundColor(Color("main1"))
                                        .font(.custom(fontEnum.semiBold.rawValue, size:10))
                                    Text("Your Choice of Drink")
                                        .foregroundColor(Color("main1"))
                                        .font(.custom(fontEnum.regular.rawValue, size:10))
                                    Text("Cola")
                                        .foregroundColor(Color("main1"))
                                        .font(.custom(fontEnum.semiBold.rawValue, size:10))

                                }
                                Spacer()

                                VStack (spacing : -10){
                                    Image("od")
                                        .resizable()
                                        .frame(width: 100 , height: 100)
                                    HStack {
                                       Image(systemName: "plus")
                                        .frame(width: 20 , height: 20 )
                                        .foregroundColor(.white)
                                        .onTapGesture {
                                            plusMinus += 1
                                        }
                                        Spacer()
                                        Text("\(plusMinus)")
                                            .foregroundColor(.white)
                                            .font(.custom(fontEnum.regular.rawValue, size:16))
                                        Spacer()
                                       
                                        Image(systemName: "minus")
                                        .frame(width: 20 , height: 20 )
                                        .foregroundColor(.white)
                                        .onTapGesture {
                                            plusMinus -= 1
                                        }
                                    }
                                    .padding(.horizontal , 10)
                                    .frame(width: 100 , height: 25)
                                    .background(Color("main2"))
                                    .cornerRadius(15)

                                }
                                .frame(width: 120)
                                
                            }
                            .padding(.vertical , 10)
                            .frame(height: 200)
                    }
                }
                .listStyle(.plain)
                .listRowSeparator(.hidden)
                
                
            }
            
            // views
            VStack(alignment : .leading , spacing: 10) {
                
                Text("Payment summary")
                    .foregroundColor(Color("main1"))
                    .font(.custom(fontEnum.semiBold.rawValue, size:16))
                
                HStack {
                    Text("Subtotal")
                        .foregroundColor(Color("main1"))
                        .font(.custom(fontEnum.regular.rawValue, size:12))
                    Spacer()
                    Text("SAR 66.00")
                        .foregroundColor(Color("main1"))
                        .font(.custom(fontEnum.medium.rawValue, size:12))
                }
                
                
                HStack {
                    Text("Service fee")
                        .foregroundColor(Color("main1"))
                        .font(.custom(fontEnum.regular.rawValue, size:12))
                    Spacer()
                    Text("SAR 1.90")
                        .foregroundColor(Color("main1"))
                        .font(.custom(fontEnum.medium.rawValue, size:12))
                }
                HStack {
                    Text("Total amount")
                        .foregroundColor(Color("main1"))
                        .font(.custom(fontEnum.medium.rawValue, size:14))
                    Spacer()
                    Text("SAR 76.98")
                        .foregroundColor(Color("main1"))
                        .font(.custom(fontEnum.medium.rawValue, size:14))
                }
                Spacer()
                    .frame(height: 5)

                
            }

            
            
            Spacer()
            
    
        }
        .padding(.horizontal , 20)
    }
}
