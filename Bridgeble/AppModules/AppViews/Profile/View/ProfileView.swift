//
//  ProfileView.swift
//  Hayak
//
//  Created by Mohamed Ragab on 22/07/2024.
//

import SwiftUI


//struct ModelProfile : Identifiable , Hashable {
//    var id   : Int
//    var name : String
//    var Currentimg  : String
//    var Placeholderimg  : String
//
//}
//
//class ViewModelProfile : ObservableObject {
//
//    @Published var ArrProfile : [ModelProfile] = []
//
//    init() {
//        LoadData ()
//    }
//
//    func LoadData () {
//        ArrProfile.append(ModelProfile(id: 1, name: "Notifications", Currentimg : "1" , Placeholderimg: "01"))
//        ArrProfile.append(ModelProfile(id: 2, name: "My orders", Currentimg : "2" , Placeholderimg: "02"))
//        ArrProfile.append(ModelProfile(id: 3, name: "Addresses", Currentimg : "3" , Placeholderimg: "03"))
//        ArrProfile.append(ModelProfile(id: 4, name: "Payment", Currentimg : "4" , Placeholderimg: "04"))
//        ArrProfile.append(ModelProfile(id: 5, name: "Wishlist", Currentimg : "5" , Placeholderimg: "05"))
//        ArrProfile.append(ModelProfile(id: 6, name: "Settings", Currentimg : "6" , Placeholderimg: "06"))
//        ArrProfile.append(ModelProfile(id: 7, name: "Languages", Currentimg : "7" , Placeholderimg: "07"))
//        ArrProfile.append(ModelProfile(id: 8, name: "Logout", Currentimg : "8" , Placeholderimg: "08"))
//    }
//}

struct ProfileView: View {
    
    //    @StateObject var ViewModel : ViewModelProfile = ViewModelProfile()
    @State var isUserLogin : Bool = Helper.shared.CheckIfLoggedIn()
    
    @State var destination = AnyView(EmptyView())
    @State var ispush = false
    var body: some View {
        
        ZStack {
            VStack {
                VStack{
                    Spacer()
                    HStack (alignment: .bottom ) {
                        Image("menu")
                            .resizable()
                            .frame(width: 20 , height: 15)
                        Spacer()

                        Text("Profile".localized())
                            .font(.custom("LamaSans-Bold", size: 14))
                            .foregroundColor( Color("main1"))
                        Spacer()
                        Spacer()
                            .frame(width: 40)

                    }
                    .frame(height: 60)
                    .padding(.horizontal , 15)                    
                }
                .frame(height: 100)
                .frame(maxWidth: .infinity)
                .background(.white)
                //..................
                
                ScrollView {
                    VStack (spacing : 20) {
                        VStack{
                            if !isUserLogin {
                                ViewCustomUserIsSigned(signInAction: {
                                    Helper.shared.changeRoot(toView: SignInScreen(hasnavbar: false))
                                }, signUpAction: {
                                    Helper.shared.changeRoot(toView: SignUpScreen(hasnavbar: false))

                                })
                            } else {
                                ViewCustomUserNotSigned(Name : "Mohamed Ragab" , Balance : "Balance: $1200.00")
                            }
                        }
                        .frame(height: 220)
                        .background(.white).cornerRadius(30)
                        .padding(.horizontal , 20)
                        //..................
                        VStack {
                            ViewCustom(title: "Notifications" , img1: isUserLogin ? "011" : "11" , img01:  isUserLogin ? "arrowEnable" : "arrow" , isUserLogin : isUserLogin)
                            ViewCustom(title: "My orders" , img1: isUserLogin ?  "022" : "22" , img01: isUserLogin ? "arrowEnable" : "arrow", isUserLogin : isUserLogin){
                                destination = AnyView(YourOrderScreen())
                                ispush = true
                            }
                            ViewCustom(title: "Addresses" , img1: isUserLogin ?  "033" : "33" , img01: isUserLogin ? "arrowEnable" : "arrow", isUserLogin : isUserLogin)
                            ViewCustom(title: "Payment" , img1: isUserLogin ?  "044" : "44" , img01: isUserLogin ? "arrowEnable" : "arrow", isUserLogin : isUserLogin)
                            ViewCustom(title: "Wishlist" , img1: isUserLogin ?  "055" : "55" , img01: isUserLogin ? "arrowEnable" : "arrow", isUserLogin : isUserLogin)
                            ViewCustom(title: "Settings" , img1: "66" , img01: "arrowEnable", isUserLogin : true)
                            ViewCustom(title: "Languages" , img1:"77" , img01: "arrowEnable", isUserLogin : true){
                                
                            }
                            ViewCustom(title: "LogOut" , img1: isUserLogin ?  "088" : "88" , img01: isUserLogin ? "arrowEnable" : "arrow", isUserLogin : isUserLogin){
                                Helper.shared.logout()
                            Helper.shared.changeRoot(toView: SignInScreen(hasnavbar: false))

                            }
                            Spacer()
                            Spacer()
                            
                        }
                        .padding(10)
                        .background(.white)
                        .cornerRadius(30)
                    }
                }
            }
            NavigationLink(
                destination: destination,
                isActive: $ispush,label: {}
            )
        }
        .hideNavigationBar()
        .localizeView()
        .background(Color("bg1"))
        .ignoresSafeArea()
    }
    
    
    struct  ViewCustom :  View {
        @State var title : String = ""
        @State var img1 : String = ""
        @State var img01 : String = ""
        @State var isUserLogin : Bool = false
        var action:(() -> Void?)?
        var body: some View {
            Button(action: {
                action?()
            }, label: {
            HStack (spacing : 15) {
                Image(img1)
                    .resizable()
                    .frame(width: 40 , height: 40)
                Text(title)
                    .font(.custom("LamaSans-Bold", size: 12))
                    .foregroundColor(isUserLogin ? Color("main1") :  Color("secondary"))
                Spacer()
                Image(img01)
                    .frame(width: 50 , height: 50)
            }
            .frame(height: 60)
            .padding(.horizontal , 8)
                
            })
        }
    }
}

