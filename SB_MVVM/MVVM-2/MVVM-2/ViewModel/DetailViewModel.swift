//
//  DetailViewModel.swift
//  MVVM-2
//
//  Created by Михаил Дмитриев on 05.05.2020.
//  Copyright © 2020 Mikhail Dmitriev. All rights reserved.
//

import Foundation

class DetailViewModel: DetailViewModelType {
    private var profile: Profile
    
    var description: String {
        return String (describing: "\(profile.name) \(profile.secondName) \(profile.age)")
    }
    
    var age: Box<String?> = Box(nil)
    
    init(profile: Profile) {
        self.profile = profile
    }    
}
