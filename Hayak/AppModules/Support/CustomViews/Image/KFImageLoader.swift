//
//  KFImageLoader.swift
//  Hayak
//
//  Created by wecancity on 31/08/2024.
//

import Kingfisher
import SwiftUI

struct KFImageLoader: View {
    let urlStr: String?
    let placeholder: Image
    
    init(urlStr: String?, placeholder: Image = Image(systemName: "photo")){
        self.urlStr = urlStr
        self.placeholder = placeholder
    }
    
    var body: some View {
        KFImage(URL(string: urlStr?.reverseSlaches() ?? ""))
            .placeholder {
                placeholder
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(8)
    }
}