struct  ViewCustomUserIsSigned :  View {
    var signInAction:(() -> Void?)?
    var signUpAction:(() -> Void?)?

    var body: some View {
        
        VStack {
            
            Text("Sign in to your account or Sign up for new account".localized())
                .font(.custom(fontEnum.medium.rawValue, size: 14))
                .foregroundColor(Color("main1"))
                .multilineTextAlignment(.center)
            Spacer()
            Button(action: {
                //Sign in
                signInAction?()
            }, label: {
                Text("Sign in".localized())
                    .frame(height: 50) // Set the height here
                    .frame(maxWidth: .infinity)
                    .font(.custom(fontEnum.medium.rawValue, size: 14))
                    .foregroundColor(Color("bg1")).background(Color("main2"))
                    .cornerRadius(10)
            })
            Spacer()
            Button(action: {
                //Sign up
                signUpAction?()
            }, label: {
                Text("Sign up".localized())
                    .frame(height: 50) // Set the height here
                    .frame(maxWidth: .infinity)
                    .font(.custom(fontEnum.medium.rawValue, size: 14))
                    .foregroundColor(Color("main2")).background(.white)
                    .cornerRadius(10)
                    .padding(.horizontal , 20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("main2"), lineWidth: 2) // Adjust color and width as needed
                    )
            })
        }
        .frame(maxWidth: .infinity)
        .padding(30)
    }
}

struct  ViewCustomUserNotSigned :  View {
    
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented = false
    @State  var Name : String = ""
    @State  var Balance : String = ""

    
    var body: some View {
        
        VStack {
          
            ZStack(alignment: .bottomTrailing) {
                      // Circular image
                      if let selectedImage = selectedImage {
                          Image(uiImage: selectedImage)
                              .resizable()
                              .scaledToFill()
                              .frame(width: 120, height: 120)
                              .clipShape(Circle())
                              .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                              .shadow(radius: 5)
                      } else {
                          Image(systemName: "person.crop.circle.fill")
                              .resizable()
                              .scaledToFill()
                              .frame(width: 120, height: 120)
                              .foregroundColor(.gray)
                              .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                              .shadow(radius: 5)
                      }

                      // Camera icon button
                      Button(action: {
                          isImagePickerPresented = true
                      }) {
                          Image("edit")
                              .resizable()
                              .frame(width: 40, height: 40)
                              .foregroundColor(.blue)
                              .background(Color.white)
                              .clipShape(Circle())
                              .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                      }
                      .offset(x: 13, y: -10)
                  }
                  .sheet(isPresented: $isImagePickerPresented) {
                      ImagePicker(selectedImage: $selectedImage)
                  }
              
        
            
            Spacer()
            Text(Name)
                .font(.custom("LamaSans-Bold", size: 14))
                .foregroundColor(Color("main1"))
            Spacer()
            Text(Balance)
                .font(.custom(fontEnum.medium.rawValue, size: 13))
                .foregroundColor(Color("main2"))
            
        }
        .frame(maxWidth: .infinity)
        .padding(30)
    }
}


// Image picker view to select an image from the photo library
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            picker.dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}


#Preview {
    ProfileView()
}
