//
//  WellcomeLoginScreen.swift
//  Hayak
//
//  Created by Mohamed Ragab on 03/07/2024.
//

import SwiftUI

struct WellcomeLoginScreen: View {
    @State private var selectedRoute: Route?

    private enum Route: Hashable {
        case signIn
        case signUp
        case home
    }

    var body: some View {
        ZStack(alignment : .bottom) {
            Color(.bg).ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
            
            VStack {
                
                Image("wellcome1")
                    .frame(width: 300 , height: 170)
                Image("wellcome2")
                    .frame(width: 260 , height: 200)
                
                Spacer()
                ZStack (alignment : .center)  {
                    
                    Color.mainBlue
                        .cornerRadius(33, corners: [.topLeft,.topRight])
                        .ignoresSafeArea()
                    
                    VStack (spacing : 20){
                        
                        Text("Welcome to Bridgeble_".localized())
                            .font(.Bold(size: 18))
                            .foregroundColor(.white)
                            .padding(.top , 20)
                        
                        VStack {
                            Text("Restaurants and search by cuisine, price,_".localized())
                                .font(.Medium(size: 13))
                                .foregroundColor(.white)
                                .frame(height: 16)
                            
                            Text("location, and more._".localized())
                                .font(.Medium(size: 13))
                                .foregroundColor(.white)
                                .frame(height: 16)
                        }
                        
                        ReusableActionButton(title: "Sign_in_") {
                            selectedRoute = .signIn
                        }

                        ReusableActionButton(title: "Sign Up_") {
                            selectedRoute = .signUp
                        }

                        ReusableActionButton(
                            title: "Go To Home_",
                            foregroundColor: .white,
                            backgroundColor: .main2
                        ) {
                            selectedRoute = .home
                        }
                        
                    }
                    .padding(16)
                    
                }
                .frame(height: 330)
            }
            
        }
        .background(routeLinks)
        .hideNavigationBar()
        .localizeView()
    }

    @ViewBuilder
    private var routeLinks: some View {
        AppRouteLink(route: Route.signIn, selection: $selectedRoute) {
            SignInScreen().navigationBarBackButtonHidden(true)
        }

        AppRouteLink(route: Route.signUp, selection: $selectedRoute) {
            SignUpScreen().navigationBarBackButtonHidden(true)
        }

        AppRouteLink(route: Route.home, selection: $selectedRoute) {
            TabViewWithCenterBtn().navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    WellcomeLoginScreen()
}
