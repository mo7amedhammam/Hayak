//
//  PicUpView.swift
//  Hayak
//
//  Created by Mohamed Ragab on 22/07/2024.
//

import SwiftUI
import Kingfisher

enum menuFilterCases:String{
    case sort = "Sort"
    case Radius = "Radius"
    case Rate = "Rate"
    
}

// get list for main cetegory > Brand/GetCategoriesWithBrand
// send : categoryId
// default : send current lat & lon
/// will have an api to select radius 5km , 10km , or 20km
/// will send distance from its selection
// sortBy : rate, recommendation,distance
//call this endpoint :Pickup/NearestBrandBranches (with previous parameters)

struct PicUpView: View {
    //    @Environment(\.presentationMode) var presentationMode
    @StateObject var pickupvm = MainPickUpVM.shared
    @StateObject var locationManager = LocationManagerVM.shared

    @State var isActive : Bool = false
    @State var destination : AnyView = AnyView(EmptyView())
    
    @State private var items = [
        OrderStatus(id : 0 ,name: menuFilterCases.sort.rawValue,iconstr: "sorticon"),
        OrderStatus(id : 1 ,name: menuFilterCases.Radius.rawValue,iconstr:"mapwithpin"),
        OrderStatus(id : 2 ,name: menuFilterCases.Rate.rawValue,iconstr:"starempty")
    ]
    @State var selectedsort : OrderStatus?
    @State var selectedradius : Int?
    @State var selectedrate : Int?
    
    var body: some View {
        VStack {
            CustomPickupHeaderView(title: "Saudi Arabia", subtitle: "Al Riadh city",btnbackimg: nil, onBack: {}, btnimg2:Image(.shoppingiconfill), onbtnimg2: {}, btnimg3: Image(.favoriteiconempty), onbtnimg3: {}, btnimg4: Image("carbon_search"), onbtnimg4: {})
                .padding(.horizontal)
            
            VStack {
                Text("All restaurants")
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .foregroundColor(.activeText)
                    .font(.custom(fontEnum.bold.rawValue, size:14))
                    .padding(.top)
                    .padding(.bottom,5)
                    .padding(.horizontal)
                
                restaurantsScrollView(resturants: pickupvm.Categories ?? [] ,selectedResturant: $pickupvm.selectedCategory)
                    .frame(height: 120)
                
                ScrollView(.horizontal){
                    HStack(spacing: 10) {
                        ForEach(items){ item in
                            let isselected = (item.id == 0 && selectedsort != nil) || (item.id == 1 && selectedradius != nil) || (item.id == 2 && selectedrate != nil)
                            
                            cpsuleBtnView(item: item,isselecteditem: .constant(isselected),onAction: {
                                if item.id == 0{
                                    // show sort options
                                    selectedsort = item
                                }else if item.id == 1{
                                    // show sort options
                                    selectedradius = 5
                                }else if item.id == 2{
                                    // show rate options
                                    selectedrate =  selectedrate == nil ? 4 : nil
                                }
                                
                            })
                            .frame(height:35)
                            //                            .tag(item.id)
                        }
                    }
                    .padding(.leading,2)
                    .padding(.top,5)
                }
                
                List(pickupvm.NearestBrandBranches ?? [],id:\.self){branch in
                    pickUpCellView(pickUp: branch ,onSelect: {
                        guard let id = branch.id else {return}
                        destination = AnyView( MenueView(SelectedBranchId: id).environmentObject(locationManager) )
                        self.isActive = true
                    },onClickLove: {
                        
                    })
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .padding(5)
                    
                }
                .listStyle(.plain)
                .padding(.horizontal,-12)
            }
            //                        .padding(.horizontal)
            .background{
                Color(.bg1).ignoresSafeArea()
                    .navigationBarBackButtonHidden(true)
            }
            Spacer()
            NavigationLink(
                destination: destination,
                isActive: $isActive,
                label: {EmptyView()})
        }
        .background{
            Color(.white).ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
        }
        .task {
            pickupvm.lat = locationManager.Currentlat
            pickupvm.lon = locationManager.Currentlong

            pickupvm.GetCategories()
            pickupvm.GetNearestBrandBranches()
        }
        .showHud(isShowing: $pickupvm.isLoading)
        .showAlert(hasAlert: $pickupvm.isError, alertType: pickupvm.error)
    }
}

#Preview {
    PicUpView()
}

