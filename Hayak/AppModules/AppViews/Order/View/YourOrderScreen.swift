//
//  YourOrderScreen.swift
//  Hayak
//
//  Created by Mohamed Ragab on 13/08/2024.
//

import SwiftUI

struct YourOrderScreen: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color(.white).ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
            
            VStack {
                CustomHeaderView(title: "Your orders" , onBack: {
                    // Handle back button action
                    print("Back button pressed")
                    presentationMode.wrappedValue.dismiss()
                }, onOtherBtn: {
                }, OtherBtnIsfound: false , imageonOtherBtn: "", coloronOtherBtn: "")
                
                ExtractedViewYourOrderScreen()
            }
        }
    }
}

#Preview {
    YourOrderScreen()
}


class OrderStatus : Identifiable ,ObservableObject {
    var tag : Int
    var name: String
    @Published var selected: Bool
    
    init(tag: Int, name: String, selected: Bool) {
        self.tag = tag
        self.name = name
        self.selected = selected
    }
}

struct ExtractedViewYourOrderScreen : View {
    
    @State private var items = [
        OrderStatus(tag : 0 ,name: "Delivered",selected : true ),
        OrderStatus(tag : 1 ,name: "Submitted",selected : false ),
        OrderStatus(tag : 2 ,name: "Pending"  ,selected : false),
        OrderStatus(tag : 3 ,name: "Cancelled",selected : false)
       ]
    
        
    var body: some View {
        
        VStack (spacing : 10) {
            
            VStack {
                ScrollView (.horizontal , showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(items){ item in
                            Button(action: {
                                for data in items {
                                    data.selected = (item.tag == data.tag)
                                    print("data.selected : \(data.selected)")
                                }
                            }, label: {
                                Text(item.name)
                                    .font(.custom(item.selected ? "LamaSans-Medium" : "LamaSans-Regular", size: item.selected ? 12 : 10))
                                    .padding()
                                    .background(item.selected ? Color("main2") : .clear)
                                    .foregroundColor(item.selected ? .white : Color("main1"))
                                    .cornerRadius(30)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 30)
                                            .stroke(item.selected ? .clear : Color("main2") , lineWidth: 1)
                                    
                                    )
                            }).tag(item.tag)
                        }
                    }
                }

                
            }.frame(height: 50)
                .background(.clear)
                .padding(.horizontal , 15)
          
            List {
                ForEach(0 ..< 10) {_ in
                    
                    VStack(spacing : 10) {
                        
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
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color("main1"))
                                        .frame(width: 25 , height: 25)
                                }
                                
                                Text("Delivered")
                                    .foregroundColor(Color("main2"))
                                    .font(.custom("LamaSans-Medium", size:12))
                                
                                Text("24 September 2023 16:17")
                                    .foregroundColor(Color("main1"))
                                    .font(.custom("LamaSans-Medium", size:12))
                                
                                Text("Order ID: 1284566612")
                                    .foregroundColor(Color("main1"))
                                    .font(.custom("LamaSans-Medium", size:12))
                                
                                HStack {
                                    Button(action: {
                                      
                                    }, label: {
                                        HStack {
                                            Image("refresh")
                                                .resizable()
                                                .frame(width: 16 , height: 16)
                                            Text("Re-order")
                                                .foregroundColor(Color("main2"))
                                                .font(.custom("LamaSans-Medium", size:12))
                                        }
                                    })
                                    
                                    Spacer()
                                    Button(action: {
                                      
                                    }, label: {
                                        HStack {
                                            Image("haha")
                                                .resizable()
                                                .frame(width: 16 , height: 16)
                                            Text("Rate order")
                                                .foregroundColor(Color("main2"))
                                                .font(.custom("LamaSans-Medium", size:12))
                                        }
                                    })
                                }
                                .frame(height: 30)


                            }
                            
                        }

                        // Background color applied here
                                  VStack {
                                      Spacer()
                                          .frame(height: 5)
                                  }
                                  .background(Color("black10%"))
                  
                       
                    }
                    .padding(.vertical , 10)
                    .frame(height: 130)
                    
                }
            }
            .listStyle(.plain)
            .listRowSeparator(.hidden) // Hide the separator lines

        }
        
    }
}

