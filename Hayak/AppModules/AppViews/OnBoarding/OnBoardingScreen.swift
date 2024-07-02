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
    
    var body: some View {

        ZStack(alignment : .bottom) {
            Color(UIColor(named: "bg")!).ignoresSafeArea()
            //(UIColor(named: "bg")!)
            TabView(selection : $CurrentState) {
                
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
                              
                              VStack (spacing : 5){
                                 
                                  Text(onBoardingStepsArr[index].title)
                                      .font(.custom("LamaSans-Bold", size: 18))
                                      .foregroundColor(.white)
                                      .padding(.bottom , 20)
                                  
                                  Text(onBoardingStepsArr[index].des1)
                                      .font(.custom("LamaSans-Medium", size: 13))
                                      .foregroundColor(.white)
                                      .frame(height: 16)
                                  Text(onBoardingStepsArr[index].des2)
                                      .font(.custom("LamaSans-Medium", size: 13))
                                      .foregroundColor(.white)
                                      .frame(height: 16)

                                  Text(onBoardingStepsArr[index].des3)
                                      .font(.custom("LamaSans-Medium", size: 13))
                                      .foregroundColor(.white)
                                      .frame(height: 16)
                                      .padding(.bottom , 50)
                                  
                                  
                                  Button(action: {
                                      
                                  }, label: {
                                      Text("Get Started")
                                          .frame(height: 50) // Set the height here
                                          .frame(maxWidth: .infinity)
                                          .font(.custom("LamaSans-Medium", size: 14))
                                          .foregroundColor(Color("main")).background(Color("bg"))
                                          .cornerRadius(20)
                                  })
                                  
                                  Spacer()

                                  Image("slide")
                                      .frame(width: 100, height: 20)

                                  
                              }
                              .padding(16)
                              
                          }
                          .padding(.horizontal , 1)
                          .frame(height: 300)
                      }
                      .tag(index)
                  }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

        }

    }
}

#Preview {
    OnBoardingScreen()
}
