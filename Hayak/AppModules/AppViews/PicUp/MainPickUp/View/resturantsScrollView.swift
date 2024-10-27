//
//  resturantsScrollView.swift
//  Hayak
//
//  Created by wecancity on 31/08/2024.
//

import SwiftUI

struct restaurant : Hashable {
        var id : Int? = 0
       var name : String? = "Burgers"
       var imageUrl : String? = "2"
}

struct restaurantsScrollView: View {
    var resturants : [MainCategoriesM] = []
    @Binding var selectedResturant:MainCategoriesM?
    
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false){
            HStack{
                ForEach(resturants,id: \.self){resturant in
                    Button(action: {
                        selectedResturant = resturant
                    }, label: {
                        VStack{
                            
//                            KFImageLoader(urlStr: resturant.imageURL, placeholder: Image("2"))
//                                .frame(width: 70, height: 70, alignment: .center)
//                                .padding(10)
//                                .background{Color(selectedResturant == resturant ? "active text":"color-E5E5E5").cornerRadius(12)}
                            
                            
                            KFImageLoader(urlStr: resturant.imageURL, placeholder: Image("2"))
                                .frame(width: 70, height: 70, alignment: .center)
                                .padding(10)
                                .background{Color(selectedResturant == resturant ? "active text":"color-E5E5E5").cornerRadius(12)}
                            
                            Text(resturant.name ?? "")
                                .foregroundColor(selectedResturant == resturant ? .activeText:.main2)
                                .font(.custom(fontEnum.semiBold.rawValue, size:15))
                        }
                    })

                }
            }   

        }
    }
}

#Preview {
    restaurantsScrollView(resturants: [], selectedResturant: .constant(MainCategoriesM.init()))
}


struct restaurantsFilter: View {
    var resturants : [restaurant] = [restaurant(id: 1, name: "Burgers", imageUrl: "2"),restaurant(id: 2, name: "Burgers", imageUrl: "2"),restaurant(id: 3, name: "Burgers", imageUrl: "2"),restaurant(id: 4, name: "Burgers", imageUrl: "2"),restaurant(id: 5, name: "Burgers", imageUrl: "2"),restaurant(id: 6, name: "Burgers", imageUrl: "2")]
    
    @Binding var selectedResturant:restaurant
    
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false){
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
                            
                            Text(resturant.name ?? "")
                                .foregroundColor(selectedResturant == resturant ? .activeText:.main2)
                                .font(.custom(fontEnum.semiBold.rawValue, size:15))
                        }
                    })
                }
            }
        }
    }
}

