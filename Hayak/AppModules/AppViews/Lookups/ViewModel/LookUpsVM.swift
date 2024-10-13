//
//  LookUpsVM.swift
//  Hayak
//
//  Created by wecancity on 13/10/2024.
//

//import Combine

//class LookUpsVM: ObservableObject {
//    static let share = LookUpsVM()
//    private var cancellables: Set<AnyCancellable> = []
//    
//    @Published var searchArray: [EducationTypeM] = []{
//        didSet{
//            if !EducationTypesArray.isEmpty {
//                // Use map to transform GendersM into DropDownOption
//                EducationTypesList = EducationTypesArray.map { gender in
//                    return DropDownOption(id: gender.id, Title: gender.name)
//                }
//            }else{
//                EducationTypesList.removeAll()
//            }
//        }
//    }
//    @Published var searchList: [DropDownOption] = []
//    
//}
