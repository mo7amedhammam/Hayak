//
//  WellcomeLoginScreen.swift
//  Hayak
//
//  Created by Mohamed Ragab on 03/07/2024.
//

import SwiftUI

struct WellcomeLoginScreen: View {
    var body: some View {


        ZStack(alignment : .bottom) {
            Color(UIColor(named: "bg")!).ignoresSafeArea()
                .navigationBarBackButtonHidden(true)

                      VStack {
                        
                          Image("wellcome1")
                              .frame(width: 300 , height: 170)
                          Image("wellcome2")
                              .frame(width: 260 , height: 200)

                          Spacer()
                          ZStack (alignment : .center)  {
                              Color.clear.ignoresSafeArea()
                              Image("imgbg")
                                  .resizable()
                                  .ignoresSafeArea()
                              
                              VStack (spacing : 20){
                                 
                                  Text("Welcome to Hayak")
                                      .font(.custom("LamaSans-Bold", size: 18))
                                      .foregroundColor(.white)
                                      .padding(.top , 20)
                                  
                                  VStack {
                                      Text("Restaurants and search by cuisine, price,")
                                          .font(.custom("LamaSans-Medium", size: 13))
                                          .foregroundColor(.white)
                                          .frame(height: 16)

                                      Text("location, and more.")
                                          .font(.custom("LamaSans-Medium", size: 13))
                                          .foregroundColor(.white)
                                          .frame(height: 16)
                                  }

                                  Button(action: {
                                      // get started login

                                      
                                  }, label: {
                                      Text("Sign in")
                                          .frame(height: 50) // Set the height here
                                          .frame(maxWidth: .infinity)
                                          .font(.custom("LamaSans-Medium", size: 14))
                                          .foregroundColor(Color("main")).background(Color("bg"))
                                          .cornerRadius(10)
                                  })
                                  
                                  Button(action: {
                                      // get started login

                                      
                                  }, label: {
                                      Text("Sign Up")
                                          .frame(height: 50) // Set the height here
                                          .frame(maxWidth: .infinity)
                                          .font(.custom("LamaSans-Medium", size: 14))
                                          .foregroundColor(Color("main")).background(Color("bg"))
                                          .cornerRadius(10)
                                  })
                                  Button(action: {
                                      // get started login

                                      
                                  }, label: {
                                      Text("Go To Home")
                                          .frame(height: 50) // Set the height here
                                          .frame(maxWidth: .infinity)
                                          .font(.custom("LamaSans-Medium", size: 14))
                                          .foregroundColor(Color("main")).background(Color("bg"))
                                          .cornerRadius(10)
                                  })
                              
                              }
                              .padding(16)
                              
                          }
                          .frame(height: 330)
                      }
           

        }
    }
}

#Preview {
    WellcomeLoginScreen()
}
