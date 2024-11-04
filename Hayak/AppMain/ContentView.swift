//
//  ContentView.swift
//  Hayak
//
//  Created by wecancity on 09/06/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isActive = false
    @State private var GoToTabViewWithCenterBtn = false
    var body: some View {
        
        NavigationView {
            ZStack {
                Color.white.ignoresSafeArea()
                
                Image("splash")
                    .resizable()
                    .ignoresSafeArea()
                
                
                NavigationLink(
                    destination: OnBoardingScreen(),
                    isActive: $isActive,
                    label: {
                        EmptyView()
                    }
                )
                
                
//                NavigationLink(
//                    destination: TabViewWithCenterBtn().navigationBarBackButtonHidden(true),
//                    isActive: $GoToTabViewWithCenterBtn ,
//                    label: {
//                        EmptyView()
//                    }
//                )
                
            }
            
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    if Helper.shared.CheckIfLoggedIn() {
//                        GoToTabViewWithCenterBtn = true
                        Helper.shared.changeRoot(toView: TabViewWithCenterBtn())
                    } else {
                        Helper.shared.changeRoot(toView: OnBoardingScreen())
//                        isActive = true
                    }
                }
            }
            
        }
        .hideNavigationBar()
        
    }
}

#Preview {
    ContentView()
    
}
