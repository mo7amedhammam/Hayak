//
//  PicUpView.swift
//  Hayak
//
//  Created by Mohamed Ragab on 22/07/2024.
//

import SwiftUI
import Kingfisher

struct PicUpView: View {
    @Environment(\.presentationMode) var presentationMode
    func createshoppingimg() -> some View {
        return Image(.shoppingicon)
            .resizable()
            .padding(6)
            .background{Color(.main).clipShape(Circle())}
            .frame(width: 33, height: 33)
    }
    var body: some View {
//        ZStack {
//            Color(.white).ignoresSafeArea()
//                .navigationBarBackButtonHidden(true)
            
            VStack {
                
                CustomPickupHeaderView(title: "Saudi Arabia", subtitle: "Al Riadh city", onBack: {}, btnimg2:createshoppingimg(), onbtnimg2: {}, btnimg3: Image(.favoriteiconempty), onbtnimg3: {}, btnimg4: Image("carbon_search"), onbtnimg4: {})

                PickUpContentView()
            Spacer()
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


struct PickUpContentView: View {
//    @Environment(\.presentationMode) var presentationMode
    @State var selectedResturant:restaurant = restaurant.init()

    var body: some View {
        VStack {
            Text("All restaurants")
                .frame(maxWidth: .infinity,alignment: .leading)
                .foregroundColor(.activeText)
                .font(.custom(fontEnum.bold.rawValue, size:14))
                .padding(.top)
                .padding(.bottom,5)
                .padding(.horizontal)

            restaurantsScrollView( selectedResturant: $selectedResturant)
//                .edgesIgnoringSafeArea(.horizontal)
//                .clipped()
            List(){
                pickUpCellView(pickUp: pickUpCellModel(id: 1,title:"Subway, Dubai World Trad...", subTitle:"Sandwiches, Beverages, Wraps", image: "pickupbgtest",subImage: "od") )
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .padding(5)


            }
            .listStyle(.plain)
            .padding(.horizontal)

//            .background(Color.green)
//            Spacer()
        }
//        .padding(.horizontal)
        .background{
            Color(.bg1).ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
        }
    }
}




struct restaurant : Hashable {
        var id : Int = 0
       var name : String = "Burgers"
       var imageUrl : String = "2"
}

struct restaurantsScrollView: View {
    var resturants : [restaurant] = [restaurant(id: 1, name: "Burgers", imageUrl: "2"),restaurant(id: 2, name: "Burgers", imageUrl: "2"),restaurant(id: 3, name: "Burgers", imageUrl: "2"),restaurant(id: 4, name: "Burgers", imageUrl: "2"),restaurant(id: 5, name: "Burgers", imageUrl: "2"),restaurant(id: 6, name: "Burgers", imageUrl: "2")]
    
    @Binding var selectedResturant:restaurant
    
    var body: some View {
        ScrollViewRTL(type: .hList){
            HStack{
                ForEach(resturants,id: \.self){resturant in
                    Button(action: {
                        selectedResturant = resturant
                    }, label: {
                        VStack{
                            KFImageLoader(urlStr: resturant.imageUrl, placeholder: Image("2"))
                                .frame(width: 70, height: 70, alignment: .center)
                                .padding(10)
                                .background{Color(selectedResturant == resturant ? "active text":"color-E5E5E5").cornerRadius(12)}
                            
                            Text(resturant.name)
                                .foregroundColor(selectedResturant == resturant ? .activeText:.main2)
                                .font(.custom(fontEnum.semiBold.rawValue, size:15))
                        }
                    })
                }
            }
        }
    }
}


struct pickUpCellModel : Hashable {
        var id : Int = 0
       var title : String = "Subway, Dubai World Trad Subway, Dubai World Trad"
       var subTitle : String = "Sandwiches, Beverages, Wraps"

    var image : String = "Sandwiches, Beverages, Wraps"
    var subImage : String = "od"
    
}

struct pickUpCellView: View {
    var pickUp : pickUpCellModel
    
//    @Binding var selectedResturant:restaurant
    
    var body: some View {

        VStack(spacing:0){
            ZStack (){
                KFImageLoader(urlStr: pickUp.image, placeholder: Image("pickupbgtest"))
                    .placeholder.resizable().scaledToFill()
                
                VStack{
                    HStack{
                            HStack(spacing:2){
                                Image(.clocklight)
                                    .resizable()
                                    .frame(width: 13, height: 13, alignment:.center)
                               
                                Group{
                                    Text("31")
                                    Text("mins")
                                }
                                    .foregroundColor(.main1)
                                    .font(.custom(fontEnum.regular.rawValue, size:10))

                            }
                        .padding(.horizontal,5)
                        .padding(.vertical,2)
                        .background{Color.white.clipShape(Capsule())}
                        .borderRadius(.black25,width: 1, cornerRadius: 12, corners: .allCorners)

                        
                        HStack(spacing:2){
                            Image(.mapwithpin)
                                .resizable()
                                .frame(width: 13, height: 13, alignment:.center)
                           
                            Group{
                                Text("5.4")
                                Text("KM")
                            }
                                .foregroundColor(.main1)
                                .font(.custom(fontEnum.regular.rawValue, size:10))

                        }
//                        })
                    .padding(.horizontal,5)
                    .padding(.vertical,2)
                    .background{Color.white.clipShape(Capsule())}
                    .borderRadius(.black25,width: 1, cornerRadius: 12, corners: .allCorners)

                        Spacer()
                        
                        Button(action: {
                            
                        }, label: {
                            Image(.unlove)
                        })
                        
                    }
                    .padding()
                    Spacer()
                Text("Recommended by Hayak")
                    .foregroundColor(.white)
                    .padding(.horizontal,10)
                    .padding(.vertical,3)
                    .font(.custom(fontEnum.regular.rawValue, size:12))
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .background{Color.main}
            }
            }
//                                .frame(width: 70, height: 70, alignment: .center)
//                                .padding(10)
//                                .background{Color(selectedResturant == resturant ? "active text":"color-E5E5E5").cornerRadius(12)}
                            
            VStack(alignment: .leading,spacing: 5) {
                Text(pickUp.title)
                    .foregroundColor(.main1)
                    .font(.custom(fontEnum.regular.rawValue, size:12))
                    
                HStack {
                    Text(pickUp.subTitle)
                        .foregroundColor(.main2)
                    .font(.custom(fontEnum.regular.rawValue, size:10))
                    .frame(maxWidth: .infinity,alignment: .leading)
                    
                    VStack{
                        HStack(spacing:5){
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow)
                            
                            Text("4.5")
                                .foregroundColor(.black)
                                .font(.custom(fontEnum.light.rawValue, size:12))
                            
                            Text("( \(100)+)")
                                .foregroundColor(.main2)
                                .font(.custom(fontEnum.regular.rawValue, size:12))
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(10)


            .borderRadius(.main,width: 1.2, cornerRadius: 12, corners: [.bottomLeft,.bottomRight])
            .padding(.horizontal,0.8)
            
            .overlay(content: {
                HStack{
                    Spacer()
                    KFImageLoader(urlStr: pickUp.subImage, placeholder: Image("od"))
                        .placeholder.resizable().frame(width: 70,height: 60).scaledToFill().cornerRadius(8)
                }
                .padding(.trailing,20)
                //                    .padding(.bottom,14)
                .offset(y:-50)
            })
        }
        .background(Color.white.cornerRadius(12))
//        .padding(.horizontal,4)
//        .padding(.bottom,4)
        .clipShape(.rect(cornerRadius: 12))
        
    }
}
