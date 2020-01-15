//
//  ContentView.swift
//  SwifbookApp
//
//  Created by Алексей Пархоменко on 08.06.2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    var body: some View {
        NavigationView {
            List(userResponse) { user in
                Cell(user: user)
            }
            .navigationBarTitle(Text("Friends"))
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
