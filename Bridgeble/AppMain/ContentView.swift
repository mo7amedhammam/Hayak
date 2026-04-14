//
//  ContentView.swift
//  Hayak
//
//  Created by wecancity on 09/06/2024.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
            ZStack {
                Color.mainBlue.ignoresSafeArea()
                
                Image(.bridgeble)

                
            }
            
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                    if Helper.shared.CheckIfLoggedIn() {
////                        GoToTabViewWithCenterBtn = true
//                        Helper.shared.changeRoot(toView: TabViewWithCenterBtn())
//                    } else {
                    
//                        if !Helper.shared.checkOnBoard(){
//                            Helper.shared.changeRoot(toView: TabViewWithCenterBtn())
//                        }else{
                            Helper.shared.changeRoot(toView: OnBoardingScreen())
                            //                        isActive = true
//                        }
//                    }
                }
//            }
            
        }
        .hideNavigationBar()
        
    }
}

#Preview {
    ContentView()
    
}
