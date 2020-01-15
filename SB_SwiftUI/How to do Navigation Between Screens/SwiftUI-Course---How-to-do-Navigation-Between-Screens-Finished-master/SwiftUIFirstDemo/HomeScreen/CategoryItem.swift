//
//  CategoryItem.swift
//  SwiftUIFirstDemo
//
//  Created by Алексей Пархоменко on 06.06.2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import SwiftUI

struct CategoryItem : View {
    
    var object: ProductsResponse
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0) {
            Image(object.image)
                .resizable()
                .renderingMode(.original)
                .cornerRadius(10)
                .frame(width: 170, height: 170)
            }.padding(.leading, 15)
    }
}

#if DEBUG
struct CategoryItem_Previews : PreviewProvider {
    static var previews: some View {
        CategoryItem(object: materialResponse[4])
    }
}
#endif
