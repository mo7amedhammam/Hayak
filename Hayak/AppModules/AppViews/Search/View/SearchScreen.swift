//
//  SearchScreen.swift
//  Hayak
//
//  Created by Mohamed Ragab on 22/08/2024.
//

import SwiftUI

struct SearchScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @State var textSearch : String = ""
    @State var searchEmpty : Bool = false
    @State var showPopularSearch : Bool = true
    
    var body: some View {
        ZStack {
            Color(.white).ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
            
            
            VStack{
                
                VStack {
                    HStack (spacing : 10){
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .foregroundColor(Color("main1"))
                            .frame(width: 25 , height: 25)
                        
                        TextField("Search for Restaurants", text: $textSearch)
                            .foregroundColor(Color("empty text field"))
                            .font(.custom(fontEnum.bold.rawValue, size: 14))
                    }
                    .padding(.horizontal , 10)
                }
                .frame(height: 55)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("secondary"), lineWidth: 2)
                )
                .padding()
                
                if showPopularSearch {
                    ExtractedViewShowPopularSearch()
                }
                
                if searchEmpty {
                    ExtractedViewEmptySearch()
                }
                
                
                
                
                Spacer()
            }
        }
    }
}

#Preview {
    SearchScreen()
}



struct ExtractedViewEmptySearch : View {
    var body: some View {
        VStack {
            Text("Your Search History is Empty")
                .frame(maxWidth: .infinity , alignment: .leading)
                .foregroundColor(Color("main1"))
                .font(.custom(fontEnum.bold.rawValue, size: 14))
                .padding()
            
            Spacer()
                .frame(height: 150)
            
            Image("search")
                .resizable()
                .frame(width: 200 , height: 200)
            
            Spacer()
        }
    }
}


struct ModelPopularSearch: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
}

struct ExtractedViewShowPopularSearch : View {
    
    let items = [
        ModelPopularSearch(imageName: "star.fill", title: "Star"),
        ModelPopularSearch(imageName: "heart.fill", title: "Heart"),
        ModelPopularSearch(imageName: "moon.fill", title: "Moon"),
        ModelPopularSearch(imageName: "sun.max.fill", title: "Sun"),
        ModelPopularSearch(imageName: "cloud.fill", title: "Cloud"),
        ModelPopularSearch(imageName: "cloud.fill", title: "Cloud"),
        ModelPopularSearch(imageName: "cloud.fill", title: "Cloud"),
        ModelPopularSearch(imageName: "cloud.fill", title: "Cloud"),

    ]
    
    
    var body: some View {
        VStack {
            
            Text("Popular searches")
                .frame(maxWidth: .infinity , alignment: .leading)
                .foregroundColor(Color("main1"))
                .font(.custom(fontEnum.bold.rawValue, size: 14))
                .padding()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(items) { item in
                        HStack {
                            Image(systemName: item.imageName)
                                .resizable()
                                .foregroundColor(Color("main1"))
                                .frame(width: 25, height: 25)
                                .padding()
                            
                            Text(item.title)
                                .foregroundColor(Color("main1"))
                                .font(.caption)
                                .padding(.top, 4)
                        }
                        .frame(maxWidth: .infinity)

                    }
                }
            }
            
            Spacer()
        }
        .frame(height: 150)
    }
}
