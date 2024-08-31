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
    
    @State var rateOrder : Bool = false
    @State var rating: Int = 0

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
                                    .font(.custom(fontEnum.medium.rawValue, size:12))
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color("main1"))
                                        .frame(width: 25 , height: 25)
                                }
                                
                                Text("Delivered")
                                    .foregroundColor(Color("main2"))
                                    .font(.custom(fontEnum.medium.rawValue, size:12))
                                
                                Text("24 September 2023 16:17")
                                    .foregroundColor(Color("main1"))
                                    .font(.custom(fontEnum.medium.rawValue, size:12))
                                
                                Text("Order ID: 1284566612")
                                    .foregroundColor(Color("main1"))
                                    .font(.custom(fontEnum.medium.rawValue, size:12))
                                
                                HStack {
                                    Button(action: {
                                      
                                    }, label: {
                                        HStack {
                                            Image("refresh")
                                                .resizable()
                                                .frame(width: 16 , height: 16)
                                            Text("Re-order")
                                                .foregroundColor(Color("main2"))
                                                .font(.custom(fontEnum.medium.rawValue, size:12))
                                        }
                                    })
                                    
                                    Spacer()
                                    Button(action: {
                                        rateOrder.toggle()
                                    }, label: {
                                        HStack {
                                            Image("haha")
                                                .resizable()
                                                .frame(width: 16 , height: 16)
                                            Text("Rate order")
                                                .foregroundColor(Color("main2"))
                                                .font(.custom(fontEnum.medium.rawValue, size:12))
                                        }
                                    })
                                  
                                    .sheet(isPresented: $rateOrder) {
                                        if #available(iOS 16.0, *) {
                                            RateOrderView(rating: $rating)
                                                .presentationDetents([.fraction(0.6) , .fraction(0.9)])
                                                .presentationDragIndicator(.hidden)
                                        } else {
                                            // Fallback on earlier versions
                                        }
                                    }


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



struct RateOrderView: View {
    
    @Environment (\.presentationMode) var presentationMode
    
    @Binding var rating: Int
      var maxRating: Int = 5
      var offImage: Image?
      var onImage: Image = Image(systemName: "star.fill")
      var offColor = Color("color-E5E5E5")
      var onColor = Color.yellow
    
    
    private func image(for number: Int) -> Image {
           if number > rating {
               return offImage ?? onImage
           } else {
               return onImage
           }
       }
    
    var body: some View {

        ZStack {
            Color.white.ignoresSafeArea()
            //
            
            VStack {
               
                HStack {
                    Spacer()
                    Image(systemName: "xmark")
                        .foregroundColor(.red)
                        .frame(width: 25 , height: 25)
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                }
                
                Image("1")
                    .resizable()
                    .frame(width: 130 , height: 130)

                
                Text("How was your order from Mandarin Oak")
                    .multilineTextAlignment(.center)
                    .lineSpacing(10.0)
                    .foregroundColor(.black)
                    .font(.custom(fontEnum.bold.rawValue, size:18))
                    .padding()
                
                Spacer()
                    .frame(height: 15)
                
                HStack {
                         ForEach(1..<maxRating + 1, id: \.self) { number in
                             image(for: number)
                                 .resizable()
                                 .frame(width: 30, height: 30)
                                 .foregroundColor(number > rating ? offColor : onColor)
                                 .onTapGesture {
                                     rating = number
                                 }
                         }
                     }
                
                
                Spacer()
                    .frame(height: 15)
                
                Spacer()
                
                
                Button(action: {
                    //
                    
                }, label: {
                    Text("Submit")
                        .frame(height: 50) // Set the height here
                        .frame(maxWidth: .infinity)
                        .font(.custom(fontEnum.medium.rawValue, size: 14))
                        .foregroundColor(Color("bg1")).background(Color("main2"))
                        .cornerRadius(11)
                        .padding(.horizontal , 20)
                })
                
                
                
            }
            .frame(width: .infinity)
            
           
         
            
        }
        .padding(20)

    }
}
