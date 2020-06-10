//
//  CurrentUser.swift
//  Networking
//
//  Created by Alexey Efimov on 10/10/2018.
//  Copyright © 2018 Alexey Efimov. All rights reserved.
//

import Foundation

struct CurrentUser {
    
    let uid: String
    let name: String
    let email: String
    
    init?(uid: String, data: [String: Any]) {
        
        guard
            let name = data["name"] as? String,
            let email = data["email"] as? String
            else { return nil }
        
        self.uid = uid
        self.name = name
        self.email = email
    }
}
