//
//  CategoryRow.swift
//  SwiftUIFirstDemo
//
//  Created by Алексей Пархоменко on 06.06.2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import SwiftUI

struct CategoryRow : View {
    
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
                        NavigationButton(destination: DetailScreen(object: object)) {
                            CategoryItem(object: object)
                        }
                        
                    }
                }
            }
                .frame(height: 190)
        }
    }
}

#if DEBUG
struct CategoryRow_Previews : PreviewProvider {
    static var previews: some View {
        CategoryRow(
            categoryName: materialResponse[0].category.rawValue,
            items: Array(materialResponse.prefix(3))
            
        )
    }
}
#endif
