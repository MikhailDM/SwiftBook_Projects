//
//  TopView.swift
//  SwiftUIFirstDemo
//
//  Created by Алексей Пархоменко on 05.06.2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import SwiftUI

struct TopView: View {
    
    var user: UserResponse
    
    var body: some View {
        HStack(spacing: 8.0) {
            Image(user.profileImage)
                .resizable()
                .frame(width: 70, height: 70)
                .clipShape(Circle())
            VStack(alignment: .leading, spacing: 4) {
                Text(user.name)
                    .font(.title)
                HStack {
                    Text(user.email)
                        .font(.subheadline)
                    Spacer()
                    Image("like")
                        .accentColor(.red)
                    Text(user.likes)
                        .font(.subheadline)
                }
            }
        }
    }
}

#if DEBUG
struct TopView_Previews : PreviewProvider {
    static var previews: some View {
        TopView(user: userResponse[0])
    }
}
#endif
