//
//  OnBoardingScreen.swift
//  Hayak
//
//  Created by Mohamed Ragab on 02/07/2024.
//

import SwiftUI

struct onBoardingSteps {
    let image : String
    let title : String
    let des1 : String
    let des2 : String
    let des3 : String
}


private let onBoardingStepsArr = [

    onBoardingSteps(image: "1", title: "Welcome to Food Delivery", des1: "Reference site about Lorem", des2: "Ipsum, giving information origins", des3: "as well as a random") ,
    onBoardingSteps(image: "2", title: "Home Delivery", des1: "Reference site about Lorem", des2: "Ipsum, giving information origins", des3: "as well as a random") ,
    onBoardingSteps(image: "3", title: "Online Order System", des1: "Reference site about Lorem", des2: "Ipsum, giving information origins", des3: "as well as a random") ,

]


struct OnBoardingScreen: View {
       
    @State private var CurrentState = 0
    @State private var isActive = false

    init() {
        UIScrollView.appearance().bounces = false
    }
    
    
    var body: some View {
        
        ZStack(alignment : .bottom) {
            Color(UIColor(named: "bg")!).ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
            
        TabView(selection : $CurrentState) {
           
                //(UIColor(named: "bg")!)
                ForEach(0..<onBoardingStepsArr.count) { index  in
                    
                    VStack {
                        Spacer()
                        Spacer()
                        Image(onBoardingStepsArr[index].image)
                            .frame(width: 340 , height: 290)
                        
                        Spacer()
                        ZStack (alignment : .center)  {
                            Color.clear.ignoresSafeArea()
                            Image("imgbg")
                                .resizable()
                                .ignoresSafeArea()
                            
                            VStack (spacing : 10){
                                
                                Text(onBoardingStepsArr[index].title)
                                    .font(.custom("LamaSans-Bold", size: 18))
                                    .foregroundColor(.white)
                                    .padding(.top , 20)
                                
                                VStack {
                                    Text(onBoardingStepsArr[index].des1)
                                        .font(.custom(fontEnum.medium.rawValue, size: 13))
                                        .foregroundColor(.white)
                                        .frame(height: 16)
                                    Text(onBoardingStepsArr[index].des2)
                                        .font(.custom(fontEnum.medium.rawValue, size: 13))
                                        .foregroundColor(.white)
                                        .frame(height: 16)
                                    
                                    Text(onBoardingStepsArr[index].des3)
                                        .font(.custom(fontEnum.medium.rawValue, size: 13))
                                        .foregroundColor(.white)
                                        .frame(height: 16)
                                }
                                .padding(.top , 20)
                                
                                
                                Button(action: {
                                    // get started login
                                    self.isActive = true
                                }, label: {
                                    Text("Get Started")
                                        .frame(height: 50) // Set the height here
                                        .frame(maxWidth: .infinity)
                                        .font(.custom(fontEnum.medium.rawValue, size: 14))
                                        .foregroundColor(Color("main")).background(Color("bg"))
                                        .cornerRadius(20)
                                        .padding(.top , 10)
                                })
                                
                                NavigationLink(
                                    destination: WellcomeLoginScreen().navigationBarBackButtonHidden(true),
                                    isActive: $isActive,
                                    label: {
                                        EmptyView()
                                    }
                                )
                                
                    
                                HStack {
                                    ForEach(0..<onBoardingStepsArr.count) { it in
                                        if it == CurrentState {
                                            Circle()
                                                .frame(width: 12, height: 12)
                                                .foregroundColor(Color("main3"))
                                        } else {
                                            Circle()
                                                .frame(width: 12, height: 12)
                                                .foregroundColor(Color("color-F1F2F6"))
                                        }
                                    }
                                }

                                Spacer()

                            }
                            .padding(16)
                        }
                        .padding(.horizontal , 1)
                        .frame(height: 200)
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .ignoresSafeArea()

    }
}

#Preview {
    OnBoardingScreen()
}
