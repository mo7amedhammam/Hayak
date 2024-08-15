//
//  PicUpView.swift
//  Hayak
//
//  Created by Mohamed Ragab on 22/07/2024.
//

import SwiftUI

struct PicUpView: View {
    @Environment(\.presentationMode) var presentationMode
    func createshoppingimg() -> some View {
        return Image(.shoppingicon)
            .resizable()
            .padding(6)
            .background{Color(.main).clipShape(Circle())}
            .frame(width: 33, height: 33)
    }
    var body: some View {
        ZStack {
            Color(.white).ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
            
            VStack {
                
                CustomPickupHeaderView(title: "Saudi Arabia", subtitle: "Al Riadh city", onBack: {}, btnimg2:createshoppingimg(), onbtnimg2: {}, btnimg3: Image(.favoriteicon), onbtnimg3: {}, btnimg4: Image("carbon_search"), onbtnimg4: {})

                PickUpContentView()
            Spacer()
            }
        }
    }
}

#Preview {
    PicUpView()
}


struct PickUpContentView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color(.bg1).ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
            
            
            
            
            
        }
    }
}
