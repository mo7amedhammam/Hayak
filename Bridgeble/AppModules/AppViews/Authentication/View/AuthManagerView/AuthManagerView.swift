//
//  AuthManagerView.swift
//  Bridgeble
//
//  Created by mohamed hammam on 12/04/2026.
//

import SwiftUI

struct AuthManagerView: View {
    var hasnavbar:Bool? = true
    @State private var selectedRoute: Route?

    private enum Route: Hashable {
        case signUp
        case home
    }
    
    var body: some View {
        ZStack {
            Color(.bg1).ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
        
            VStack {
                if hasnavbar ?? true{
                    CustomHeaderView(title: "Sign up_" , onBack: {
                        // Handle back button action
                        print("Back button pressed")
                    }, onOtherBtn: {
                        
                    }, OtherBtnIsfound: false , imageonOtherBtn: "", coloronOtherBtn: "")
                }
                
                ScrollView(){
                VStack{
                    Image(.bridgebleBlue)
//                        .padding()
                        .padding(.vertical,30)
                    
                    Text("Log in or create an account_".localized())
                        .font(.Bold(size: 18))
                        .foregroundColor(.mainBlue)
                    
                    Text("Receive rewards and save your details for a faster checkout experience._".localized())
                        .font(.Medium(size: 13))
                        .foregroundColor(.activeText)
                        .multilineTextAlignment(.center)
                        .padding()
                        .padding(.horizontal,)
                    
                    //                    social buttons section
                    VStack(spacing: 16) {
                        
                        SocialAuthButton(
                            title: "Continue with Apple_",
                            icon: Image(.appleIcon),
                            action: {
                                print("Apple tapped")
                            }
                        )
                        
                        SocialAuthButton(
                            title: "Continue with Google_",
                            icon: Image(.googleIcon),
                            action: {
                                print("Google tapped")
                            }
                        )
                        
                        SocialAuthButton(
                            title: "Continue with Facebook_",
                            icon: Image(.facebookIcon),
                            action: {
                                print("Facebook tapped")
                            }
                        )
                        
                        SocialAuthButton(
                            title: "Continue with email_",
                            icon: Image(.emailIcon),
                            action: {
                                selectedRoute = .signUp
                            }
                        )
                    }
                    .padding(.horizontal)
                    .padding(.bottom,60)
                    
                }
                .padding(.vertical,50)
                .background{Color.white}
                .cornerRadius(10, corners: .allCorners)
                
                Spacer()
                
            }
                .padding(.horizontal)
            
            }
            .background(routeLinks)
            .hideNavigationBar()
            .localizeView()
            //            .showHud(isShowing: $viewModel.isLoading, text: "Signing Up...")
            
        }

    }
    
    @ViewBuilder
    private var routeLinks: some View {
        AppRouteLink(route: Route.signUp, selection: $selectedRoute) {
            SignUpScreen().navigationBarBackButtonHidden(true)
        }

        AppRouteLink(route: Route.home, selection: $selectedRoute) {
            TabViewWithCenterBtn().navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    AuthManagerView()
}
