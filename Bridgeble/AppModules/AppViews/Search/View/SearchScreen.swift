//
//  SearchScreen.swift
//  Hayak
//
//  Created by Mohamed Ragab on 22/08/2024.
//

import SwiftUI

struct RoundedCorners: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}



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
                
                
                //                Spacer()
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
    var id : Int?
    var imageName: String?
    var title: String?
}

struct ExtractedViewShowPopularSearch : View {
    
    let items = [
        ModelPopularSearch(id:0,imageName: "star.fill", title: "Star"),
        ModelPopularSearch(id:1,imageName: "heart.fill", title: "Heart"),
        ModelPopularSearch(id:2,imageName: "moon.fill", title: "Moon"),
        ModelPopularSearch(id:3,imageName: "sun.max.fill", title: "Sun"),
        ModelPopularSearch(id:4,imageName: "cloud.fill", title: "Cloud"),
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
                        HStack (spacing : 8){
                            Image(systemName: item.imageName ?? "")
                                .resizable()
                                .foregroundColor(Color("main1"))
                                .frame(width: 20, height: 20)
                            
                            Text(item.title ?? "")
                                .foregroundColor(Color("main1"))
                                .font(.caption)
                                .padding(.top, 4)
                            Spacer()
                        }
                        .padding(.horizontal , 10)
                        .frame(height: 40)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .overlay(
                            RoundedCorners(radius: 20, corners: .allCorners)
                                .stroke(Color("main1"), lineWidth: 1) // Border with custom color and width
                        )
                    }
                }
                .padding()
                
            }
            
        }
        .frame(height: 100)
    }
    
}


struct ExtractedViewRecentlySearch : View {
    
