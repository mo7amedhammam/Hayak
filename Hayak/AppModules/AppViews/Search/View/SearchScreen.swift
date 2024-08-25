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
    @State var searchEmpty : Bool       = false
    @State var showPopularSearch : Bool = true
    @State var searchRecently : Bool = true
    
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
                
                if searchRecently {
                    ExtractedViewRecentlySearch()
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
        
        VStack(alignment: .leading) {

            Text("Popular searches")
                .frame(maxWidth: .infinity , alignment: .leading)
                .foregroundColor(Color("main1"))
                .font(.custom(fontEnum.bold.rawValue, size: 14))
                .padding(.horizontal , 10)
                .padding(.top , 10)

            ScrollView(.horizontal ,showsIndicators: false) {
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
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding()
            }
            
        }
        .frame(height: 100)
    }
   
}


struct ExtractedViewRecentlySearch : View {
    
 
    var body: some View {
        
        VStack(alignment: .leading) {

            
            Spacer()
                .frame(height: 10)
                .frame(maxWidth: .infinity)
                .background(Color("bg1"))
            
            Text("Recently restaurants Search")
                .frame(maxWidth: .infinity , alignment: .leading)
                .foregroundColor(Color("main1"))
                .font(.custom(fontEnum.bold.rawValue, size: 14))
                .padding(.horizontal , 10)
                .padding(.top , 20)

            
            
              List {
                  ForEach(0 ..< 10) {_ in
                      
                      VStack(spacing : 10) {
                          
                          HStack(spacing : 10) {
                              
                              Image("od")
                                  .resizable()
                                  .frame(width: 100 , height: 100)
                              
                              VStack(alignment : .leading , spacing : 10) {
                                  Spacer()

                                  HStack {
                                      Text("Subway, Dubai World Trad...")
                                          .foregroundColor(Color("main1"))
                                          .font(.custom(fontEnum.medium.rawValue, size:12))
                                      Spacer()
                                      Image(systemName: "heart")
                                          .foregroundColor(Color("main1"))
                                          .frame(width: 25 , height: 25)
                                  }
                                  
                                  Text("Sandwiches, Beverages, Wraps")
                                      .foregroundColor(Color("empty text field"))
                                      .font(.custom(fontEnum.regular.rawValue, size:12))
                                  
                                  HStack {
                                      Image(systemName: "star")
                                          .foregroundColor(.yellow)
                                          .frame(width: 25 , height: 25)
                                      
                                      Text("4.8")
                                          .foregroundColor(Color("main1"))
                                          .font(.custom(fontEnum.regular.rawValue, size:10))
                                      Text("(100+)")
                                          .foregroundColor(Color("empty text field"))
                                          .font(.custom(fontEnum.regular.rawValue, size:10))
                                  }
                               
                                  HStack {
                                      Image("alarm")
                                          .foregroundColor(.yellow)
                                          .frame(width: 25 , height: 25)
                                      
                                      Text("35 mins")
                                          .foregroundColor(Color("main1"))
                                          .font(.custom(fontEnum.regular.rawValue, size:10))
                                      
                                      Image("location2")
                                          .foregroundColor(.yellow)
                                          .frame(width: 25 , height: 25)
                                      
                                      Text("5.50 km")
                                          .foregroundColor(Color("empty text field"))
                                          .font(.custom(fontEnum.regular.rawValue, size:10))
                                  }
                               
                              }
                          }

                         
                      }
                      .padding(.vertical , 10)
                      .frame(height: 110)
                      
                  }
              }
              .listStyle(.plain)
              .listRowSeparator(.hidden) // Hide the separator lines
         
        }
    }
}
