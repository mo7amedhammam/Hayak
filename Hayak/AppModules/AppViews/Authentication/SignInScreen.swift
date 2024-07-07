//
//  SignInScreen.swift
//  Hayak
//
//  Created by Mohamed Ragab on 06/07/2024.
//

import SwiftUI

struct SignInScreen: View {
    var body: some View {
        
        ZStack {
            Color(UIColor(named: "bg1")!).ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
            
            VStack {
                CustomHeaderView(title: "Sign in", onBack: {
                    // Handle back button action
                    print("Back button pressed")
                })
                ExtractedViewSignIn()
            }
            
        }
    }
}



#Preview {
    SignInScreen()
}

struct ExtractedViewSignIn: View {
    var body: some View {
        ScrollView {
            VStack (spacing : 0){
                
                VStack(alignment : .leading , spacing : 10) {
                    Image("LOGO")
                        .resizable()
                        .frame(width: 170 , height: 80)
                    Text("Welcome Back!")
                        .font(.custom("LamaSans-Bold", size: 18))
                        .foregroundColor(Color("main1"))
                    Text("Sign in to continue")
                        .font(.custom("LamaSans-Medium", size: 13))
                        .foregroundColor(Color("main1"))
                }
                .frame(maxWidth: .infinity , minHeight: 200 , alignment: .leading)
                .padding(.horizontal , 20)

                
                VStack {
                    
                    
                    
                    
                }
                .frame(maxWidth: .infinity , minHeight: 400)
                .background(.white)
                .cornerRadius(20)
                .padding(20)
                
                HStack (alignment: .center ){
                    Text("Already have not an account?")
                        .font(.custom("LamaSans-Medium", size: 14))
                        .foregroundColor(Color("main1"))
                    Button(action: {
                        // sign up
                    }, label: {
                        Text("Sign up!")
                            .frame(height: 50) // Set the height here
                            .font(.custom("LamaSans-Medium", size: 14))
                            .foregroundColor(Color("main2")).background(Color("bg"))
                    })
                    
                } .frame(height: 100)
            }
        }
    }
}


struct CustomHeaderView: View {
    var title: String
    var onBack: () -> Void
    
    var body: some View {
        ZStack {
            // Background color or any other customization
            Color.white
                .edgesIgnoringSafeArea(.top)
                .frame(height: 70)
            
            // Content of the header
            HStack {
                // Back button
                Button(action: {
                    onBack()
                }) {
                    Image(systemName: "arrow.left")
                        .font(.custom("LamaSans-Bold", size: 14))
                        .foregroundColor(Color("main1"))
                        .frame(width: 44) // The same width as the back button
                }

                Spacer()
                
                // Title
                Text(title)
                    .font(.headline)
                    .foregroundColor(Color("main1"))
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
                
                // This spacer is for balancing the HStack
                Spacer()
                    .frame(width: 44) // The same width as the back button
            }
            .padding([.leading, .trailing])
        }
    }
}
