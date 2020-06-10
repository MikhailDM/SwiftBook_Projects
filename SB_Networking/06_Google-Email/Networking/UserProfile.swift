//
//  UserProfile.swift
//  Networking
//
//  Created by Alexey Efimov on 09/10/2018.
//  Copyright © 2018 Alexey Efimov. All rights reserved.
//

import Foundation

struct UserProfile {
    
    let id: Int?
    let name: String?
    let email: String?
    
    init(data: [String: Any]) {
        let id = data["id"] as? Int
        let name = data["name"] as? String
        let email = data["email"] as? String
        
        self.id = id
        self.name = name
        self.email = email
    }
}
