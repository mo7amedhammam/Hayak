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
            Color.white.ignoresSafeArea()
            
            Image("splash")
                .resizable()
                .ignoresSafeArea()
        }
        
    }
}

#Preview {
    ContentView()

}
