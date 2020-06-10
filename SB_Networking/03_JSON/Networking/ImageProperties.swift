//
//  ImageProperties.swift
//  Networking
//
//  Created by Михаил Дмитриев on 10.06.2020.
//  Copyright © 2020 Alexey Efimov. All rights reserved.
//

import UIKit

struct ImageProperties {
    let key: String
    let data: Data
    
    //Failable init
    init?(withImage image: UIImage, forKey key: String) {
        self.key = key
        guard let data = image.pngData() else { return nil }
        self.data = data
    }
}
