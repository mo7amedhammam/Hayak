//
//  TabViewWithCenterBtn.swift
//  Hayak
//
//  Created by Mohamed Ragab on 22/07/2024.
//

import SwiftUI

enum OrderTypes:Int{
    case PickUp = 1
    case Dinning = 2
}

struct TabViewWithCenterBtn: View {
    @State private var selectedIndex = 0
    
    var body: some View {
            ZStack {
                TabView(selection: $selectedIndex) {
                    HomeView()
                        .tabItem {
                            Image("home")
                            Text("Home")
                        }
                        .tag(0)
                    
                    NavigationView{
                        PicUpView()
                            .environmentObject(MainPickUpVM.shared)
                    }
                    .tabItem {
                        Image("picup")
                        Text("Pick Up")
                    }
                    .tag(1)
                    
                    //                NavigationView{
                    PointsScreen()
                    //                }
                        .tabItem {
                            
                        }
                        .tag(2)
                    
                    NavigationView{
                        DiningView()
                    }
                    .tabItem {
                        Image("dining")
                        Text("Dining")
                    }
                    .tag(3)
                    
                    ProfileView()
                        .padding(.bottom)
                        .tabItem {
                            Image("profile")
                            Text("Profile")
                        }
                        .tag(4)
                }
                
                // Custom tab bar with center button
                VStack {
                    Spacer()
                    ZStack {
                        HStack {
                            Button(action: {
                                selectedIndex = 0
                            }) {
                                VStack (spacing : 8){
                                    Image("home")
                                    Text("Home")
                                        .font(.custom("LamaSans-Bold", size: 10))
                                        .foregroundColor(Color("main2"))
                                }
                                .padding(.vertical)
                            }
                            .frame(maxWidth: .infinity)
                            
                            Spacer()
                            
                            Button(action: {
                                selectedIndex = 1
                                Helper.shared.selectedordertype = .PickUp
                            }) {
                                VStack (spacing : 8){
                                    Image("picup")
                                    Text("Pic Up")
                                        .font(.custom("LamaSans-Bold", size: 10))
                                        .foregroundColor(Color("main2"))
                                }
                                .padding(.vertical)
                            }
                            .frame(maxWidth: .infinity)
                            
                            Spacer()
                            
                            
                            Button(action: {
                                //                            selectedIndex = 2
                            }) {
                                VStack {
                                    //                                    Image(systemName: "person")
                                    //                                    Text("Profile")
                                }
                                .padding(.vertical)
                            }
                            .frame(maxWidth: .infinity)
                            
                            Spacer()
                            
                            Button(action: {
                                selectedIndex = 3
                                Helper.shared.selectedordertype = .Dinning
                            }) {
                                VStack (spacing : 8){
                                    Image("dining")
                                    Text("Dining")
                                        .font(.custom("LamaSans-Bold", size: 10))
                                        .foregroundColor(Color("main2"))
                                }
                                .padding(.vertical)
                            }
                            .frame(maxWidth: .infinity)
                            
                            Spacer()
                            
                            Button(action: {
                                selectedIndex = 4
                            }) {
                                VStack (spacing : 8){
                                    Image("profile")
                                    Text("Profile")
                                        .font(.custom("LamaSans-Bold", size: 10))
                                        .foregroundColor(Color("main2"))
                                }
                                .padding(.vertical)
                            }
                            .frame(maxWidth: .infinity)
                            
                            
                        }
                        .frame(height: 100)
                        .background(
                            TabBarShape(curveDepth: 60 , curveWidth: 50)
                                .fill(Color.white)
                                .shadow(radius: 5)
                        )
                        
                        // Center button
                        Button(action: {
                            // Center button action
                            selectedIndex = 2
                        }) {
                            Image("center")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .shadow(radius: 2)
                        }
                        .offset(y: -50)
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
            }
            .hideNavigationBar()
    }
}



#Preview {
    TabViewWithCenterBtn()
}

struct TabBarShape: Shape {
    var curveDepth: CGFloat = 90
    var curveWidth: CGFloat = 60
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.width
        let height = rect.height
        let centerWidth = width / 2
        let cornerRadius: CGFloat = 0 // Adjust this value for the corner radius
        
        path.move(to: CGPoint(x: 0, y: cornerRadius))
        path.addQuadCurve(
            to: CGPoint(x: cornerRadius, y: 0),
            control: CGPoint(x: 0, y: 0)
        )
        path.addLine(to: CGPoint(x: centerWidth - curveWidth, y: 0))
        path.addCurve(
            to: CGPoint(x: centerWidth + curveWidth, y: 0),
            control1: CGPoint(x: centerWidth - curveWidth / 2, y: curveDepth),
            control2: CGPoint(x: centerWidth + curveWidth / 2, y: curveDepth)
        )
        path.addLine(to: CGPoint(x: width - cornerRadius, y: 0))
        path.addQuadCurve(
            to: CGPoint(x: width, y: cornerRadius),
            control: CGPoint(x: width, y: 0)
        )
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.closeSubpath()
        
        return path
    }
}