    @State var love : String = "heart"
    
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
                ForEach(0 ..< 10) { item in
                    
                    if item % 2 == 0 {
                        ViewResturantCell1
                    } else  {
                        ViewResturantCell2()
                        
                    }
                    
                }
            }
            .listStyle(.plain)
            .listRowSeparator(.hidden) // Hide the separator lines
            
        }
    }
    
    
    
    
    
    
    private var ViewResturantCell1 : some View {
        
        
        VStack(spacing : 0) {
            
            HStack(spacing : 10) {
                
                Image("od")
                    .resizable()
                    .frame(width: 100 , height: 100)
                
                VStack(alignment : .leading , spacing : 5) {
                    Spacer()
                    
                    HStack {
                        Text("Subway, Dubai World Trad...")
                            .foregroundColor(Color("main1"))
                            .font(.custom(fontEnum.medium.rawValue, size:12))
                        Spacer()
                        Image(systemName: love)
                            .foregroundColor(love == "heart" ?  Color("main1") :  .red )
                            .frame(width: 30 , height: 25)
                            .onTapGesture {
                                love = "heart.fill"
                            }
                    }
                    
                    Text("Sandwiches, Beverages, Wraps")
                        .foregroundColor(Color("empty text field"))
                        .font(.custom(fontEnum.regular.rawValue, size:12))
                    
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(Color("yellow"))
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
        .frame(height: 120)
        
    }
    
    
//    private var ViewResturantCell2 : some View {
//        
//        @State var clickLove : String = "unlove"
//        
//        return ZStack {
//            
//            VStack(spacing: 0) {  // Set spacing to 0 to remove space between Image and VStack
//                
//                ZStack {
//                    Image("re")
//                        .resizable()
//                        .frame(height: 150)
//                        .scaledToFill()
//                    //                    .frame(maxWidth: .infinity)
//                        .clipped()
//                    
//                    
//                    VStack  {
//                        HStack {
//                            
//                            HStack (spacing: 0){
//                                Image("alarm")
//                                    .foregroundColor(.yellow)
//                                    .frame(width: 25 , height: 25)
//                                Text("35 mins")
//                                    .foregroundColor(Color("main1"))
//                                    .font(.custom(fontEnum.regular.rawValue, size:10))
//                            }
//                            .padding(.horizontal , 5)
//                            .background(.white)
//                            .cornerRadius(10)
//                            .overlay(
//                                RoundedCorners(radius: 9, corners: .allCorners)
//                                    .stroke(Color("black25%"), lineWidth: 1) // Border with custom color and width
//                            )
//                            
//                            HStack (spacing: 0){
//                                Image("location2")
//                                    .foregroundColor(.yellow)
//                                    .frame(width: 25 , height: 25)
//                                Text("50.50 KM")
//                                    .foregroundColor(Color("main1"))
//                                    .font(.custom(fontEnum.regular.rawValue, size:10))
//                            }
//                            .padding(.horizontal , 5)
//                            .background(.white)
//                            .cornerRadius(10)
//                            .overlay(
//                                RoundedCorners(radius: 9, corners: .allCorners)
//                                    .stroke(Color("black25%"), lineWidth: 1) // Border with custom color and width
//                            )
//                            
//                            Spacer()
//                            
//                            Image(clickLove)
//                                .frame(width: 30 , height: 30)
//                                .onTapGesture {
//                                    clickLove = "love"
//                                }
//                            
//                        }
//                        Spacer()
//                    }
//                    .padding(.horizontal , 10)
//                    .padding(.top, 10) // Add padding from the top
//                    
//                }
//                .frame(height: 150)
//                
//                
//                VStack (alignment : .leading){
//                    Text("Operation Falafel, Dubai Festiva")
//                        .foregroundColor(Color("main1"))
//                        .font(.custom(fontEnum.medium.rawValue, size:12))
//                    
//                    HStack {
//                        Text("Arabic, Middle eastern, Sandwiches")
//                            .foregroundColor(Color("empty text field"))
//                            .font(.custom(fontEnum.regular.rawValue, size:10))
//                        
//                        Spacer()
//                        
//                        Image(systemName: "star.fill")
//                            .foregroundColor(Color("yellow"))
//                            .frame(width: 25 , height: 25)
//                        
//                        Text("4.8")
//                            .foregroundColor(.black)
//                            .font(.custom(fontEnum.regular.rawValue, size:12))
//                        Text("(100+)")
//                            .foregroundColor(.black50)
//                            .font(.custom(fontEnum.medium.rawValue, size:12))
//                    }
//                }
//                .padding(10)
//                .frame(height: 70)
//                .overlay(
//                    RoundedCorners(radius: 10, corners: [.bottomLeft, .bottomRight])
//                        .stroke(Color("main2"), lineWidth: 1) // Border with custom color and width
//                )
//                
//                
//            }
//            .padding(.vertical , 10)
//            .frame(height: 220)
//            
//            
//            VStack {
//                Spacer()
//                HStack {
//                    Spacer()
//                    Image("test")
//                        .resizable()
//                        .scaledToFill()
//                        .cornerRadius(20)
//                        .padding(.leading, 10) // Add padding from the left
//                        .frame(width: 100 , height: 100)
//                }
//                Spacer()
//                    .frame(height: 40)
//
//            }
//            .padding()
//    
//        }
//        
//    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

struct ViewResturantCell2 : View {
    
    @State var clickLove : String = "unlove"
    
    var body: some View {

        
         ZStack {
            
            VStack(spacing: 0) {  // Set spacing to 0 to remove space between Image and VStack
                
                ZStack {
                    Image("re")
                        .resizable()
                        .frame(height: 150)
                        .scaledToFill()
                    //                    .frame(maxWidth: .infinity)
                        .clipped()
                    
                    VStack  {
                        HStack {
                            
                            HStack (spacing: 0){
                                Image("alarm")
                                    .foregroundColor(.yellow)
                                    .frame(width: 25 , height: 25)
                                Text("35 mins")
                                    .foregroundColor(Color("main1"))
                                    .font(.custom(fontEnum.regular.rawValue, size:10))
                            }
                            .padding(.horizontal , 5)
                            .background(.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedCorners(radius: 9, corners: .allCorners)
                                    .stroke(Color("black25%"), lineWidth: 1) // Border with custom color and width
                            )
                            
                            HStack (spacing: 0){
                                Image("location2")
                                    .foregroundColor(.yellow)
                                    .frame(width: 25 , height: 25)
                                Text("50.50 KM")
                                    .foregroundColor(Color("main1"))
                                    .font(.custom(fontEnum.regular.rawValue, size:10))
                            }
                            .padding(.horizontal , 5)
                            .background(.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedCorners(radius: 9, corners: .allCorners)
                                    .stroke(Color("black25%"), lineWidth: 1) // Border with custom color and width
                            )
                            
                            Spacer()
                            
                            Image(clickLove)
                                .frame(width: 30 , height: 30)
                                .onTapGesture {
                                    clickLove = "love"
                                }
                            
                        }
                        Spacer()
                    }
                    .padding(.horizontal , 10)
                    .padding(.top, 10) // Add padding from the top
                    
                }
                .frame(height: 150)
                
                VStack (alignment : .leading){
                    Text("Operation Falafel, Dubai Festiva")
                        .foregroundColor(Color("main1"))
                        .font(.custom(fontEnum.medium.rawValue, size:12))
                    
                    HStack {
                        Text("Arabic, Middle eastern, Sandwiches")
                            .foregroundColor(Color("empty text field"))
                            .font(.custom(fontEnum.regular.rawValue, size:10))
                        
                        Spacer()
                        
                        Image(systemName: "star.fill")
                            .foregroundColor(Color("yellow"))
                            .frame(width: 25 , height: 25)
                        
                        Text("4.8")
                            .foregroundColor(.black)
                            .font(.custom(fontEnum.regular.rawValue, size:12))
                        Text("(100+)")
                            .foregroundColor(.black50)
                            .font(.custom(fontEnum.medium.rawValue, size:12))
                    }
                }
                .padding(10)
                .frame(height: 70)
                .overlay(
                    RoundedCorners(radius: 10, corners: [.bottomLeft, .bottomRight])
                        .stroke(Color("main2"), lineWidth: 1) // Border with custom color and width
                )
            }
            .padding(.vertical , 10)
            .frame(height: 220)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Image("test")
                        .resizable()
                        .scaledToFill()
                        .cornerRadius(20)
                        .padding(.leading, 10) // Add padding from the left
                        .frame(width: 100 , height: 100)
                }
                Spacer()
                    .frame(height: 40)

            }
            .padding()
    
        }
    }
}
