//
//  AddNewCardViewModel.swift
//  Hayak
//
//  Created by wecancity on 19/01/2025.
//

import Foundation

class AddNewCardViewModel: BaseViewModel {
    static let shared = AddNewCardViewModel()
    
    //    MARK: --- inputs ---
    //    @Published var maxResultCount = 10
    //    @Published var skipCount = 0
    
    @Published var CardHolderName: String = ""
     @Published var CardNumber: String = ""
     @Published var CardExpireDate: String = ""
     @Published var CardCVVCode: String = ""
    
    @Published var isCheckoutConfirmed : Bool = false

    //    MARK: --- outpust ---
    @Published var isLoading : Bool?
    @Published var isError : Bool = false
    @Published var error: AlertType = .error(title: "", image: "", message: "", buttonTitle: "", secondButtonTitle: "")
    
    //    @Published var isTeacherHasSubjects: Bool = false
    @Published var checkout : CheckoutM?
    
    
    @Published var isCartDeleted : Bool = false
    @Published var dismissCart : Bool = false

    override init(){
        
    }
}

extension AddNewCardViewModel{
    
//    func GetCheckout(){
//        let target = PickupServices.GetCheckout
//        DispatchQueue.main.async { [weak self] in
//            self?.isLoading = true
//        }
//        handleAPI(target: target, responseType: CheckoutM.self, onSuccess: { [weak self] data in
//            self?.checkout = data
//            self?.isLoading = false
//        }, onFailure: { [weak self] error in
//            self?.isError = true
//            self?.error = .error(image: nil, message: error.localizedDescription, buttonTitle: "Done")
//            self?.isLoading = false
//        })
//        
//    }
    
    func ConfirmCheckout(){
        guard let params = checkout?.toDictionary() else {return}
        let parameters:[String:Any] = params
        
        let target = PickupServices.ConfirmCheckout(parameters: parameters)
        DispatchQueue.main.async { [weak self] in
            self?.isLoading = true
        }
        handleAPI(target: target, responseType: [NearestBrandBrancheM].self, onSuccess: { [weak self] data in
            self?.isCheckoutConfirmed = true
            self?.isLoading = false
        }, onFailure: { [weak self] error in
            self?.isError = true
            self?.error = .error(image: nil, message: error.localizedDescription, buttonTitle: "Done")
            self?.isLoading = false
        })
        
    }
    
//    func cleanup() {
//        // Cancel any ongoing Combine subscriptions
//        cancellables.forEach { cancellable in
//            cancellable.cancel()
//        }
//        cancellables.removeAll()
//    }
}



//MARK: --- validations ---
extension AddNewCardViewModel{
    
    // Function to be called when text changes (from the view)
       func updateCardHolderName(_ input: String) {
           CardHolderName = formatCardHolderName(input)
       }
       
       func updateCardNumber(_ input: String) {
           CardNumber = formatCardNumber(input)
       }
       
       func updateExpDate(_ input: String) {
           CardExpireDate = formatExpDate(input)
       }
       
       func updateCVV(_ input: String) {
           CardCVVCode = limitCVV(input)
       }
    
    
    
    // Capitalize each word in the name
     private func formatCardHolderName(_ input: String) -> String {
         return input.uppercased()
     }

     // Format card number with spaces every 4 digits and limit to 16 digits
     private func formatCardNumber(_ input: String) -> String {
         let cleaned = input.filter { $0.isNumber }.prefix(16)
         let formatted = cleaned.enumerated().map { index, character in
             index > 0 && index % 4 == 0 ? " \(character)" : "\(character)"
         }.joined()
         return formatted
     }

     // Format expiration date to MM/yy, limit input, and validate month/year
     private func formatExpDate(_ input: String) -> String {
         var cleaned = input.filter { $0.isNumber }
         if cleaned.count > 4 {
             cleaned = String(cleaned.prefix(4))
         }
         if cleaned.count > 2 {
             cleaned.insert("/", at: cleaned.index(cleaned.startIndex, offsetBy: 2))
         }

         if cleaned.count == 5 {
             let components = cleaned.split(separator: "/")
             if let month = Int(components[0]), let year = Int(components[1]) {
                 let currentYear = Calendar.current.component(.year, from: Date()) % 100
                 if month < 1 || month > 12 {
                     return String(cleaned.prefix(0))
                 }
                 if year < currentYear {
                     return String(cleaned.prefix(0))
                 }
             }
         }

         return cleaned
     }

     // Limit CVV to 4 digits
     private func limitCVV(_ input: String) -> String {
         return String(input.filter { $0.isNumber }.prefix(4))
     }

}


