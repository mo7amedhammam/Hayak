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


struct OrderStatus : Identifiable,Equatable  {
    var id : Int
    var name: String
    var selected: Bool
    
    init(id: Int, name: String, selected: Bool) {
        self.id = id
        self.name = name
        self.selected = selected
    }
}

struct ExtractedViewYourOrderScreen : View {
    
    @State private var items = [
        OrderStatus(id : 0 ,name: "Delivered",selected : true ),
        OrderStatus(id : 1 ,name: "Submitted",selected : false ),
        OrderStatus(id : 2 ,name: "Pending"  ,selected : false),
        OrderStatus(id : 3 ,name: "Cancelled",selected : false)
       ]
    @State var selecteditem = OrderStatus(id : 0 ,name: "Delivered",selected : true )
    
    var body: some View {
        
        VStack (spacing : 10) {
            
            VStack {
                ScrollView (.horizontal , showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(items){ item in
                            Button(action: {
//                                item.selected.toggle()
//                                for data in items {
                                    selecteditem = item
//                                    data.selected = (item.tag == data.tag)
//                                    print("data.selected : \(data.selected)")
//                                }
                            }, label: {
                                Text(item.name)
                                    .font(.custom(item == selecteditem ? "LamaSans-Medium" : "LamaSans-Regular", size: item.selected ? 12 : 10))
                                    .padding()
                                    .background(item == selecteditem ? Color("main2") : .clear)
                                    .foregroundColor(item == selecteditem ? .white : Color("main1"))
                                    .cornerRadius(30)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 30)
                                            .stroke(item == selecteditem ? .clear : Color("main2") , lineWidth: 1)
                                    
                                    )
                            })
//                            .tag(item.id)
                        }
                    }
                }

                
            }.frame(height: 50)
                .background(.clear)
                .padding(.horizontal , 15)
          
            List {
                ForEach(0 ..< 10) {_ in
                    
                    VStack(spacing : 0) {
                        
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
                    .listRowSeparator(.hidden)
                    
                    customDivider()
                        .padding(.horizontal,-20)
                        .listRowSeparator(.hidden) // Hide the separator lines
                    
                }
            }
            .listStyle(.plain)

        }
        
    }
}

 func customDivider() -> some View {
    return
    
    Color(.black).opacity(0.2)
        .frame(maxHeight: 0.5)
}
