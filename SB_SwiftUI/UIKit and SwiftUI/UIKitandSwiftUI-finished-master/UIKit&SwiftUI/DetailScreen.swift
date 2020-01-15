//
//  DetailScreen.swift
//  UIKit&SwiftUI
//
//  Created by Алексей Пархоменко on 16/06/2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import SwiftUI

struct DetailScreen : View {
    
    var object: Post
    
    var body: some View {
        VStack(spacing: 16.0) {
            VStack(spacing: 20.0) {
                MainImage(object: object)
                Text(object.text)
                    .lineLimit(nil)
                    .font(.title)
            }
            VStack(alignment: .leading, spacing: 12.0) {
                Text("Описание")
                    .font(.title)
                Text(object.descriprion)
                    .lineLimit(nil)
            }
            Spacer()
            }.padding()
    }
}

struct MainImage: View {
    
    var object: Post
    
    var body: some View {
        Image(uiImage: object.image)
            .resizable()
            .cornerRadius(30)
            .frame(width: 170, height: 170)
            .border(Color.gray, width: 3, cornerRadius: 30)
            .shadow(radius: 10)
    }
}


