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
    case Recommendation = "Recommendation"
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
    @EnvironmentObject var pickupvm: MainPickUpVM
    @StateObject var locationManager = LocationManagerVM.shared
    
    @State var isActive : Bool = false
    @State var destination : AnyView = AnyView(EmptyView())
    
    @State private var items = [
        OrderStatus(id : 0 ,name: menuFilterCases.sort.rawValue,iconstr: "sorticon"),
        OrderStatus(id : 1 ,name: menuFilterCases.Radius.rawValue,iconstr:"mapwithpin"),
        OrderStatus(id : 2 ,name: menuFilterCases.Rate.rawValue,iconstr:"starempty")
    ]
    //    @State var selectedsort : OrderStatus?
    var isshowingcart:Bool? = false
    
    @State var showSort = false
    let options = ["Recommendation", "Top Rated", "Distance"]
    @State private var selectedsort: String?
    
    @State var showRadius = false
    let Radiusoptions = [5, 10, 15, 20]
    
    @State var showRate = false
    let Rateoptions = [1, 2, 3, 4, 5]
    
    @State var selectedradius : Int?
    @State var selectedrate : Int?
    
    
    //    var islistingfavourites:Bool? = false
    var hasbackBtn:Bool? = false
    //    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            CustomPickupHeaderView(title: "Saudi Arabia", subtitle: "Al Riadh city",btnbackimg: hasbackBtn ?? false ? Image(.circleback):nil, onBack: {
                pickupvm.islistingfavourites = false
            }, btnimg2:Image(.shoppingiconfill), onbtnimg2: {
                
                guard isshowingcart == false else {return}
                let checkoutvm = CheckoutVM.shared
                checkoutvm.GetCheckout()
                let view = PickUpCheckoutView()
                    .environmentObject(checkoutvm)
                    .environmentObject(ItemDetailsVM.shared)
                destination = AnyView(view)
                isActive = true
                
            }, btnimg3: Image(pickupvm.islistingfavourites ? .favoriteiconfill:.favoriteiconempty), onbtnimg3: {
                
                guard pickupvm.islistingfavourites == false else {return}
                print("list favourites")
                var view = PicUpView()
                pickupvm.islistingfavourites = true
                view.hasbackBtn = true
                pickupvm.GetFavouriteBrandBranches()
                destination = AnyView(view                            .environmentObject(pickupvm)
                )
                isActive = true
                
            }, btnimg4: Image("carbon_search"), onbtnimg4: {})
            .padding(.horizontal)
            
            VStack {
                Text("All restaurants".localized())
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .foregroundColor(.activeText)
                    .font(.custom(fontEnum.bold.rawValue, size:14))
                    .padding(.top)
                    .padding(.bottom,5)
                    .padding(.horizontal)
                
                restaurantsScrollView(resturants: pickupvm.Categories ?? [] ,selectedResturant: $pickupvm.selectedCategory)
                    .frame(height: 120)
                    .padding(.leading)
                    .onChange(of: pickupvm.selectedCategory){_ in
                        Task{
                            if pickupvm.islistingfavourites == true{
                                pickupvm.GetFavouriteBrandBranches()
                            }else{
                                pickupvm.GetNearestBrandBranches()
                            }
                        }
                    }
                
                
                HStack(spacing: 10) {
                    ForEach(items.filter { !(pickupvm.islistingfavourites && $0.id > 0) }) { item in
                        let isselected = (item.id == 0 && selectedsort != nil) || (item.id == 1 && selectedradius != nil) || (item.id == 2 && selectedrate != nil)
                        if item.id == 1 {
                            Spacer()
//                                .frame(maxWidth: .infinity)
                        }
                        
                        cpsuleBtnView(item: item,isselecteditem: .constant(isselected),onAction: {
                            switch item.id {
                            case 0: showSort = true
                            case 1: showRadius = true
                            case 2: showRate = true
                            default: break
                            }
                        })
                        .frame(height:40)
                    }
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.horizontal)
                .padding(.top,5)
                
                List(pickupvm.NearestBrandBranches ?? [],id:\.self){branch in
                    pickUpCellView(pickUp: branch ,onSelect: {
                        guard let id = branch.id else {return}
                        destination = AnyView( MenueView(SelectedBranchId: id).environmentObject(locationManager) )
                        self.isActive = true
                    },onClickLove: {
                        guard let id = branch.id else {return}
                        pickupvm.AddToFavourit(brandBranchId: id)
                        
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
        .hideNavigationBar()
        .background{
            Color(.white).ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
        }
        .task {
            guard pickupvm.islistingfavourites == false && isshowingcart == false else { return }
            pickupvm.lat = locationManager.Currentlat
            pickupvm.lon = locationManager.Currentlong
            
            await withTaskGroup(of: Void.self) { group in
                group.addTask {
                    await pickupvm.GetCategories()
                    //                }
                    //                group.addTask {
                    await pickupvm.GetNearestBrandBranches()
                }
            }
        }
        .showHud(isShowing: $pickupvm.isLoading)
        .showAlert(hasAlert: $pickupvm.isError, alertType: pickupvm.error)
        .fullScreenCover(isPresented: .constant(showSort || showRadius || showRate), onDismiss: {
            //            guard pickupvm.sortBy != nil else {return}
            //            pickupvm.GetNearestBrandBranches()
        }, content: {
            
            if showSort{
                BottomSheetView1(isPresented: $showSort, content: {
                    VStack(){
                        ZStack (alignment:.trailing){
                            HStack {
                                Image(.sorticon)
                                    .renderingMode(.template)
                                    .frame(width: 25, height: 29)
                                Text("Sort By".localized())
                                    .foregroundColor(.main1)
                                    .font(Font.Bold(size: 14))
                                
                            }
                            .frame(maxWidth: .infinity)
                            
                            Button(action: {
                                showSort = false
                            }) {
                                Image(systemName: "xmark")
                                //                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.red)
                            }
                            //                            .padding()
                        }
                        .padding(.vertical)
                        
                        
                        // Sorting options list
                        VStack(alignment: .leading, spacing: 20) {
                            ForEach(options, id: \.self) { option in
                                Button(action: {
                                    selectedsort =  selectedsort == option ? nil:option
                                    
                                    if items[0].name != selectedsort{
                                        items[0].name =  selectedsort ?? "Sort By"
                                        //                                        items[0].id = 1
                                        pickupvm.sortBy = selectedsort
                                        
//                                        guard pickupvm.sortBy != nil else {return}
                                        pickupvm.GetNearestBrandBranches()
                                        
                                    }else{
                                        items[0].name = "Sort By"
                                        //                                        items[0].id = 0
                                        pickupvm.sortBy = nil
                                    }
                                    pickupvm.GetNearestBrandBranches()

                                }, label: {
                                    HStack {
                                        Text(option.localized())
                                            .foregroundColor(.main1)
                                            .font(Font.Bold(size: 14))
                                        
                                        Spacer()
                                        Image(selectedsort == option ? "RadioButton-fill" : "RadioButton-empty")
                                            .foregroundColor(.main1)
                                    }
                                })
                            }
                        }
                        .padding(.top,10)
                        .padding(.bottom,20)
                        
                        
                        
                    }
                    //                    .frame(maxWidth: .infinity)
                    .padding(.all)
                    .background(.white)
                    
                })
                
            }else if showRadius{ //radius
                
                BottomSheetView1(isPresented: $showRadius, content: {
                    VStack(){
                        ZStack (alignment:.trailing){
                            HStack {
                                Image(.sorticon)
                                    .renderingMode(.template)
                                    .frame(width: 25, height: 29)
                                Text("Filter Radius Within".localized())
                                    .foregroundColor(.main1)
                                    .font(Font.Bold(size: 14))
                                
                            }
                            .frame(maxWidth: .infinity)
                            
                            Button(action: {
                                showRadius = false
                            }) {
                                Image(systemName: "xmark")
                                //                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.red)
                            }
                            //                            .padding()
                        }
                        .padding(.vertical)
                        
                        
                        // Sorting options list
                        VStack(alignment: .leading, spacing: 20) {
                            ForEach(Radiusoptions, id: \.self) { option in
                                Button(action: {
                                    selectedradius =  selectedradius == option ? nil:option
                                    
                                    if selectedradius != nil{
                                        items[1].name =  "\(selectedradius ?? 0) KM"
                                        //                                        items[1].id = 1
                                        pickupvm.Radius = selectedradius
                                        
//                                        guard pickupvm.Radius != nil else {return}
                                        pickupvm.GetNearestBrandBranches()
                                        
                                    }else{
                                        items[1].name = "Radius"
                                        //                                        items[1].id = 0
                                        pickupvm.Radius = nil
                                        pickupvm.GetNearestBrandBranches()
                                    }
                                    
                                }, label: {
                                    HStack {
                                        Text(option,format: .number)
                                            .foregroundColor(.main1)
                                            .font(Font.Bold(size: 14))
                                        
                                        Text("KM".localized())
                                            .foregroundColor(.main1)
                                            .font(Font.Bold(size: 14))
                                        
                                        Spacer()
                                        Image(selectedradius == option ? "RadioButton-fill" : "RadioButton-empty")
                                            .foregroundColor(.main1)
                                    }
                                })
                            }
                        }
                        .padding(.top,10)
                        .padding(.bottom,20)
                    }
                    .padding(.all)
                    .background(.white)
                    
                })
            }else { // rate
                BottomSheetView1(isPresented: $showRate, content: {
                    VStack(){
                        ZStack (alignment:.trailing){
                            HStack {
                                Image(.sorticon)
                                    .renderingMode(.template)
                                    .frame(width: 25, height: 29)
                                Text("Filter With Rate".localized())
                                    .foregroundColor(.main1)
                                    .font(Font.Bold(size: 14))
                                
                            }
                            .frame(maxWidth: .infinity)
                            
                            Button(action: {
                                showRate = false
                            }) {
                                Image(systemName: "xmark")
                                //                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.red)
                            }
                            //                            .padding()
                        }
                        .padding(.vertical)
                        
                        // Sorting options list
                        VStack(alignment: .leading, spacing: 20) {
                            ForEach(Rateoptions, id: \.self) { option in
                                Button(action: {
                                    selectedrate =  selectedrate == option ? nil:option
                                    
                                    if selectedrate != nil{
                                        items[2].name = String(Float(selectedrate ?? 0))
                                        //                                        items[2].id = 2
                                        pickupvm.Rate = selectedrate
                                        
//                                        guard pickupvm.Rate != nil else {return}
                                        pickupvm.GetNearestBrandBranches()
                                        
                                    }else{
                                        items[2].name = "Rate"
                                        //                                        items[2].id = 0
                                        pickupvm.Rate = nil
                                        pickupvm.GetNearestBrandBranches()
                                    }
                                    
                                }, label: {
                                    HStack {
                                        Text(option,format: .number)
                                            .foregroundColor(.main1)
                                            .font(Font.Bold(size: 14))
                                        
                                        Spacer()
                                        Image(selectedrate == option ? "RadioButton-fill" : "RadioButton-empty")
                                            .foregroundColor(.main1)
                                    }
                                })
                            }
                        }
                        .padding(.top,10)
                        .padding(.bottom,20)
                    }
                    .padding(.all)
                    .background(.white)
                    
                })
            }
        })
        
        //        .bottomSheet(isPresented: $showSort){
        //            VStack{
        //                Text("Sort By".localized())
        //            }
        //            .padding(.bottom,100)
        //
        //        }
    }
}

#Preview {
    PicUpView()
        .environmentObject(MainPickUpVM.shared)
}


struct BackgroundClearView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

