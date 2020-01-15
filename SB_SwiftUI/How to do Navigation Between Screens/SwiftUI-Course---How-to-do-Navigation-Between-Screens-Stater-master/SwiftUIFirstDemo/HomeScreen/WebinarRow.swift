//
//  WebinarRow.swift
//  SwiftUIFirstDemo
//
//  Created by Алексей Пархоменко on 07.06.2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import SwiftUI

struct WebinarRow : View {
    
    var categoryName: String
    var items: [ProductsResponse]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(self.categoryName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
            
            ScrollView(showsHorizontalIndicator: false) {
                HStack(alignment: .center, spacing: 0) {
                    ForEach(self.items.identified(by: \.name)) { object in
                            WebinarItem(object: object)
                    }
                }
            }
            .frame(height: 210)
        }
    }
}

#if DEBUG
struct WebinarRow_Previews : PreviewProvider {
    static var previews: some View {
        WebinarRow(categoryName: "Webinars", items: Array(materialResponse.dropFirst(4)))
    }
}
#endif
