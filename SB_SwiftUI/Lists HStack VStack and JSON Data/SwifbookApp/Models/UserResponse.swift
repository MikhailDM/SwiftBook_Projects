//
//  UserResponse.swift
//  SwiftUIFirstDemo
//
//  Created by Алексей Пархоменко on 05.06.2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct UserResponse: Hashable, Codable, Identifiable {
    var id: Int
    
    var name: String
    var profileImage: String
    var email: String
    var likes: String
    var text: String
}

