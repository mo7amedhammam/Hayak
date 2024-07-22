//
//  ProfileView.swift
//  Hayak
//
//  Created by Mohamed Ragab on 22/07/2024.
//

import SwiftUI


struct ModelProfile : Identifiable , Hashable {
    var id   : Int
    var name : String
    var Currentimg  : String
    var Placeholderimg  : String
    
}

class ViewModelProfile : ObservableObject {
    
    @Published var ArrProfile : [ModelProfile] = []
    
    init() {
        LoadData ()
    }
    
    func LoadData () {
        ArrProfile.append(ModelProfile(id: 1, name: "Notifications", Currentimg : "1" , Placeholderimg: "01"))
        ArrProfile.append(ModelProfile(id: 2, name: "My orders", Currentimg : "2" , Placeholderimg: "02"))
        ArrProfile.append(ModelProfile(id: 3, name: "Addresses", Currentimg : "3" , Placeholderimg: "03"))
        ArrProfile.append(ModelProfile(id: 4, name: "Payment", Currentimg : "4" , Placeholderimg: "04"))
        ArrProfile.append(ModelProfile(id: 5, name: "Wishlist", Currentimg : "5" , Placeholderimg: "05"))
        ArrProfile.append(ModelProfile(id: 6, name: "Settings", Currentimg : "6" , Placeholderimg: "06"))
        ArrProfile.append(ModelProfile(id: 7, name: "Languages", Currentimg : "7" , Placeholderimg: "07"))
        ArrProfile.append(ModelProfile(id: 8, name: "Logout", Currentimg : "8" , Placeholderimg: "08"))
    }
}

struct ProfileView: View {
    
    @StateObject var ViewModel : ViewModelProfile = ViewModelProfile()
    
    var body: some View {
        
        ZStack {
            Color(UIColor(named: "bg1")!).ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
            
            VStack {
                
                List {
                    ForEach(ViewModel.ArrProfile , id: \.self) { item in
                        
                        
                        HStack {
                            Text(item.name)
                                .font(.title)
                            
                        }
                    }
                }
                
                
                
                
            }
        }
    }
}

#Preview {
    ProfileView()
}
