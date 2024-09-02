//
//  PicUpView.swift
//  Hayak
//
//  Created by Mohamed Ragab on 22/07/2024.
//

import SwiftUI
import Kingfisher

func createshoppingimg() -> some View {
    return Image(.shoppingicon)
        .resizable()
        .padding(6)
        .background{Color(.main).clipShape(Circle())}
        .frame(width: 33, height: 33)
}

struct PicUpView: View {
    @Environment(\.presentationMode) var presentationMode
        @State var selectedResturant:restaurant = restaurant.init()

    @State var isActive : Bool = false
    @State var destination : AnyView = AnyView(EmptyView())

    @State private var items = [
        OrderStatus(id : 0 ,name: "Recommendation",iconstr: "sorticon"),
        OrderStatus(id : 1 ,name: "Radius",iconstr:"mapwithpin"),
        OrderStatus(id : 2 ,name: "Rating 4.0+",iconstr:"starempty")
    ]
    @State var selecteditem = OrderStatus(id : 0 ,name: "Delivered" )
    
    var body: some View {
//        ZStack {
//            Color(.white).ignoresSafeArea()
//                .navigationBarBackButtonHidden(true)
            
            VStack {
                
                CustomPickupHeaderView(title: "Saudi Arabia", subtitle: "Al Riadh city",btnbackimg: nil, onBack: {}, btnimg2:createshoppingimg(), onbtnimg2: {}, btnimg3: Image(.favoriteiconempty), onbtnimg3: {}, btnimg4: Image("carbon_search"), onbtnimg4: {})
                    .padding(.horizontal)
                
//                PickUpContentView()
                        VStack {
                            Text("All restaurants")
                                .frame(maxWidth: .infinity,alignment: .leading)
                                .foregroundColor(.activeText)
                                .font(.custom(fontEnum.bold.rawValue, size:14))
                                .padding(.top)
                                .padding(.bottom,5)
                                .padding(.horizontal)
                
                            restaurantsScrollView(selectedResturant: $selectedResturant)
                            
                            ScrollViewRTL(type: .hList){
                                    HStack(spacing: 10) {
                                        ForEach(items){ item in
                                            cpsuleBtnView(item: item,isselecteditem: .constant(item == selecteditem),onAction: {
                                                selecteditem = item
                                            })
                //                            .tag(item.id)
                                        }
                                    }
                                    .padding(.leading,2)
                                    
                                
                            }
                            
                            
                
                            List(){
                                pickUpCellView(pickUp: pickUpCellModel(id: 1,title:"Subway, Dubai World Trad...", subTitle:"Sandwiches, Beverages, Wraps", image: "pickupbgtest",subImage: "od") ,onSelect: {
                                    destination = AnyView( MenueView().navigationBarBackButtonHidden(true) )
                                    self.isActive = true
                                },onClickLove: {
                                    
                                })
                                    .listRowSeparator(.hidden)
                                    .listRowBackground(Color.clear)
                                    .padding(5)
                            }
                            .listStyle(.plain)
                            .padding(.horizontal)
                        }
//                        .padding(.horizontal)
                        .background{
                            Color(.bg1).ignoresSafeArea()
                                .navigationBarBackButtonHidden(true)
                        }
            Spacer()
                NavigationLink(
                    destination: destination,
                    isActive: $isActive,
                    label: {EmptyView()})
            }
            .background{
                Color(.white).ignoresSafeArea()
                    .navigationBarBackButtonHidden(true)
            }
        

//        }
    }
}

#Preview {
    PicUpView()
}


//struct PickUpContentView: View {
//    @State var selectedResturant:restaurant = restaurant.init()
//
//    var body: some View {
//        VStack {
//            Text("All restaurants")
//                .frame(maxWidth: .infinity,alignment: .leading)
//                .foregroundColor(.activeText)
//                .font(.custom(fontEnum.bold.rawValue, size:14))
//                .padding(.top)
//                .padding(.bottom,5)
//                .padding(.horizontal)
//
//            restaurantsScrollView( selectedResturant: $selectedResturant)
//
//            List(){
//                pickUpCellView(pickUp: pickUpCellModel(id: 1,title:"Subway, Dubai World Trad...", subTitle:"Sandwiches, Beverages, Wraps", image: "pickupbgtest",subImage: "od") )
//                    .listRowSeparator(.hidden)
//                    .listRowBackground(Color.clear)
//                    .padding(5)
//
//
//            }
//            .listStyle(.plain)
//            .padding(.horizontal)
//        }
////        .padding(.horizontal)
//        .background{
//            Color(.bg1).ignoresSafeArea()
//                .navigationBarBackButtonHidden(true)
//        }
//    }
//}

